#!/usr/bin/bb
(ns dwl-status
  (:require [babashka.process :refer [shell]]
            [clojure.string :as str]))

(import 'java.time.LocalDateTime
        'java.time.format.DateTimeFormatter)

(def nord
  {:polar1 "#2e3440"
   :polar2 "#3b4252"
   :polar3 "#434c5e"
   :polar4 "#4c566a"
   :snow1  "#d8dee9"
   :snow2  "#e5e9f0"
   :snow3  "#eceff4"
   :frost1 "#8fbcbb"
   :frost2 "#88c0d0"
   :frost3 "#81a1c1"
   :frost4 "#5e81ac"
   :red    "#bf616a"
   :orange "#d08770"
   :yellow "#ebcb8b"
   :green  "#a3be8c"
   :lila   "#b48ead"})

(def formatter (DateTimeFormatter/ofPattern " E dd.MM.  HH:mm"))
(def fmt-sec (DateTimeFormatter/ofPattern "ss"))

(defn run [cmd]
  (let [res (shell {:out :string} cmd)
        code (:exit res)]
    (if (= 0 code)
      (-> res :out str/split-lines first)
      (format "failed to run %s" cmd))))


(defn shell-out
  "Calls cmd only if the current minute is at 0 or 30 seconds."
  [cmd now]
  (let [sec (Integer/parseInt (.format now fmt-sec))]
    (if (= 0 (mod sec 30))
      (run cmd)
      "...")))


;; dwlb -status all 'text ^bg(ff0000)^lm(foot)text^bg()^lm() text'
(defn bg
  "set background color for s"
  [s hex]
  (format "^bg(%s)%s^bg()" hex s))

(defn fg
  "set foreground color for s"
  [s hex]
  (format "^fg(%s)%s^fg()" hex s))

(defn lm
  "set action for left mouse click"
  [s cmd]
  (format "^lm(%s)%s^lm()" cmd s))


(defn vpn [now]
  (let [status (shell-out "/home/ax/scripts/bb/i3vpn.clj dwm" now)]
    (if (str/includes? status "Critical")
      (bg (fg "NO VPN CONN" (:snow3 nord)) (:red nord))
      (fg status (:polar4 nord)))))


(defn try-weather
  "weather scripts sometimes fails with status 429
   and throws a exception"
  [now]
  (try (shell-out "/home/ax/scripts/bb/weather.clj dwm" now)
       (catch Exception e "weather failed")))


(defn format-string
  "A better `(format %s%s%s%s%s%s%s%s%s%s%s ...)`"
  [& args]
  (str/join "" (map #(format "%s" %) args)))


(comment
  (let [now (LocalDateTime/now)]
    (shell-out "pwd" now))

  (def formatter2 (DateTimeFormatter/ofPattern "  e/c dd.MM.  HH:mm"))
  (.format (LocalDateTime/now) formatter2)

  (lm (bg (fg "foo bar baz" (:snow1 nord)) (:red nord)) "cmd-to-run")

  (into (sorted-map) nord)
  ;;
  )


(while true
  (let [now (LocalDateTime/now)
        date (.format now formatter)
        sec (Integer/parseInt (.format now fmt-sec))
        vpn (vpn now)
        weather (try-weather now)
        space (shell-out "/home/ax/scripts/bb/dwm_disk_space.clj" now)
        licht (shell-out "cat /tmp/licht-curr-val" now)
        volume (shell-out "/home/ax/scripts/dwm-volume.sh" now)
        sep (fg " | " (:polar4 nord))
        fmt (format "dwlb -status all '%s'"
                    (format-string
                     (fg weather (:frost1 nord))
                     sep
                     (lm (fg volume (:polar4 nord)) "pavucontrol")
                     sep
                     (fg (str " " licht) (:polar4 nord))
                     sep
                     (fg space (:polar4 nord))
                     sep
                     vpn
                     sep
                     (fg date (:frost1 nord))))]

    (if (= 0 (mod sec 30))
      (shell fmt)
      (Thread/sleep 1000))))
