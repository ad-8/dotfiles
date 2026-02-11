#!/usr/bin/env bb
(ns little-helpers
  (:require [babashka.process :refer [shell process]]
            [clojure.edn]
            [clojure.java.io :as io]
            [clojure.set]
            [clojure.string :as str]))

(def foo {:date-now "date '+%Y-%m-%d'"
          :datetime-now "date '+%Y-%m-%d %H:%M:%S'"
          :name "echo Dr. Wuff von PUh"})

(defn get-dmenu-user-selection [opts]
  (-> (process "echo" "-e" (str/join "\n" opts))
      (process {:out :string} "dmenu" "-i" "-l" "25" "-p" "Select config to edit")
      deref :out str/trim
      ))


(let [f (-> (get-dmenu-user-selection (keys foo))
            (clojure.edn/read-string))
      cmd (f foo)]
  (prn "cmd is" cmd)
  (-> (process cmd)
      (process {:out :string} "xclip" "-selection" "clipboard")))

