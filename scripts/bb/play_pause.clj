#!/usr/bin/env bb

(ns play-pause
  (:require [clojure.string :as str]
            [babashka.process :refer [shell]]))

(def state->actions
  {:play  ["notify-send playerctl Playing... --app-name=dwm-play-pause --expire-time=2000 --icon exaile-play --replace-id=123 --urgency=low"
           "playerctl play"]
   :pause ["notify-send playerctl Pausing... --app-name=dwm-play-pause --expire-time=2000 --icon exaile-pause --replace-id=123 --urgency=low"
           "playerctl pause"]})

(defn execute-commands [cmds]
  (doseq [cmd cmds]
    (shell cmd)))

(defn set-player [new-state]
  (if-let [commands (get state->actions new-state)]
    (execute-commands commands)
    :error))

(let [status (-> (shell {:out :string} "playerctl status") :out str/trim)]
  (case status
    "Playing" (set-player :pause)
    "Paused"  (set-player :play)
    :unknown-status))
