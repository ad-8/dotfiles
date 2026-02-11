(ns launcher
  (:require  [clojure.string :as str]
             [clojure.edn]
             [babashka.fs :as fs]
             [babashka.process :refer [process shell]]))

;; a simple script to /somewhat/ replace keychords,
;; which are still missing in niri

(def cmds
  {"8 brave" "brave"
   "2 firefox" "firefox"
   "4 qutebrowser" "qutebrowser"
   "3 thunar (file manager)" "thunar"
   "linkding bookmarks std" "bb /home/ax/x/ax_bookmarks.clj std"
   "linkding bookmarks archived" "bb /home/ax/x/ax_bookmarks.clj archived"
   "1 system" (format "bb %s sys" *file*)
   "9 rofi"   (format "bb %s rofi" *file*)})

(def sys
  {"1 bluetui (TUI)" "alacritty -T ax-bluetui -e bluetui"
   "2 wiremix (TUI)" "alacritty -T ax-wiremix -e wiremix"
   "3 kill a process" "sh -c 'ps -u $USER -o pid,comm,args,%cpu,%mem | wmenu -i -l 10 -p Kill: | awk \"{print \\$1}\" | xargs -r kill'"
   "4 volume control (pavu)" "pavucontrol"
   "5 toggle bluetooth on/off" "rfkill toggle bluetooth"})

(def rofi
  {"rofi - files" "rofi -show recursivebrowser"
   "rofi - windows" "rofi -show window"})

(defn providers [prompt] {:rofi "rofi -dmenu -p mode-open"
                          :wmenu (format "wmenu -i 
                                -l 20 
                                -f \"Hack Nerd Font 11\" 
                                -N \"#0c1014\"
                                -n \"#99d1ce\"
                                -M \"#0a3749\"
                                -m \"#99d1ce\"
                                -S \"#195466\"
                                -s \"#99d1ce\"
                                -p \"%s\"" prompt)})

(defn run-it! [what prompt]
  (let [dmenu-cmd (:wmenu (providers prompt))
        input (str/join "\n" (sort (keys what)))
        user-choice (-> (process {:in input :out :string} dmenu-cmd)
                        deref :out str/trim)
        cmd-to-run (get what user-choice)]
    (println user-choice "---" cmd-to-run)
    (shell cmd-to-run)))

(let [arg (first *command-line-args*)]
  (case arg
    "main" (run-it! cmds "          Select main            ")
    "sys"  (run-it! sys  "          Select sys             ")
    "rofi" (run-it! rofi "          Select rofi            ")
    (System/exit 1)))
