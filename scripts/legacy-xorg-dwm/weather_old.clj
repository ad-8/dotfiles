#!/usr/bin/env bb
(ns weather-old
  (:require  [babashka.http-client :as http]
             [babashka.process :refer [shell]]
             [cheshire.core :as json]
             [clojure.edn :as edn]
             [clojure.java.io :as io]
             [clojure.walk]))

(import 'java.time.format.DateTimeFormatter)

(def settings-file (io/file (System/getProperty "user.home") "my" "cfg" "weather.edn"))

(when-not (.exists settings-file)
  (println "weather: no api key")
  (System/exit 0))

(def settings (-> settings-file slurp edn/read-string))
(def current-place (get-in settings [:locations (:curr-loc settings)]))


(defn timestamp->datetime
  "Converts a unix timestamp (in seconds) to a java.time.ZonedDateTime object
   with the local (system default) time zone."
  [ts]
  (let [instant (java.time.Instant/ofEpochSecond ts)
        zone-id (java.time.ZoneId/systemDefault)
        zoned-dt (.atZone instant zone-id)]
    zoned-dt))


;; https://openweathermap.org/api/one-call-api
;;
;; "One Call API 2.5 will be deprecated in June 2024." => actually stopped working for me 2024-09-12 
;;
;; "Please note, the One Call API 3.0 subscription requires credit card details."
;; => RIP after using the same api key for years (first in a script when learning python)
(defn make-request []
  (let [url    "https://api.openweathermap.org/data/2.5/onecall"
        params {:query-params {:appid   (:appid settings)
                               :lat     (:lat current-place)
                               :lon     (:lon current-place)
                               :units   "metric"
                               :exclude "minutely,hourly"}}]
    (http/get url params)))


(comment
  (make-request)


  ;;
  )


(defn format-number
  "Sometimes the temperature from the API is an even number like 4,
  which, when formatted with the format string used below, throws an exception
  when used with an integer, so we need to explicitly parse to a float"
  [num]
  (format "%.0f" (float num)))

(defn parse-day [d]
  (let [dt  (get d :dt)
        min (get-in d [:temp :min])
        max (get-in d [:temp :max])
        min-fmt (format-number min)
        max-fmt (format-number max)
        main (-> d :weather first :main)
        desc (-> d :weather first :description)
        d-fmt (format "%s %s %s" min-fmt max-fmt desc)]

    {:dt dt     :summary d-fmt
     :min min   :min-fmt min-fmt
     :max max   :max-fmt max-fmt
     :main main :desc desc}))

(defn dt->hhmm
  "Formats a ZonedDateTime object as HH:MM"
  [zdt]
   ; time.format(DateTimeFormatter.ofPattern("HH:mm")); / ; sadly doesn't round up the minute if sec >= 30
  (.format zdt (DateTimeFormatter/ofPattern "HH:mm")))

(defn sun-rise-set [fs]
  (let [sunset  (-> fs first :sunset dt->hhmm)
        sunrise (-> fs second :sunrise dt->hhmm)]
    (format "↓%s ↑%s" sunset sunrise)))

(defn download-icon [icon filename]
  (let [url (format "https://openweathermap.org/img/wn/%s.png" icon)]
    (io/copy
     (:body (http/get url {:as :stream}))
     (io/file filename))))


(defn parse-response [resp]
  (let [body (->> resp :body json/parse-string (map clojure.walk/keywordize-keys))
        current (update (->> body     ; seq, count = 6: ("lat" "lon" "timezone" "timezone_offset" "current" "daily")
                             (drop 4)
                             (take 1)
                             first
                             second) :dt timestamp->datetime)
        forecast (->> body
                      (drop 5)
                      first
                      (drop 1)
                      flatten ; lazy seq of maps, count=8 (today 12:00 forecast, tomorrow 12:00 forecast, etc.)
                      (map #(update % :dt timestamp->datetime))
                      (map #(update % :sunrise timestamp->datetime))
                      (map #(update % :sunset timestamp->datetime))
                      (map #(update % :moonrise timestamp->datetime))
                      (map #(update % :moonset timestamp->datetime)))
        temps-next-3-days (->> forecast
                               (drop 1) ; today 12:00
                               (take 3) ; next 3 days, 12:00
                               (map #(:temp %)))
        min (->> temps-next-3-days
                 (apply min-key :min)
                 :min
                 format-number)
        max (->> temps-next-3-days
                 (apply max-key :max)
                 :max
                 format-number)
        curr-temp (-> current :temp format-number)
        curr-desc (-> current :weather first :description)
        curr-icon (-> current :weather first :icon)
        today+1 (->> forecast (drop 1) (take 1) first parse-day)
        today+2 (->> forecast (drop 2) (take 1) first parse-day)]

    (download-icon curr-icon (:icon-path settings))

    {:status (:status resp), :curr-temp curr-temp, :curr-desc curr-desc,
     :sun (sun-rise-set forecast) :body body,
     :forecast forecast, :today+1 today+1, :today+2 today+2}))


(comment
  (-> (make-request)
      (parse-response))
  ;;
  )

; JSON FORMAT for i3status-rs
; {"icon": "...", "state": "...", "text": "...", "short_text": "..."}
(defn print-for-i3bar [{:keys [status curr-temp curr-desc today+1 today+2 sun]}]
  (if (= 200 status)

    {:text (format "%s°C  %s  %s • %s • %s • %s"
                   curr-temp curr-desc (:short current-place)
                   (:summary today+1) (:summary today+2)
                   sun)
     :short_text (format "%s°C   %s   %s"
                         curr-temp curr-desc (:short current-place))}

    {:text (format "Request Error: status code %d" status)}))


(defn print-for-i3bar-short [{:keys [status curr-temp curr-desc]}]
  (if (= 200 status)
    {:text (format "%s°C %s" curr-temp curr-desc)}
    {:text (format "Request Error: status code %d" status)}))


(defn notify-dunst [{:keys [status forecast curr-temp curr-desc today+1 today+2 sun]}]
  (let [today (parse-day (first forecast))
        fmt (format "%s°C  %s  (%s)\n\n%s\n\ntoday:     %s %s %s\ntomorrow:  %s\nday after: %s"
                    curr-temp curr-desc (:short current-place)
                    sun
                    (:min-fmt today) (:max-fmt today) (:desc today)
                    (:summary today+1) (:summary today+2))
        fmt-err (format "Error: status code %d\n" status)]

    (if (= 200 status)
      (shell (format "notify-send --app-name \"%s\" --icon \"%s\" Weather \"%s\"" "dunst-weather" (:icon-path settings) fmt))
      (shell (format "notify-send --app-name \"%s\" Weather \"%s\"" "dunst-weather" fmt-err)))))


(defn dwmblocks [parsed-response]
  (let [location (:short current-place)
        weather (-> parsed-response print-for-i3bar-short :text)
        fmt (format "%s (%s)" weather location)]
    fmt))


(let [arg1 (first *command-line-args*)
      parsed-resp (-> (make-request) parse-response)
      output (case arg1
               "long"   (-> parsed-resp print-for-i3bar json/encode)
               "short"  (-> parsed-resp print-for-i3bar-short json/encode)
               "dwm"    (dwmblocks parsed-resp)
               "dunst"  (notify-dunst parsed-resp)
               ":invalid-argument")]
  (println output))
