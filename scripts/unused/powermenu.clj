#!/usr/bin/env bb
(ns powermenu
  (:require [babashka.process :refer [shell process]]
            [clojure.string :as str]))


(def font-and-size "HackNerdFont-13")
(def user-name    (-> (process {:out :string} "whoami") deref :out str/trim))
;; doesnt work
;; :suspend {:txt "󰒲 suspend" :action ["i3lock" "--color" "000000" "--show-failed-attempts" "&&" "systemctl" "suspend"]}
(def choices
  {:lock {:txt " lock" :action ["i3lock" "--color" "000000" "--show-failed-attempts"]}
   :logout {:txt "󰗽 logout" :action (conj ["loginctl" "terminate-user"] user-name)}
   :suspend {:txt "󰒲 suspend" :action ["systemctl" "suspend"]}
   :reboot {:txt "󰜉 reboot" :action ["systemctl" "reboot"]}
   :shutdown {:txt "⏻ shutdown" :action ["systemctl" "poweroff"]}})

(defn dmenu-string [prompt]
  (str/join " " ["dmenu" "-p" prompt "-fn" font-and-size "-nf" "#8fbcbb" "-nb" "#2e3440" "-sf" "#000000" "-sb" "#88c0d0"]))

(defn power-choice []
  (-> (process "echo" "-e" (str/join "\n" (map :txt (vals choices))))
      (process {:out :string} (dmenu-string "'powermenu.clj v0.2'"))
      deref :out str/trim))

(defn confirmation-choice []
  (let [choice (-> (process "echo" "-e" "no\nyes")
                   (process {:out :string} (dmenu-string "'r u sure?'"))
                   deref :out str/trim)]
    (if (= "yes" choice)
      true
      false)))

(defn get-key-from-txt [txt]
  (first (for [[k v] choices
               :when (= txt (:txt v))]
           k)))

(def power-chosen (power-choice))

(if-not (= "" power-chosen)
  (let [key-chosen   (get-key-from-txt power-chosen)
        action       (get-in choices [key-chosen :action])
        confirmed?   (confirmation-choice)]
    (when confirmed?
      (println key-chosen ":" action)
      (shell action)
    ;; TODO
    ;;   "suspend"  (and (lock-screen) (shell "systemctl" "suspend"))
      ))
  (println "no power chosen"))


;; (def my-choice (power-choice))
;; (reduce-kv (fn [acc k v]
;;              (if (= (:txt v) my-choice)
;;                (conj acc k)
;;                acc))
;;            #{}
;;            choices-map)
