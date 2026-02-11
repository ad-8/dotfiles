#!/usr/bin/env bb
(ns ss
  (:require [babashka.process :refer [shell]]
            [clojure.string :as str]
            [cheshire.core :as json]))

(defn timestamp []
  (-> (shell {:out :string} "date +%F_%H-%M-%S")
      :out str/trim))

(defn filename []
  (str (System/getProperty "user.home")
       "/sync/screenshots/"
       (timestamp)
       ".png"))

(defn notify [file]
  (shell "notify-send" "Screenshot saved" (str "(by clj) to " file)))

; grim ~/sync/screenshots/$(date +%F_%H-%M-%S).png 
(defn screenshot-full []
  (let [file (filename)
        result (shell "grim" file)]
    (when (= 0 (:exit result))
      (notify file))))

; grim -g "$(slurp)" ~/sync/screenshots/$(date +%F_%H-%M-%S).png
(defn screenshot-area []
  (let [file (filename)
        geo  (-> (shell {:out :string} "slurp") :out str/trim)
        result (shell "grim" "-g" geo file)]
    (println "the geo is" geo)
    (when (= 0 (:exit result))
      (notify file))))

; hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - ~/sync/screenshots/$(date +%F_%H-%M-%S).png && notify-send "screenshot taken" "saved in ~sync/screenshots" 
; source: arch wiki
(defn screenshot-window []
  (let [file (filename)
        json-str (:out (shell {:out :string} "hyprctl" "-j" "activewindow"))
        data (json/parse-string json-str true) ;; true = keywordize keys
        [x y] (:at data)
        [w h] (:size data)
        geo (format "%d,%d %dx%d" x y w h)
        result (shell "grim" "-g" geo file)]
    #_(clojure.pprint/pprint data)
    (println "active window geometry:" geo)
    (when (= 0 (:exit result))
      (notify file))))


(case (first *command-line-args*)
  "full" (screenshot-full)
  "area" (screenshot-area)
  "window" (screenshot-window)
  (println "Usage: bb ss.clj [full|area|window]"))
