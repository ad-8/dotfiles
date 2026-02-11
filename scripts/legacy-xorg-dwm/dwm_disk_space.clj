#!/usr/bin/env bb
(ns dwm-disk-space
  (:require [babashka.process :refer [shell]]
            [clojure.string :as str]
            [cheshire.core :as json]))

(defn print-free-space [output-fmt]
  (let [free-space-on-root (->> (shell {:out :string} "df -h / --output=avail")
                                :out
                                str/split-lines
                                last
                                str/trim)
        fmt (format "󰋊 %s" free-space-on-root)
        free-space-int (Integer/parseInt (re-find #"\d+" free-space-on-root))
        class (if (< free-space-int 25) :low :ok)
        json (json/encode {:text fmt :class class})]

    (if (= "json" output-fmt)
      (println json)
      (println fmt))))

(defn run []
  (let [args *command-line-args*]
    (if (= "json" (first args))
      (print-free-space "json")
      (print-free-space "text"))))

(run)
