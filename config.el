;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dan Boitnott"
      user-mail-address "dan@lclinux.org")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;;
;; Fira Code font installation:
;;   https://github.com/tonsky/FiraCode/wiki/Installing
(setq doom-font (font-spec :family "Fira Code" :weight 'semilight :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; `doom-one' is the default
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq fancy-splash-image (concat doom-private-dir "splash/meditate-290.png"))

(defun doom-dashboard-draw-ascii-banner-fn ()
  (let* ((banner
          '("  ,           ,"
            " /             \\"
            "((__-^^-,-^^-__))"
            " `-_---' `---_-'"
            "  `--|o` 'o|--'"
            "     \\  `  /"
            "      ): :("
            "      :o_o:"
            "       \"-\""))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(load! "lisp/editing.el")
(load! "lisp/iterm2-integration.el")
(load! "lisp/org.el")

;; Company mode causes hangs in sh-mode so we disable it.
(defun disable-company ()
  (interactive)
  (company-mode 0))
(add-hook! sh-mode #'disable-company)

(use-package! python-black
  :demand t
  :after python
  :config
  (add-hook! 'python-mode-hook #'python-black-on-save-mode)
  ;; Feel free to throw your own personal keybindings here
  ;; (map! :leader :desc "Blacken Buffer" "m b b" #'python-black-buffer)
  ;; (map! :leader :desc "Blacken Region" "m b r" #'python-black-region)
  ;; (map! :leader :desc "Blacken Statement" "m b s" #'python-black-statement)
)
