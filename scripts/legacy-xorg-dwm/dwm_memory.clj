#!/usr/bin/env bb
(ns dwm-memory
  (:require [babashka.process :refer [shell]]
            [clojure.string :as str]
            [cheshire.core :as json]))


; total memory [GiB] as reported by `free -h`
(def host->memory {:ax-mac  7.7
                   :ax-fuji 15.0
                   :ax-bee 27.0})


(defn get-hostname []
  (let [output (:out (shell {:out :string} "hostnamectl"))
        match (re-find #"Static hostname:\s*(\S+)" output)]
    (if match
      (last match)
      "unknown-hostname")))

(defn determine-css-class
  "Determine the css class for waybar."
  [hostname used]
  (let [host-mem (get host->memory (keyword hostname))]
    (if (nil? host-mem)
      (if (> used 5.7) :low :ok)
      (if (> used (- host-mem 2.0)) :low :ok))))

(defn print-memory-info [output-fmt]
  (let [cmd "free -h | awk '/^Mem/ { print $3 \"/\" $2 }' | sed 's/i//g' | sed 's/G//'"
        mem (-> (shell {:out :string} "/usr/bin/env bash -c" cmd)
                :out
                str/trim
                (str/replace "," "."))
        [used _total] (str/split mem #"/")
        class (determine-css-class (get-hostname) (Float/parseFloat used))
        fmt (format "󰍛 %s" mem)
        json (json/encode {:text fmt :class class})]
    (if (= "json" output-fmt)
      (println json)
      (println fmt))))

(defn run []
  (if (= "json" (first *command-line-args*))
    (print-memory-info "json")
    (print-memory-info "text")))

(run)
