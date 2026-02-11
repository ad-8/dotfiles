#!/usr/bin/bb
(ns i3vpn
  (:require [clojure.java.shell :as shell]
            [clojure.string :as str]
            [cheshire.core :as json]))


(defn parse-uptime [s]
  (let [[_ d h m _s] (re-find #"Connection time: (?:(\d+) days?, )?(\d{1,2}):(\d{2}):(\d{2})" s)
        uptime (if (nil? d)
                 (format "%s:%sh" h m)
                 (format "%sd %s:%sh" d h m))]
    uptime))


(defn parse-stdout [stdout]
  (let [lines  (str/split-lines stdout)
        server (-> (nth lines 4) (str/split #"\t") last str/trim)
        ks (-> (nth lines 10) (str/split #"\t") last str/trim)
        ks' (if (= "Permanent" ks) :ok :danger)
        uptime (parse-uptime (last lines))]
    (format " %s %s %s" server uptime ks')))


(defn i3vpn []
  (let [output    (shell/sh "protonvpn-cli" "status")
        exit-code (:exit output)
        stdout    (:out output)
        no-conn   "\nNo active Proton VPN connection.\n"
        args      *command-line-args*]
    (cond
      (not= 0 exit-code) (json/encode {:text "Command failed" :state "Critical" :class "down"})
      (= no-conn stdout) (json/encode {:text "NO VPN CONN" :state "Critical" :class "down"})
      :else              (if (= "dwm" (first args))
                           (parse-stdout stdout)
                           (json/encode {:text (parse-stdout stdout)})))))


(println (i3vpn))
