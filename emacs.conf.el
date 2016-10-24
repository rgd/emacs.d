;; emacs configuration
;;  - assumes ~/.emacs.d/init.el sets dropbox-root-path
;;
(message "<dropbox>/.emacs.d/emacs.conf.el - start")

;; TODO *************************************************************
;; TODO: save config files in github repo, pull on each machine - but isn't that similar to using dropbox? what's better about github?
;;        oh yeah github is a VCS - so we get history!
;;        pull to local directory and 'ln' so it looks like they're all in ~/.emacs.d

;; TODO: set up startup message / scratch message with todo items") ;; so define here what shows up in *Scratch* buffers
;;       - from emacs-notes.org section?  Todo's and quick help reminders cheat sheets

;; TODO: change narrow-to-region to C-x n r   instead of default C-x n n

;; break up into multiple files

;; use use-package

(defvar my/packages
  '(edit-server ggtags helm helm-core async org popup))


;; other packages I like:
;; dired+


;; (use-package color-moccur
;;   :ensure t                              ;; load from ELPA;; or :ensure altname if need different name than  in use-package
;;   :if window-system                      ;; conditionals
;;   ;load-path "site-lisp/ess/lisp"        ;; add to load-path
;;   :commands (isearch-moccur isearch-all) ;; creates autoloads for these commands
;;   :functions                             ;; 'forward declarations' to quiet byte omile warnings
;;   :defines                               ;; same for definitions
;;   :deferred
;;   :disabled                              ;; don't use at all
;;   :no-require t                          ;; don't load at byte compile time
;;   :bind (("M-s O" . moccur)              ;; 
;;          :map isearch-mode-map
;;          ("M-o" . isearch-moccur)
;;          ("M-O" . isearch-moccur-all))
;;   :mode ("\\.py\\'" . python-mode)       ;;  or :mode "\\.rb\\'"
;;   :init                                  ;; code to execute before loaded; 1+ forms
;;   (setq isearch-lazy-highlight t)
;;   :config                                ;; code to execute after loaded (even if autoloaded)
;;   (use-package moccur-edit))
;;
;; (use-package edit-server
;;   :if window-system
;;   :init
;;   (add-hook 'after-init-hook 'server-start t)
;;   (add-hook 'after-init-hook 'edit-server-start t))

;;
;; M-x desribe-personal-keybindings

(setq package-enable-at-startup nil) ;; defer until (package-init)

(setq disabled-command-function nil) ;; enable all disabled commands like narrow-to-region, downcase-region, et al.

;; COMMAND LINE PARAMETER HANDLING **********************************
;;
(setq org-switch-found (member "-org" command-line-args))
(setq command-line-args (delete "-org" command-line-args))
(setq quick-switch-found (member "-quick" command-line-args)) ;; not working if emacsclient/runemacs command line has "-q..." 
(setq command-line-args (delete "-quick" command-line-args))  ;; which means --no-init-file (fast yes, but can't tweak - like for UTF-16)
                                                              ;; so making -wiki as an alias

(setq quick-switch-found (member "-wiki" command-line-args)) ;; alias for -quick 
(setq command-line-args (delete "-wiki" command-line-args))
;;
;; HKCR\*\shell\qopenwemacs\(Default) - &Quick edit with Emacs
;;                          Icon      - c:\sys\emacs\bin\emacs.exe,0
;;                          command   - c:\sys\emacs\bin\runemacs -wiki --no-splash "%1"
;; see also _macros.xp


;; DEFAULT CODING SYSTEMS *******************************************
;;
;; trying to view Windows Error Reporting save files (.wer) which npp reports as UCS2 / UTF-16 (LE).
;; (prefer-coding-system 'utf-16le)   ;; -- didn't seem to work - some other coding system beat it for .WER files
(prefer-coding-system 'utf-8)
(modify-coding-system-alist 'file "\\.wer\\'" 'utf-16le)

;; org-mode configuration file
;;
(setq org-conf-el (expand-file-name (concat dropbox-root-path "/.emacs.d/org.conf.el")))

;; Variables for setting frame size and position
;;
(defvar startup-width-ratio 0.75)
(defvar startup-height-ratio 0.75)
(defvar startup-top-ratio 0.10)
(defvar startup-left-ratio 0.10)

;; *****************************************************************
;; MACHINE SPECIFIC SETUP
;; Detect system type (variable system-type: gnu/linux, windows-nt)
;; Detect system name (variable system-name: USWIC-L-0074462, etc...
;;
(cond
 ((string-match "HOMEPC" (system-name))
  (defvar local-site-lisp-path "/usr/local/share/emacs/site-lisp")
  ;; (setq printer-name "CN2462H16F05RQ:") ;;; how to print at home? can't share network printer.
  ;; color theme?
  )
 ((string-match "ROBSLAPTOP" (system-name))
  (defvar local-site-lisp-path "c:/rgd/dropbox/.emacs.d/lisp")
  (defvar local-find-exe "c:/rgd/dropbox/wbin/find.exe") ;; ??
  (setq printer-name "CN2462H16F05RQ:") ;;; how to print at home? can't share network printer.
  ;; or using lerup's PrintFile32
  (setq printer-name nil) 
  (setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
  (setq lpr-switches '("/q")) 
  (setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
  (setq ps-lpr-switches '("/q")) 
  ;; color theme?
  )
 ((string-match "ComposerDevD20" (system-name)) ;; Lenovo ThinkStation D20 Ubuntu box
  (defvar local-site-lisp-path "/usr/local/share/emacs/site-lisp")
  (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
  ;; color theme?
  )
 ((string-match "US-L-7002395" (system-name))
  (defvar local-site-lisp-path "c:/rgd/dropbox/.emacs.d/lisp")
  (defvar local-find-exe "c:/rgd/dropbox/wbin/find.exe") ;; ??
  ;; (message "How to dynamically set proxy for laptop depending on at work or home?")
  ;; -- proxy switcher with task scheduler and command files to set/reset proxy in emacs via emacsclient -e
  (setq url-proxy-services '(("no_proxy" . "us\\.abb\\.com\\;  tfs2\\.de\\.abb\\.com")
							 ("http" . "proxy.us.abb.com:8080")
							 ("https" . "proxy.us.abb.com:8080")))
  ;;  (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
  ;;  (setq printer-name "LPT3:") ;; net use lpt3: \\127.0.0.1\USCLEPX005-on-US-L-7002395 shared x005 printer on work laptop
  ;; but not PS
  
  ;;  (setq printer-name "//127.0.0.1/USCLEPX005-PS")
  ;; gives permission denied opening output file error to c:\X_10.127.9.50 - darn xerox

  ;; using lerup's PrintFile32
  (setq printer-name nil) 
  (setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
  (setq lpr-switches '("/q")) 
  (setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
  (setq ps-lpr-switches '("/q")) 

  ;; color theme
  )
 ((string-match "C64DEVROB" (system-name))
	(defvar local-site-lisp-path "C:/rgd/dropbox/.emacs.d/lisp")
	(defvar local-find-exe "c:/rgd/dropbox/wbin/find.exe")
        (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
	(setq url-proxy-services '(("no_proxy" . "us\\.abb\\.com\\; tfs2\\.de\\.abb\\.com")
							   ("http" . "proxy.us.abb.com:8080")
		                       ("https" . "proxy.us.abb.com:8080")
		  ))
	(setq load-path (cons "c:/sys/ezwinports/share/gtags" load-path))

	;; using lerup's PrintFile32
	(setq printer-name nil) 
	(setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq lpr-switches '("/q")) 
	(setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq ps-lpr-switches '("/q")) 


	)
 ((string-match "HAPIBUILD10" (system-name))
	(defvar local-site-lisp-path "C:/rgd/dropbox/.emacs.d/lisp")
	(defvar local-find-exe "c:/rgd/dropbox/wbin/find.exe")
        (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
	(setq url-proxy-services '(("no_proxy" . "us\\.abb\\.com\\; tfs2\\.de\\.abb\\.com")
		                       ("https" . "proxy.us.abb.com:8080")
							   ("http" . "proxy.us.abb.com:8080")))
	(setq load-path (cons "c:/sys/ezwinports/share/gtags" load-path))

	;; using lerup's PrintFile32
	(setq printer-name nil) 
	(setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq lpr-switches '("/q")) 
	(setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq ps-lpr-switches '("/q")) 
	
	)
 ((string-match "HAPIBUILD1" (system-name))
	(defvar local-site-lisp-path "C:/rgd/dropbox/.emacs.d/lisp")
	(defvar local-find-exe "c:/rgd/dropbox/wbin/find.exe")
        (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
	(setq url-proxy-services '(("no_proxy" . "us\\.abb\\.com\\; tfs2\\.de\\.abb\\.com")
		                       ("https" . "proxy.us.abb.com:8080")
							   ("http" . "proxy.us.abb.com:8080")))
	(setq load-path (cons "c:/sys/ezwinports/share/gtags" load-path))

	;; using lerup's PrintFile32
	(setq printer-name nil) 
	(setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq lpr-switches '("/q")) 
	(setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq ps-lpr-switches '("/q")) 
	
	)
)

(message "System: %s" system-name)
(message "dropbox-root-path = %s" dropbox-root-path)
(message "local-site-lisp-path = %s" local-site-lisp-path)
(message "local-find-exe = %s" local-find-exe)
(message "emacs-conf-path = %s" emacs-conf-path)
(message "custom file = %s" custom-file)
(message "themes path = %s" custom-theme-load-path)
(message "printer = %s" printer-name)


;;; *****************************************************************
;;;  Startup activities

;; Start in home directory
;;
(cd (getenv "HOME"))

;; Dont show GNU splash screen
;;
;; (setq inhibit-startup-message t)

;; Add machine-specific paths to other elisp to the load-path
;;
(add-to-list 'load-path local-site-lisp-path)

;; color-theme
;;
;; set color theme / or set in init.el after customizing based on PC we're on

;; ;; dirtree
;; try having this (or speedbar?) open on startup - else I forget about it
;; (require `dirtree)


;; *************************
;; Configure Backups
(setq backup-directory-alist '(("." . "~/.backup")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(display-time-mode 1)

;; *************************
;; INITIAL/DEFAULT FRAME
(if (display-graphic-p)
    (progn
      (message "default frame setup")

	  ;; TODO: user display-monitor-attributes-list to get height/width of primary monitor (and position?)
	  ;; then set default frame position to an offset and size to the ratio fraction of that size
	  ;; get (1..4) elements of first attribute (workarea) of first display

	  ;; (
	  ;; [0] (
	  ;;    [0]
	  ;; 	(geometry 0 0 1920 1200) ;;  [0] geometry   [1][2][3] [4]     top left width height
	  ;; 	(workarea 67 0 1853 1200) ;; taskbar on left side takes up 67 pixels
	  ;; 	(mm-size 320 240)
	  ;; 	(name . "\\\\.\\DISPLAY1")
	  ;; 	(frames #<frame emacs@C64DEVROB 016e7288>)
	  ;;  )
	  ;;  (
	  ;; 	(geometry 1920 0 1600 1200)
	  ;; 	(workarea 1920 0 1600 1200)
	  ;; 	(mm-size 320 240)
	  ;; 	(name . "\\\\.\\DISPLAY2")
	  ;; 	(frames)
	  ;;  )
	  ;; )

  	  
	  (setq mon-left   (nth 1 (nth 1 (nth 0 (display-monitor-attributes-list)))))
	  (message "mon-left %d" mon-left)

	  (setq mon-top    (nth 2 (nth 1 (nth 0 (display-monitor-attributes-list)))))
	  (message "mon-top %d" mon-top)
	  
	  (setq mon-width  (nth 3 (nth 1 (nth 0 (display-monitor-attributes-list)))))
	  (message "mon-width %d" mon-width)

	  (setq mon-height (nth 4 (nth 1 (nth 0 (display-monitor-attributes-list)))))
	  (message "mon-height %d" mon-height)
	  
      (setq new-frame-top (round (* mon-height startup-top-ratio)))
      (message "default-frame-top %d" new-frame-top)
      (add-to-list 'default-frame-alist (cons 'top new-frame-top))

      (setq new-frame-left (round (* mon-width  startup-left-ratio)))
      (message "default-frame-left %d" new-frame-left)
      (add-to-list 'default-frame-alist (cons 'left new-frame-left )) ;; (round (* (display-pixel-width) startup-left-ratio))))

      (setq new-frame-width  (/ (round (* mon-width startup-width-ratio))  (frame-char-width)))
      (message "new-frame-width  %d" new-frame-width)
      (add-to-list 'default-frame-alist (cons 'width (round new-frame-width)))

      (setq new-frame-height (/ (round (* mon-height startup-height-ratio)) (frame-char-height)))
      (message "new-frame-height %d" new-frame-height)
      (add-to-list 'default-frame-alist (cons 'height (round new-frame-height)))

      (message "default frame setup done")
))
(print default-frame-alist)

;; (defun set-speedbar-params ()
;;   (interactive)
;; 	  (add-to-list 'speedbar-frame-parameters (cons 'top new-frame-top))
;; ;;	  (add-to-list 'speedbar-frame-parameters (cons 'left (+ new-frame-left new-frame-width)))
;; 	  (add-to-list 'speedbar-frame-parameters (cons 'height new-frame-height))
;; )

(setq cursor-in-non-selected-windows '(hbar . 3))

;;; *****************************************************************
;;;  Function definitions 

;;; proxy setting functions
(defun set-proxy-nil ()
  (interactive)
  (setq url-proxy-services nil)
)

(defun set-proxy-abb ()
  (interactive)
  (setq url-proxy-services '(("no_proxy" . "us\\.abb\\.com\\;tfs2\\.de\\.abb\\.com")
                             ("http" . "proxy.us.abb.com:8080")
							 ("https" . "proxy.us.abb.com:8080")))
)

;;; frame / UI functions
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if (display-graphic-p)
      (progn
	(message "set-frame-size-according-to-resolution")
	(setq new-frame-width  (/ (round (* (display-pixel-width) 0.65))  (frame-char-width)))
	(setq new-frame-height (/ (round (* (display-pixel-height) 0.75)) (frame-char-height)))
	(message "new-frame-width  %d" new-frame-width)
	(message "new-frame-height %d" new-frame-height)
	(set-frame-width (selected-frame)  (round new-frame-width))
	(set-frame-height (selected-frame) (round new-frame-height))
)))

;; Create Scratch Buffer
;; from http://neonlabs.structum.net/pkgs/dotemacs
(defun create-scratch-buffer nil "Create a new scratch buffer to work in. (could be *scratch* - *scratchX*)"
  (interactive)
  (let ((n 0)
	bufname)
    (while (progn
	     (setq bufname (concat "*scratch"
				   (if (= n 0) "" (int-to-string n))
				   "*"))
	     (setq n (1+ n))
	     (get-buffer bufname)))
    (switch-to-buffer (get-buffer-create bufname))
    (if (= n 1) (lisp-interaction-mode))))

;; from: http://emacs.stackexchange.com/questions/24459/revert-all-open-buffers-and-ignore-errors
(defun revert-all-file-buffers ()
  "Refresh all open file buffers without confirmation.
Buffers in modified (not yet saved) state in emacs will not be reverted. They
will be reverted though if they were modified outside emacs.
Buffers visiting files which do not exist any more or are no longer readable
will be killed."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      ;; Revert only buffers containing files, which are not modified;
      ;; do not try to revert non-file buffers like *Messages*.
      (when (and filename
                 (not (buffer-modified-p buf)))
        (if (file-readable-p filename)
            ;; If the file exists and is readable, revert the buffer.
            (with-current-buffer buf
              (revert-buffer :ignore-auto :noconfirm :preserve-modes))
          ;; Otherwise, kill the buffer.
          (let (kill-buffer-query-functions) ; No query done when killing buffer
            (kill-buffer buf)
            (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finished reverting buffers containing unmodified files."))

;;; *****************************************************************
;;; KEYBOARD CHANGES
;;;

(message "Configuring keyboard mappings.")
(define-key global-map (kbd "RET") 'newline-and-indent) ;; auto indent when hit enter
(global-set-key (kbd "C-c i") 'indent-region)
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c f") (lambda () (interactive) (find-file "~/.emacs")))
(global-set-key "\M-]" 'forward-list) ;; move to matching parentheses
(global-set-key "\M-[" 'backward-list) ; http://www.uhoreg.ca/programming/emacs - 2-Oct-08
(global-set-key [f5] 'call-last-kbd-macro)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)
(global-set-key (kbd "<M-f2>") 'bm-show-all);;  to show all bookmarks

(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
    (define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

;;    (global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
;;    (global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
;;    (global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)
;; C-x r m   -- set bookmark
;; C-x r b   -- jump to bookmark
;; C-x r l   -- list bookmarks

(global-set-key (kbd "C-c n") 'create-scratch-buffer)

(global-set-key (kbd "C-c e") (lambda ()
				 (interactive)
				 (find-file "~/.emacs.d/init.el") ;;; /.emacs.d/init.el"))
				 (find-file (concat dropbox-root-path "/.emacs.d/org.conf.el"))
				 (find-file (concat dropbox-root-path "/.emacs.d/emacs.conf.el"))
				 ))
(global-set-key (kbd "C-c t") (lambda ()
				(interactive)
				(progn
				  (message "loading %s for org-mode configuration" org-conf-el)
				  (if (file-exists-p org-conf-el)
				      (progn
					(message "loading org-mode configuration file %s" (expand-file-name (concat dropbox-root-path "/.emacs.d/org.conf.el")))
					(load-file org-conf-el)))
 				  (find-file (concat dropbox-root-path "/org/todo.org"))
				)
				))
(message "Configuring keyboard mappings - done.")


(unless quick-switch-found ;; things to do if NOT in quick mode
  (progn

;; maybe do this only on Windows?  Kept getting "select coding system: chinese iso 8bit default" when saving files.  Why?
  (setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
  (set-language-environment 'utf-8)
  (set-keyboard-coding-system 'utf-8-mac) ; For old Carbon emacs on OS X only
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (unless (eq system-type 'windows-nt)
   (set-selection-coding-system 'utf-8))
  (prefer-coding-system 'utf-8)
  

;;; ****************************************************************
;;; GLOBAL MODES
(message "Global modes")
  
;; Add line number to the buffer
;;;;;(require 'nlinum) ;; customize to enable it globally
;;;;;(global-nlinum-mode)

(message "Bookmarks")
;; Bookmarks - the MSVS kind
;;;;(autoload 'bm-toggle   "bm" "Toggle bookmark in current buffer." t)
;;;;(autoload 'bm-next     "bm" "Goto bookmark."                     t)
;;;;(autoload 'bm-previous "bm" "Goto previous bookmark."            t)

;; cmd-mode (see emacswiki) - dos-mode is newer alternative (look into it)
;;;;(autoload 'dos-mode "dos" "Edit Dos scripts." t) ;; poor name - cmd better than 'dos'
;;;;(add-to-list 'auto-mode-alist '("\\.\\(cmd\\|bat\\)$" . dos-mode))

;; ***** Flyspell - mouse-2 on highlighted word to popup menu; or M-$ to bring up text menu
;; Enable flyspell (using aspell) in text mode
;;(add-hook 'text-mode-hook (lambda ()
;;			    (when (not (equal major-mode 'org-mode))
;;			      (flyspell-mode t))))
;;;;(setq text-mode-hook '(lambda() (flyspell-mode t))) ; spellchek (sic) on the fly  
;;;; customized flyspell-issue-message-flag to nil - don't print messages fro every word - trying to make faster



(message "Packages")
;; Add package path
(require 'package)
(defvar dropbox-package-path (concat dropbox-root-path "/.emacs.d/elpa/"))
(add-to-list 'package-directory-list dropbox-package-path)
(setq package-user-dir dropbox-package-path)

;;
;; package archives can be defined in emacs.custom.el - customized variable
;;
;;  getting packages at work doesn't work with marmalade and gnutls and 25.0.5 for some reason - running 24.4-sav works
;;
;; marmalade switched to https - http://www.reddit.com/r/emacs/comments/2k2url/marmalade_gets_ssl_finally/clja711?context=3
;; https://marmalade-repo.org/
;; have these customized now - see <dropbox-root-path>\.emacs.d\emacs.custom.el
;; (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives '("orgmode" . "http://orgmode.org/elpa/"))
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t) ;; fails to load - hmm works at work now...
;; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
; 20150411 - had run into emacs bug https://debbugs.gnu.org/cgi/bugreport.cgi?bug=20010 - utf8 characters in package list messes up
; fixed in url-handlers.el
;; this seems to make packages work at home
;;;(setq el-get-github-default-url-type 'https)

;; not saving from MELPA correctly?? saving html filetype!
(message "Packages - done")



(message "calendar")
;; *************************
;; Calendar/Diary

;; emacs-calfw
;(require 'calfw)

(setq diary-file (concat dropbox-root-path "/.emacs.d/diary"))
(setq view-diary-entries-initially t
	  mark-diary-entries-in-calendar t
	  number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

(message "package-init")
;; ****************************************************************
;; INITIALIZE PACKAGES - hmm, not needed in 24.1+? without doesn't find linum-off
(package-initialize)

;; LOAD PACKAGES FROM package-selected-packages customized variable - if on new machine.
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)

;; helm
;;;(message "Helm config")
;;;(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-c o") 'helm-occur)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; tramp
(require 'tramp)
(set-default 'tramp-auto-save-directory "c:/users/usrodav2/AppData/Local/temp")
(set-default 'tramp-default-method "plink")

;; Recent files...
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


;;(require 'list-processes+)
;;(autoload "list-processes+" 'list-processes+
;;          "A enhance list processes command" t)

;;(message "helm init")
;;(helm-mode 1)


(message "speedbar init")
(require 'speedbar)
;; (require 'sr-speedbar)  (give bytecompile warning about free reference blah blah - annoying)
;;(global-set-key (kbd "<f9>") 'speedbar-get-focus)
(global-set-key (kbd "<f9>") 'sr-speedbar-toggle)
(define-key speedbar-key-map (kbd "<right>") 'speedbar-expand-line)
(define-key speedbar-key-map (kbd "<left>") 'speedbar-contract-line)

;;(add-to-list 'speedbar-frame-parameters (cons 'top new-frame-top))
;;	(add-to-list 'speedbar-frame-parameters (cons 'left (+ new-frame-left new-frame-width)))
;;(add-to-list 'speedbar-frame-parameters (cons 'height new-frame-height))
	  


;; Many abbrev type systems: abbrev, dabbrev, hippie, auto-complete, yasnippet - research them.
;;   abbrev - simple expansion; yasnippet/skeleton-mode can do templates with positioning after expansion
;;
;; ===== Abbrev - native =====================================================================
;; http://www.emacswiki.org/emacs/AbbrevMode
;; 
;;   stored where?  ~/.abbrev_defs    can use dropbox? check:
(message "abbrev mode")
(setq abbrev-file-name (concat dropbox-root-path "/.emacs.d/abbrev_defs"))
(setq save-abbrevs t) ;; save abbrevs when files saves and quit emacs
(setq-default abbrev-mode t) ;; turn on abbrev-mode globally
;;   use?     M-' if abbrev-mode not on;    C-/ (undo)  C-q (quote/escape - don't expand)
;;            expand within word:   re<M-'>cnstr<space> ->   reconstruction (if cnstr expands to construction)
;;   add      C-x a i g
;;   edit     M-x edit-abbrev   (C-x C-s to save; C-c C-c to install)

    ;; to enable abbrev-mode only for certain modes and derived modes:
    ;; (dolist (hook '(erc-mode-hook
    ;;                 emacs-lisp-mode-hook
    ;;                 text-mode-hook))
    ;;   (add-hook hook (lambda () (abbrev-mode 1))))

;; DAbbrev - dynamic abbrev
;; ;; yasnippet
;;  (require 'yasnippet)
;; ;; (add-to-list 'load-path "~/.emacs.d/yasnippet")
;; (add-to-list 'yas-snippet-dirs (concat dropbox-root-path "/.emacs.d/snippets"))
;;  (yas-global-mode 1)

;;  (defun yas-org-very-safe-expand ()
;;    (let ((yas-fallback-behavior 'return-nil))
;;      (and (fboundp 'yas-expand) (yas-expand))))

;;  (add-hook 'org-mode-hook
;;            (lambda ()
;;              (add-to-list 'org-tab-first-hook
;;                           'yas-org-very-safe-expand)
;;              ))
(message "auto-complete")
(message "auto-complete")
(message "auto-complete")
(message "auto-complete")
(message "auto-complete")
(message "auto-complete")
(message "auto-complete")
(message "auto-complete")
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories (concat dropbox-root-path "/.emacs.d/dict"))
;; (add-to-list 'ac-dictionary-files (concat dropbox-root-path "/.emacs.d/.dict"))
;; (ac-config-default)
;; ;;(ac-flyspell-workaround)

;; (require 'org-ac)
;; ;; Make config suit for you. About the config item, eval the following sexp.
;; ;; (customize-group "org-ac")
;; (org-ac/config-default)

(message "smart-tabs")
;;(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python 'ruby 'nxml)

;; C-u M-! date to insert date stamp

;; now we can do package-specific stuff
;; Sat Apr 11 10:36:51 Eastern Daylight Time 2015
;; linum on melpa not retrieved correctly on update...
;; (require 'linum-off)


;;; DIRED
(message "Configuring dired")
(require 'dired)
;;(require 'dired-sort-map)
;(load "dired+")

;(load "image-dired")

;; from dired-x
(define-key global-map "\C-x\C-j" 'dired-jump)
;; if in file, go to dired of it's dir; if in dir go up one level

;; Sorting of dired
(add-hook 'dired-load-hook (lambda () (require 'dired-sort-menu)))

(message "Configuring dired - done")



(message "org nonorg")

;; ****************************************************************************************************
;; ORG VS NON-ORG

(if org-switch-found
    (progn
      (message "loading %s for org-mode configuration" org-conf-el)
      (if (file-exists-p org-conf-el)
	(progn
	  (message "loading org-mode configuration file %s" (expand-file-name (concat dropbox-root-path "/.emacs.d/org.conf.el")))
	  (load-file org-conf-el)))
        (message "%s not found to load for org-mode configuration" org-conf-el)
      )
)

(unless org-switch-found ;; things to do if NOT in org mode
  (progn
    (message "Loading emacs server")   
    (load "server")
    (unless (server-running-p)
      (progn
	(message "Starting emacs server.")
	(server-start)))
	(require 'edit-server)
	(edit-server-start)
  )
) ;; done with non-org stuff



  )
) ;; done with non-quick stuff


(message "<dropbox>/.emacs.d/emacs.conf.el - done")


;;; NOTES

;; EMACS HANGING ON EXIT
;; (setq debug-on-quit 't) ;; for debugging hangs - hit C-g when it hangs, should get backtrace, or try starting from terminal
;; http://www.chemie.fu-berlin.de/chemnet/use/info/elisp/elisp_16.html
;; http://yoo2080.wordpress.com/2013/10/03/what-to-do-when-emacs-hangs-freezes-or-crashes/
;; debug-on-entry RET call-process RET

;; See - http://lists.gnu.org/archive/html/bug-gnu-emacs/2013-05/msg00460.html
;; check procexp if hung for thread with stack ... ending in wow64cpu.ddl!TurboDisplatchJumpAddressEnd
;; that is somehow in Emacs stack _sys_wait_accept / reader_thread
;; kill that and see if it exits

;; could package repo settings be the source of the hang-on-exit problem? open connections to these archives?
;; try removing these

;; command line option handling
;; (defun do-org-argument-fn (switch)
;;   (progn
;;     (message "Received -org command-line switch.")
;;     (setq do-org t)))
;; (add-to-list 'command-switch-alist '("-org" . do-org-argument-fn))

    ;; ****************************************************************
    ;; Emacs Code Browser
    ;;;(add-to-list 'load-path (concat local-site-lisp-path "/ecb"))
    ;;;(require 'ecb)
    ;;(require 'ecb-autoloads)
					; to start ecb use M-x ecb-activate

    ;; ***************************************************************
    ;; for Linux only (dbus) 
    ;; From: http://emacs-fu.blogspot.com/2011/12/sauron-keeping-eye-on-whats-going-on.html
					;(add-to-list 'load-path "c:/sys/site-lisp/sauron")
					;(require 'sauron)
    ;;; *****************************************************************
    ;;; TRAMP - remote file editing
					;(setq tramp-default-method "ssh")
    ;;;    C-x C-f /remotehost:filename  RET (or /method:user@remotehost:filename)

    ;;; *****************************************************************
    ;;; Source Control Integration
    ;; (message (concat "Source control integration for " (system-name)))
    ;; (cond
    ;; ;; ((string-match "HOMEPC" (system-name))
    ;; ;;  ;;; none yet
    ;; ;;  )
    ;; ;; ((string-match "ComposerDevU" (system-name))
    ;; ;;  ;;; none yet
    ;; ;;  )
    ;;  ((string-match "USWIC-L-0074462" (system-name))
    ;;         (setq directory-sep-char ?/)
    ;;         (require 'source-safe)
    ;;         (setq ss-username "usrodav2"
    ;; 	      ;; ss-password ""
    ;; 	      ss-program "SS.exe"
    ;;               ss-project-dirs '(("^D:\\\\VSS-HarmonyAPI\\\\" . "$/")))
    ;; ;;              ss-project-dirs '( (\"^D:/VSS-HarmonyAPI/\" . \"$/\") )
    ;;   )
    ;;   ((string-match "C64DEVROB" (system-name))
    ;;         (setq directory-sep-char ?\\ )
    ;; 	(require 'source-safe)
    ;; 	(setq ss-username "usrodav2"
    ;; 	      ;; ss-password ""
    ;; 	      ss-program "SS.exe"
    ;;               ss-project-dirs '(("^D:\\\\VSS-HarmonyAPI\\\\" . "$/")))
    ;; ;;              ss-project-dirs '( (\"^D:/VSS-HarmonyAPI/\" . \"$/\") )
    ;;   )
    ;; )

