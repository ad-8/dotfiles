#!/usr/bin/env bb
(ns run-script
  (:require [babashka.fs :as fs]
            [babashka.process :refer [process shell]]
            [clojure.java.io :as io]
            [clojure.string :as str]))


(def home (System/getProperty "user.home"))
(def int-scripts (->> (fs/glob (io/file home "my" "scripts" "bb") "**{.clj,cljc}")
                      (map str)))
(def ext-scripts (->> [
                ;;   "~/.config/i3/dmenuunicode"
                       ]
                  (map #(str/replace-first % "~" home))))


(def all-scripts (->> (concat int-scripts ext-scripts)
                      (map #(str/replace-first % home "~"))
                      sort))


(defn get-dmenu-user-selection [opts]
  (-> (process "echo" "-e" (str/join "\n" opts))
      (process {:out :string} "dmenu" "-i" "-l" "25" "-p" "Run script:")
      deref :out str/trim))


(-> all-scripts 
    get-dmenu-user-selection 
    shell)
