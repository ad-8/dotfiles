#!/usr/bin/env bb
(ns bbprocess

  (:require [babashka.process :refer [shell process exec check]]
            [clojure.string :as str]
            [clojure.java.io :as io]
            [clojure.java.shell :as sh]))

(shell "pwd")
(shell "kitty" "hx" "/home/ax/code/scripts/bb/src/i3vpn.clj")
(-> (shell {:out :string} "ls -lh") :out str/split-lines)
(-> (shell {:out :string :err :string} "git config user.name")
    (select-keys [:out :err]))

(let [stream (-> (process "ls") :out)]
  @(process {:in stream
             :out :inherit} "cat")
  nil)

(let [stream (-> (process "echo" "-e" "op1\nop2\nopXXX") :out)]
  @(process {:in stream
             :out :inherit} "dmenu")
  nil)

(def opts (range 1 11))
(count "this is a wuffelpuff")
(-> (process "echo" "this is a wuffelpuff\nAnd then some\nMore Wuffelaction here")
    (process "grep" "-i" "wuffel")
    (process {:out :string} "wc")
    deref :out)

(do @(process {:dir "/home/ax/.config" 
               :out :write 
               :out-file (io/file "/tmp/out.txt")} 
              "ls") nil)

; HOW TO pipe input to DMENU 
(-> (process "echo" "-e" "op1\nop2\nopXXX")
    (process {:out :string} "dmenu") deref :out)

; dmenu as fuzzy finder = ❤️
; TODO automate: emojis, licht, and many more!
(-> (process "echo" "-e" (str/join "\n" opts))
    (process {:out :string} "dmenu" "-l" "20")
    deref :out str/trim)


;; GPT: **Set operations** are fundamental in many programming and data processing tasks, 
;; allowing for **efficient manipulation and comparison of collections. 

;; gotta learn some basic stuff likes set operations, 
;; and recursively walking trees until the end of each branch
(def set-hdd (->> (shell {:out :string} "ls" "/run/media/ax/wd2b/0-localsync/mukke")
             :out
             str/split-lines
             (map str/lower-case)
             (into #{})))

(def set-csv (->> "/home/ax/.metal/bands.csv"
                  slurp
                  str/split-lines
                  rest
                  (map (fn [line]
                         (let [[band id] (str/split line #",")]
                           band))) 
                  (map #(str/replace % "#" ""))
                  (map str/lower-case)
                  (into #{})))


(def hdd #{"file1.txt" "file2.txt" "file3.txt" "file4.txt"})
(def csv #{"file2.txt" "file3.txt" "file7.txt"})

; The difference operation finds elements in the first set that are not in the second set.
; lot ist einfach Differenz wo möglich, der rest ist das result
(def not_in_csv (clojure.set/difference hdd csv))
not_in_csv
(clojure.set/difference csv hdd)

;; in csv, but not on hdd 
(clojure.pprint/pprint (clojure.set/difference set-csv set-hdd ))

;; on hdd, but not in csv
(clojure.pprint/pprint (clojure.set/difference set-hdd set-csv ))


(clojure.pprint/pprint (clojure.set/union set-hdd set-csv ))
