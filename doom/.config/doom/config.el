;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Hack Nerd Font" :size 14 :weight 'semi-light)
      ;;doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13)
      )
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; TODO
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; AX

; doom doctor suggestions
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")


(setq display-line-numbers-type 'relative)

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


(defun my-hello-message ()
  (interactive)
  (message "Hello World from Doom!"))

(defun ax-open-trixie ()
  "Open trixie.org in dired"
  (interactive)
  (dired "~/sync/0-from-MEGAsync/debian-trixie.org"))

(defun ax-open-trixie-x ()
  "Open trixie.org in editor"
  (interactive)
  (find-file "~/sync/0-from-MEGAsync/debian-trixie.org"))

(map! :leader
      (:prefix-map ("j" . "ax custom binds")
       (:prefix ("f" . "fzf")
        :desc "Starts fzf session in dir" "f" #'fzf-directory)
       ;; this is nested under spc-j-p-p
       ;; (:prefix ("p" . "dired-preview")
       ;;  :desc "Toggle dired-preview" "p" #'dired-preview-mode)
       (:prefix ("t" . "testing stuff")
        :desc "hello world" "h" #'my-hello-message
        :desc "print date" "d" #'my-run-date)))


(map! :leader
      :prefix "j"
      :desc "Toggle Dired Preview (global)"
      "p" #'dired-preview-global-mode)


(map! :leader
      :prefix "w"
      :desc "Horizontal split" "z" #'evil-window-split)

(map! :leader
      :desc "(Un)comment line" "-" #'comment-line)

(defun ax/git-count-commits ()
  "Count the number of commits in the current Git repository
   using \='git log --oneline | wc -l\='."
  (interactive)
  (message "Number of commits: %s"
           (string-trim (shell-command-to-string "git log --oneline | wc -l"))))


;; Prevent Doom from forcing vterm into a bottom popup window.
;; This lets vterm open in the current or split window like any normal buffer.
(after! vterm
  (set-popup-rule! "^\\*vterm\\*" :ignore t))


(defun my-run-date ()
  (interactive)
  (message "Date is: %s" (string-trim (shell-command-to-string "date +%F_%T"))))


;; TODO doesn't work for nested list items, if those have a second line
(defun org-fold-all-list-items ()
  "Fold all multi-line list items in the current Org buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward org-list-full-item-re nil t)
      (when (org-at-item-p)
        (org-cycle)))))


(after! org
  (require 'ox-twbs))

(setq image-dired-thumb-size 128)

(setq image-dired-external-viewer "nsxiv")


;; org-mode: set different heading sizes
;(custom-theme-set-faces!
;'doom-one
;'(org-level-8 :inherit outline-3 :height 1.0)
;'(org-level-7 :inherit outline-3 :height 1.0)
;'(org-level-6 :inherit outline-3 :height 1.1)
;'(org-level-5 :inherit outline-3 :height 1.2)
;'(org-level-4 :inherit outline-3 :height 1.3)
;'(org-level-3 :inherit outline-3 :height 1.4)
;'(org-level-2 :inherit outline-2 :height 1.5)
;'(org-level-1 :inherit outline-1 :height 1.6)
;'(org-document-title  :height 1.8 :bold t :underline nil))

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
