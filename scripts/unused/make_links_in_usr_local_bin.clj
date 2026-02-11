#!/usr/bin/env bb

; sudo /home/linuxbrew/.linuxbrew/bin/bb ./make_links_in_usr_local_bin.clj
; run command above, sudo doesn't seem to know bb
;
; on arch this did it:
; sudo src/make_links_in_usr_local_bin.clj

(ns make-links-in-usr-local-bin
  (:require [babashka.fs :as fs]
            [babashka.process :refer [shell]]
            [clojure.string :as str]
            [clojure.java.io :as io]))

(def script-dir (System/getProperty "user.dir"))
(def scripts (->> (fs/glob script-dir "**{.clj,cljc}")
                  (map str)
                  (map io/file)))

(defn remove-ext [filename]
  (let [index-last-dot (str/last-index-of filename ".")]
    (if (nil? index-last-dot)
      filename
      (subs filename 0 index-last-dot))))

(doseq [s scripts]
  (let [name (.getName s)
        path (str s)
        bin-path (str "/usr/local/bin/" (remove-ext name))]

    (if (.exists  (java.io.File. bin-path))
      (println "link already exists:" bin-path)
      (do
        (println "ln -s" path bin-path)
        (shell   "ln -s" path bin-path)))))
