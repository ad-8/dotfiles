#!/usr/bin/env bb
(ns ip-addr
  (:require [babashka.process :refer [shell]]
            [clojure.string :as str]))


(->> (shell {:out :string} "ip -o -4 addr show")
     :out
     str/split-lines
     (map #(str/split % #"\s+"))
     (map (fn [[_ ifn _ ip & _rest]]
            [ifn (-> ip (str/split #"/") first)]))
     (remove (fn [[ifn _ip]] (re-find #"lo|docker|virbr|br" ifn)))
     #_(filter (fn [[ifn _ip]]
               (re-find #"enp1s0|wlan0|wlp3s0|muc" ifn)))
     (map (fn [[ifn ip]]
            (format "%s [%s]" ip ifn)))
     (str/join ", ")
     println)
