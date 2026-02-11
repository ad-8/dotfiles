#!/usr/bin/env bb

; does only work when curr dir == script dir
;(load-file "colors.clj")
(defn script-dir []
  (-> *file* java.io.File. .getParent))
(defn load-abs-path [file]
  (load-file (str (script-dir) "/" file)))
(load-abs-path "colors.clj")

(ns checkupdates
  (:require [clojure.string :as str]
            [clojure.pprint :refer [print-table]]
            [babashka.process :refer [sh shell]]
            [colors :as c]))


(defn parse-line [line]
  (let [[pkg old new] (-> line
                          (str/replace #" ->" "")
                          (str/split #"\s"))]
    {:pkg pkg
     :old old
     :new new}))


;; sh works better than shell when working with empty :out or :err
(defn print-updates []
  (let [lines (-> (sh ["checkupdates"]) :out str/split-lines)]
    (if (= [""] lines)
      (println (c/green "\n  no updates"))
      (let [upds (count lines)
            upds' (c/bold (c/on-red (format " updates: %d " upds)))]
        (print-table (map parse-line lines))
        (printf "\n%s\n" upds')))))


(defn print-news []
  (let [res (-> (sh ["paru" "--show" "--news"]))]
    (if (= "" (:out res))
      (println (c/green "  " (str/trim (:err res))))
      (println (c/magenta (str/trim (:out res)))))))


(defn print-flatpak []
  (let [out (-> (sh ["flatpak" "remote-ls" "--updates"]) :out str/trim)]
    (println (if (= "" out)
               (c/green "  Flatpak")
               (c/magenta out)))))

(defn print-rust []
  (let [lines (-> (sh ["rustup" "check"]) :out str/trim str/split-lines)]
    (if (every? #(str/includes? % "Up to date") lines)
      (printf (c/green "  Rust\n"))
      (do (println (c/bold (c/on-red "Rust:")))
          (doseq [line lines]
            (println line))))))


(defn- print-sep []
  (let [line (apply str (repeat 25 "-"))]
    (println (c/grey (format "\n%s\n" line)))))


(defn main []
  (print-updates)
  (print-sep)
  (print-news)
  (print-sep)
  (print-flatpak)
  (print-sep)
  (print-rust))

; could just use escape codes to clear and goto top left
; (println "\u001b[2J\u001b[H")

; shell: Interactive, streams output
; sh: Captures output for processing
(shell "clear")
(main)
