;; options
;;

;; don't use either flashing window or bell - try this: flashing mode-line
;;   5/4/2018 - better but still seems to redraw the whole window contents...

(setq ring-bell-function
      (lambda ()
        (let ((orig-fg (face-foreground 'mode-line)))
          (set-face-foreground 'mode-line "#F2804F")
          (run-with-idle-timer 0.1 nil
                               (lambda (fg) (set-face-foreground 'mode-line fg))
                               orig-fg))))

(setq disabled-command-function nil) ;; enable all disabled commands like narrow-to-region, et al.

;; Quitting emacs via `C-x C-c` or the GUI 'X' button ; from kmodi
(setq confirm-kill-emacs #'y-or-n-p)

;; don't require full 'yes' or 'no' - just accept 'y' or 'n'
(defalias 'yes-or-no-p 'y-or-n-p)

;; coding systems
(prefer-coding-system 'utf-8)
(modify-coding-system-alist 'file "\\.wer\\'" 'utf-16le) ;; for windows error reporting files
  (setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
  (set-language-environment 'utf-8)
  (set-keyboard-coding-system 'utf-8-mac) ; For old Carbon emacs on OS X only
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (unless (eq system-type 'windows-nt)
   (set-selection-coding-system 'utf-8))
  (prefer-coding-system 'utf-8)
  
(setq org-conf-el (expand-file-name (concat dropbox-root-path "/.emacs.d/org.conf.el")))

(cd (getenv "HOME"))

;; Configure Backups
(setq backup-directory-alist '(("." . "~/.backup")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Configure autosave location
(setq auto-save-file-name-transforms
  `((".*" "~/.emacs.d/.autosaves/" t)))

;; abbrev settings
(setq abbrev-file-name (concat dropbox-root-path "/.emacs.d/abbrev_defs"))
(setq save-abbrevs t) ;; save abbrevs when files saves and quit emacs
(setq-default abbrev-mode t) ;; turn on abbrev-mode globally


;; COMMAND LINE PARAMETER HANDLING **********************************
;;
(setq org-switch-found (member "-org" command-line-args))
(setq command-line-args (delete "-org" command-line-args))
(setq quick-switch-found (member "-quick" command-line-args)) 
(setq command-line-args (delete "-quick" command-line-args)) 
(setq quick-switch-found (member "-wiki" command-line-args))
(setq command-line-args (delete "-wiki" command-line-args))
(setq news-switch-found (member "-news" command-line-args))
(setq command-line-args (delete "-news" command-line-args))
