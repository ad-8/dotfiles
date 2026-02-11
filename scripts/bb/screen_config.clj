#!/usr/bin/env bb
(ns screen-config
  (:require [babashka.process :refer [shell process]]
            [clojure.edn]
            [clojure.java.io :as io]
            [clojure.set]
            [clojure.string :as str]))

(def home (System/getProperty "user.home"))
(def config-dir (io/file home ".screenlayout"))

(def configs (->> config-dir
                  file-seq
                  (filter #(.isFile %))
                  (map #(str/replace % (str config-dir "/") ""))))

(def selected-config (-> (process "echo" "-e" (str/join "\n" configs))
                         (process {:out :string} "dmenu" "-i" "-l" "25" "-p" "Select config to apply")
                         deref :out str/trim))

(comment
  selected-config ; "" or a val
  (when-not (str/blank? selected-config)
    (-> (shell (io/file config-dir selected-config)) :exit)) ; nil if above is "" 
  ;;
  )

(let [nil-or-exit-code (when-not (str/blank? selected-config)
                         (-> (shell (io/file config-dir selected-config)) :exit))]

  (if (= 0 nil-or-exit-code)
    (shell "notify-send" (str "applied " selected-config))
    (shell "notify-send" "no action")))
