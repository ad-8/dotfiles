(setq bookmark-default-file
      (expand-file-name "emacs-bookmark-default-file"
                        (expand-file-name "~/sync")))

(setq bookmark-save-flag 1)

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Hack Nerd Font" :size 14 :weight 'semi-light))

(setq doom-theme 'doom-nord)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; https://lucidmanager.org/productivity/configure-emms/
(use-package emms
  :config
  (require 'emms-setup)
  (require 'emms-mpris)
  (emms-all)
  (emms-default-players)
  (emms-mpris-enable)
  :custom
  (emms-browser-covers #'emms-browser-cache-thumbnail-async) ; without this, no covers in browser
  :bind ; TODO use evil binds and move to keybindings
  (("C-c w m b" . emms-browser)
   ("C-c w m e" . emms)
   ("C-c w m p" . emms-play-playlist )
   ("<XF86AudioPrev>" . emms-previous)
   ("<XF86AudioNext>" . emms-next)
   ("<XF86AudioPlay>" . emms-pause)))

(setq emms-browser-playlist-info-title-format "%T. %t")

(defun my/open-emms-layout ()
  "Open EMMS browser on the left and playlist on the right."
  (interactive)
  (delete-other-windows)
  (split-window-right)
  (other-window 0)
  (emms-browser)
  (other-window 1)
  (emms-playlist-mode-go))

(defun ax/trigger-scrobble (status)
  "Run when a song starts or finishes. STATUS should be either 'started or 'finished."
  (let* ((track (emms-playlist-current-selected-track))
         (title (emms-track-get track 'info-title))
         (artist (emms-track-get track 'info-artist))
         (album (emms-track-get track 'info-album))
         (message-text (format "%s — %s" (or artist "Unknown artist") (or title "Unknown title")))
         (status-text (if (eq status 'started) "Now playing" "Finished playing")))
    (message "%s: %s" status-text message-text)
    ;; (shell-command (format "notify-send '%s' '%s'" status-text message-text))
    
    ;; TODO move script
    (shell-command
     (format "nix develop ~/sync/tmp/0lastfm --command python ~/sync/tmp/0lastfm/scrobble.py %s %s %s"
         ;; shell-quote-argument helps when eg title is multiple words, so we only pass exactly 3 args to python
         (shell-quote-argument (or artist "Unknown artist"))
         (shell-quote-argument (or album "Unknown album"))
         (shell-quote-argument (or title "Unknown title"))))))

(add-hook 'emms-player-started-hook
          (lambda () (ax/trigger-scrobble 'started)))

(defun ax/open-trixie ()
  "Open trixie.org in dired"
  (interactive)
  (dired "~/sync/0-from-MEGAsync/debian-trixie.org"))

(defun ax/open-trixie-x ()
  "Open trixie.org in editor"
  (interactive)
  (find-file "~/sync/0-from-MEGAsync/debian-trixie.org"))


(defun ax/my-hello-message ()
  (interactive)
  (message "Hello World from Doom!"))


(defun ax/my-run-date ()
  (interactive)
  (message "Date is: %s" (string-trim (shell-command-to-string "date +%F_%T"))))


;; TODO doesn't work for nested list items, if those have a second line
(defun ax/org-fold-all-list-items ()
  "Fold all multi-line list items in the current Org buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward org-list-full-item-re nil t)
      (when (org-at-item-p)
        (org-cycle)))))

(defun ax/git-count-commits ()
  "Count the number of commits in the current Git repository
   using \='git log --oneline | wc -l\='."
  (interactive)
  (message "Number of commits: %s"
           (string-trim (shell-command-to-string "git log --oneline | wc -l"))))

(map! :leader
      :desc "(Un)comment line" "-" #'comment-line)

(map! :leader
      :prefix "j"
      :desc "Toggle Dired Preview (global)"
      "p" #'dired-preview-global-mode)

(map! :leader
      :prefix "w"
      :desc "Horizontal split" "z" #'evil-window-split)

(map! :leader
      (:prefix-map ("j" . "ax custom binds")
       (:prefix ("f" . "fzf")
        :desc "Starts fzf session in dir" "f" #'fzf-directory)
       ;; this is nested under spc-j-p-p
       ;; (:prefix ("p" . "dired-preview")
       ;;  :desc "Toggle dired-preview" "p" #'dired-preview-mode)
       (:prefix ("t" . "testing stuff")
        :desc "hello world" "h" #'ax/my-hello-message
        :desc "print date" "d" #'ax/my-run-date
        :desc "org-babel-tangle" "t" #'org-babel-tangle)))

(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Toggle eshell split"            "e" #'+eshell/toggle
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle markdown-view-mode"      "M" #'ax/toggle-markdown-mode
       :desc "Toggle truncate lines"          "t" #'toggle-truncate-lines
       :desc "Toggle treemacs"                "T" #'+treemacs/toggle))

;; (map! :leader
;;       (:prefix ("o" . "open here")
;;        :desc "Open eshell here"    "e" #'+eshell/here
;;        :desc "Open vterm here"     "v" #'+vterm/here))

(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.2))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.1)))))

(defun ax/toggle-markdown-mode ()
  "Toggle between `markdown-mode` and `markdown-view-mode`."
  (interactive)
  (if (eq major-mode 'markdown-view-mode)
      (markdown-mode)
    (markdown-view-mode)))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; TODO
(setq org-directory "~/org/")

;; org-mode: set different heading sizes
(custom-theme-set-faces!
'doom-nord
'(org-level-8 :inherit outline-3 :height 1.0)
'(org-level-7 :inherit outline-3 :height 1.0)
'(org-level-6 :inherit outline-3 :height 1.1)
'(org-level-5 :inherit outline-3 :height 1.2)
'(org-level-4 :inherit outline-3 :height 1.3)
'(org-level-3 :inherit outline-3 :height 1.4)
'(org-level-2 :inherit outline-2 :height 1.5)
'(org-level-1 :inherit outline-1 :height 1.6)
'(org-document-title  :height 1.8 :bold t :underline nil))

;; AX
; doom doctor suggestions
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")



;; activate rainbow mode for org documents and all programming modes
; (add-hook! org-mode 'rainbow-mode)
; (add-hook! prog-mode 'rainbow-mode)


(setenv "FZF_DEFAULT_COMMAND" "fd -u")
;(use-package! fzf)
(use-package! fzf
  :bind
    ;; Don't forget to set keybinds!
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 35))

;; Prevent Doom from forcing vterm into a bottom popup window.
;; This lets vterm open in the current or split window like any normal buffer.
(after! vterm
  (set-popup-rule! "^\\*vterm\\*" :ignore t))

(after! org
  (require 'ox-twbs))

(setq image-dired-thumb-size 128)

(setq image-dired-external-viewer "nsxiv")

;; TOOD find a better solution
;; ever since rubocop installed via gem, ruby-lsp is gone =lsp-describe-session=
;; Disable rubocop-ls
;;(after! lsp-mode
;;  (setq lsp-disabled-clients '(rubocop-ls)))

;; https://protesilaos.com/emacs/dired-preview
(setq dired-preview-delay 0.1) ;; default 0.7
(setq dired-preview-max-size (expt 2 20))
(setq dired-preview-ignored-extensions-regexp
        (concat "\\."
                "\\(gz\\|"
                "zst\\|"
                "tar\\|"
                "xz\\|"
                "rar\\|"
                "zip\\|"
                "iso\\|"
                "epub"
                "\\)"))




; ------------
;; clojure those seem to work
(after! lsp-mode
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-position 'top))  ; Position pop-up at top of window
(after! cider
  (add-hook 'cider-mode-hook #'lsp)
  (setq cider-doc-view-function #'cider-docview-inline-symbol))  ; Inline docs with examples
; ------------


;(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
