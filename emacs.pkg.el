;; ****************************************************************
;; PACKAGE SETUP
;;
(message "packages start - emacs.pkg.el")

(setq load-prefer-newer t) ;; Load newer version of .el and .elc if both are available ; kmodi

(require 'package)
(setq package-enable-at-startup nil) ;; defer until (package-init)

(defvar dropbox-package-path (concat dropbox-root-path "/.emacs.d/elpa/"))
(setq package-user-dir dropbox-package-path)

(setq package-archive-priorities
      '( ;; ("melpa-stable" . 20)
         ;; ("marmalade" . 20)
        ("gnu" . 10)
        ("melpa" . 0)))

(with-timer "package-initialize"
 (package-initialize))

 
(require 'use-package)
 
;; use-package: 	https://github.com/jwiegley/use-package
;;     :ensure t   - load package from ELPA via package.el if not present
;;     :init executes at before loading package; (keep small/quick!)
;;     :config after package loaded (or after autoload); here uses package-edit after loading package
;;     :commands - commands to autoload
;;     :bind - bind keys (globally)
;;       :map - sub to :bind, binds in that map
;;     :magic - executes sexp if beginning of buffer matches regexp
;;     :custom - equiv to setq of package custom variables
;;     :custom-face - customize package custom faces
;;     :defer t - implied if use :bind :mode :interpreter
;;     :if - only load if predicate true (alias :when)  (:unless means :if (not foo))
;;     :after - load package after others
;;     :requires - doesn't load package if dependencies aren't available 
;;     :load-path - adds directory to load-path
;;     :diminish - if have diminish loaded, passes keyword to diminish
;;     :delight - customize symbol used in mode line
;;
;;example:
;; (with-timer "package"
;;   (use-package package
;;     :if window-system
;;     :if (memq window-system '(mac ns)) ;;??
;;     :ensure t
;;     :magic ("%PDF" . package-pdf-view-mode)
;;     :commands 
;;       (package-function)
;;     :init
;;       (setq package-max-menu-items 25)
;;       (package-mode 1)
;;     :bind
;;       (("C-x C-r" . package-read-files)
;;        ("[S-f10]" . packaage-open-files-greedy)
;;        ("[f10]" . package-open-files)
;;       :map package-mode-map
;;         ("M-o" . package-func2))
;;     :config 
;;        (use-package package-edit)
;;     :custom
;;        (package-max-files 10 "max files") ;; docstring optional
;;        (package-read-only t "view readonly")
;;     :after (pre-package package-parent)
;;     :defer 3
;;   )
;; )

(with-timer "sunshine"
  (use-package sunshine
	:config
	(setq sunshine-appid "9e78b67db4d4e5c678aa0efb35551ac9")
	(setq sunshine-show-icons t)
	(set-face-attribute 'sunshine-forecast-date-face nil :foreground "blue")
	(set-face-attribute 'sunshine-forecast-headline-face nil :foreground "goldenrod" :height 1.5)
	:defer 3
	)
)

 
(with-timer "recentf"
 (use-package recentf
   :commands (recentf-open-files)
   :init
     (setq recentf-max-menu-items 25)
     (setq recentf-auto-cleanup 'never)
     (setq recentf-save-file (expand-file-name (concat dropbox-root-path "/.emacs.d/recentf" ))) ;; add machine name???
     (setq recentf-keep '(file-remote-p file-readable-p))
   :config
     (recentf-mode 1)
     (setq recentf-exclude '(".*-autoloads\\.el\\"
	      					  "[/\\]\\.elpa/"))  ;; https://www.reddit.com/r/emacs/comments/5wydsd/stop_recent_files_showing_elpa_packages/
   :bind   
     ("C-x C-r" . recentf-open-files)
   :defer 3
 )
)

(with-timer "page-break-lines"
 (use-package page-break-lines
	:defer 5
	:config
	   (global-page-break-lines-mode)
  )
)

;; Browse Kill Ring  (look for browse-kill-ring+.el ... )
;;
;;  or use Edit > Paste from Kill menu (not as nice)
;;
;;  or    ("C-M-y" . counsel-yank-pop)
;;
(with-timer "browse-kill-ring"
  (use-package browse-kill-ring
	:defer 5
	:commands (browse-kill-ring)
    :config
	(setq browse-kill-ring-replace-yank t) ;; act like yank-pop
	(setq browse-kill-ring-show-preview t) ;; display where item under point in *Kill Ring* buffer would be inserted
	(setq browse-kill-ring-highlight-current-entry t)  ;; highlight current entry
	:bind 
		("C-c k" . browse-kill-ring)
	)
)


(with-timer "whitespace"
	(use-package whitespace
      :bind 
	     (("C-c T w" . whitespace-mode))
      :config 
	     (setq whitespace-line-column nil)
      :defer 5
	)
 )

(with-timer "smex"
  (use-package smex
	:ensure t
	:init
      (smex-initialize)
	:bind
	  (("M-X" . smex-major-mode-commands)
       ("C-c M-x" . smex)
	   ("C-c C-c M-x" . execute-extended-command))
	:defer 2
    :config
       (setq smex-auto-update nil) ;; slight speed increase
       (defadvice ido-set-matches-1 (around ido-smex-acronym-matches activate)
           "Filters ITEMS by setting acronynms first - so ffow shows find-file-other-window before other matches."
         (if (and (fboundp 'smex-already-running) (smex-already-running) (> (length ido-text) 1))
         (let ((regex (concat "^" (mapconcat 'char-to-string ido-text "[^-]*-")))
            (matches (make-hash-table :test 'eq)))
           ;; Filtering
          (dolist (item items)
            (let ((key))
              (cond
               ;; strict match
               ((string-match (concat regex "[^-]*$") item)
                (setq key 'strict))
               ;; relaxed match
               ((string-match regex item)
                (setq key 'relaxed))
               ;; text that start with ido-text
               ((string-match (concat "^" ido-text) item)
                (setq key 'start))
               ;; text that contains ido-text
               ((string-match ido-text item)
                (setq key 'contains)))
              (when key
                ;; We have a winner! Update its list.
                (let ((list (gethash key matches ())))
                  (puthash key (push item list) matches)))))
          ;; Finally, we can order and return the results
          (setq ad-return-value (append (gethash 'strict matches)
                                        (gethash 'relaxed matches)
                                        (gethash 'start matches)
                                        (gethash 'contains matches))))
         ;; ...else, run the original ido-set-matches-1
        ad-do-it))
  )
)


;; neat -- use M-o while in counsel-M-x to get menu to get help, goto definition etc on current highlighted command !

(with-timer "counsel"
 (use-package counsel 
  :bind
    (("M-x" . counsel-M-x) ;; maybe don't use this - trying to not have counsel used with dired C-x d
     ("C-s" . swiper)
     ("C-x C-f" . counsel-find-file)
     ("C-x r f" . counsel-recentf)
     ("C-x l" . counsel-locate)
;    ("C-c g s" . counsel-grep-or-swiper)
     ("C-M-y" . counsel-yank-pop)
     ("C-c C-r" . ivy-resume)
;    ("C-c i m" . counsel-imenu)
;    ("C-c i M" . ivy-imenu-anywhere)
;    ("[f1] f" . counsel-describe-function)
;    ("[f1] v" . counsel-describe-variable)
;    ("[f1] x" . counsel-info-lookup-symbol)
     ("C-c d d" . counsel-descbinds)                        ;; <---- Nice!
     ("C-c d s" . describe-symbol)
     ("C-c d u" . counsel-unicode-char)
;    ("C-c g g" . counsel-git)
;    ("C-c s s" . counsel-ag)
;    ("C-c s d" . counsel-ag-projectile)
;    ("C-c g G" . counsel-git-grep)
     :map ivy-minibuffer-map
       ("M-y" . ivy-next-line-and-call))
  :config
    (defun reloading (cmd)
      (lambda (x)
       (funcall cmd x)
       (ivy--reset-state ivy-last)))
    (defun given-file (cmd prompt) ; needs lexical-binding
      (lambda (source)
       (let ((target
        (let ((enable-recursive-minibuffers t))
          (read-file-name
        (format "%s %s to:" prompt source)))))
        (funcall cmd source target 1))))
    (defun confirm-delete-file (x)
      (dired-delete-file x 'confirm-each-subdirectory))
    (ivy-add-actions
      'counsel-find-file
       `(("c" ,(given-file #'copy-file "Copy") "copy")
         ("d" ,(reloading #'confirm-delete-file) "delete")
         ("m" ,(reloading (given-file #'rename-file "Move")) "move")))

    (setq counsel-find-file-at-point t)
  
  :defer 2
 )
)

;; HYDRA package configuration
(with-timer "hydra"
  (use-package hydra)
)

;; HYDRAS


;; YANK-POP HYDRA

(defhydra hydra-yank-pop ()
"hydra-yank-pop
   C-y yank
   M-y yank-pop
   y   yank-pop, next
   Y   yank-pop, prev
   c   counsel-yank-pop
   l   browse kill ring
  "
  ("C-y" yank nil)
  ("M-y" yank-pop nil)
  ("y" (yank-pop 1) "next")
  ("Y" (yank-pop -1) "prev")
  ("c" (counsel-yank-pop) "counsel" :color blue)
  ("l" browse-kill-ring "list" :color blue))
(global-set-key (kbd "M-y") #'hydra-yank-pop/yank-pop)
(global-set-key (kbd "C-y") #'hydra-yank-pop/yank)

;; GOTO LINE HYDRA

(defhydra hydra-goto-line (goto-map ""
                           :pre (linum-mode 1)
                           :post (linum-mode -1))
  "goto-line hydra, e.g.:
   M-g 50 RET => goto line 50        5 5 g  => jump ahead to line 55
   m  => set mark                    6 5 g  => extend marked region to line 65
   M-w => save region to kill-ring and exit hydra
  "
  ("g" goto-line "go")
  ("m" set-mark-command "mark" :bind nil)
  ("q" nil "quit"))
(global-set-key (kbd "M-g") #'hydra-goto-line/body) ;; or #'hydra-goto-line/goto-line ?



;; RECTANGLE HYDRA

(defhydra hydra-rectangle (:body-pre (rectangle-mark-mode 1)
                                     :color pink
                                     :hint nil
                                     :post (deactivate-mark))
  "
  ^_k_^       _w_ copy      _o_pen       _N_umber-lines            |\\     -,,,--,,_
_h_   _l_     _y_ank        _t_ype       _e_xchange-point          /,`.-'`'   ..  \-;;,_
  ^_j_^       _d_ kill      _c_lear      _r_eset-region-mark      |,4-  ) )_   .;.(  `'-'
^^^^          _u_ndo        _g_ quit     ^ ^                     '---''(./..)-'(_\_)
"
  ("k" rectangle-previous-line)
  ("j" rectangle-next-line)
  ("h" rectangle-backward-char)
  ("l" rectangle-forward-char)
  ("d" kill-rectangle)                    ;; C-x r k
  ("y" yank-rectangle)                    ;; C-x r y
  ("w" copy-rectangle-as-kill)            ;; C-x r M-w
  ("o" open-rectangle)                    ;; C-x r o
  ("t" string-rectangle)                  ;; C-x r t
  ("c" clear-rectangle)                   ;; C-x r c
  ("e" rectangle-exchange-point-and-mark) ;; C-x C-x
  ("N" rectangle-number-lines)            ;; C-x r N
  ("r" (if (region-active-p)
           (deactivate-mark)
         (rectangle-mark-mode 1)))
  ("u" undo nil)
  ("g" nil))      ;; ok
(global-set-key (kbd "C-x SPC") 'hydra-rectangle/body)


;; UNICODE HYDRA

(defun my/insert-unicode (unicode-name)
  "Same as C-x 8 enter UNICODE-NAME."
  (insert-char (cdr (assoc-string unicode-name (ucs-names)))))

(global-set-key
 (kbd "C-x 9")
 (defhydra hydra-unicode (:hint nil)
   "
        Unicode  _e_ €  _s_ ZERO WIDTH SPACE
                 _f_ ♀  _o_ °   _m_ µ
                 _r_ ♂  _a_ →
        "
   ("e" (insert-char #x20ac))
   ("r" (my/insert-unicode "MALE SIGN"))
   ("f" (my/insert-unicode "FEMALE SIGN"))
   ("s" (my/insert-unicode "ZERO WIDTH SPACE"))
   ("o" (insert-char #xb0))   ;; "DEGREE SIGN"
   ("a" (insert-char #x2192)) ;; "RIGHTWARDS ARROW"
   ("m" (insert-char #xb5))   ;; "MICRO SIGN"
 )
)


   
(with-timer "ivy"
  (use-package ivy
	:ensure t
	:defer 1
;	:after (hydry swiper ivy-posframe ivy-rich)
	:init
      (use-package swiper)
      (use-package ivy-posframe)
      (use-package ivy-rich
     	:init
        (ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer)
	  )
	:config
      (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))) ;; use fuzzy searching (spaces not needed)
      (setq ivy-initial-inputs-alist nil) ;; not needed if using ivy--regex-fuzzy
      (ivy-mode 1)
      (setq ivy-height 10) ;; number of result lines to display
      (setq ivy-count-format "(%d/%d) ")

	  (defun ivy-posframe-display-at-window-top-left-corner (str)
		(ivy-posframe--display str #'posframe-poshandler-window-top-left-corner))
	  
      ;; (setq ivy-display-function #'ivy-posframe-display-at-frame-center)
      ;; (setq ivy-display-function #'ivy-posframe-display-at-window-center)
      (setq ivy-display-function #'ivy-posframe-display-at-window-top-left-corner)
      ;; (setq ivy-display-function #'ivy-posframe-display-at-frame-bottom-left)
      ;; (setq ivy-display-function #'ivy-posframe-display-at-window-bottom-left)
      ;; (setq ivy-display-function #'ivy-posframe-display-at-point)
      ;; (setq ivy-display-function #'ivy-posframe-display-at-frame-bottom-window-center)
      ;;alternative:
      ;; Different command can use different display function.
      ;;   (push '(counsel-locate . ivy-posframe-display-at-point) ivy-display-functions-alist)
      ;;   (push '(counsel-M-x . ivy-posframe-display-at-frame-bottom-window-center) ivy-display-functions-alist)
      ;;   (push '(complete-symbol . ivy-posframe-display-at-point) ivy-display-functions-alist)
      ;;   (push '(t . ivy-posframe-display) ivy-display-functions-alist)
      (ivy-posframe-enable)
  )
)


;; SPEEDBAR
(with-timer "speedbar"
   (use-package sr-speedbar
      :commands sr-speedbar-toggle
	  :bind
	     (
		   ([f9] . sr-speedbar-toggle)
		   :map speedbar-mode-map
		   ("<right>" . speedbar-expand-line)
		   ("<left>" . speedbar-contract-line)
		 )
	)
)



(with-timer "dired"
 (use-package dired
   :commands (dired-jump)
   :config
     (use-package dired+)
     (use-package dired-sort-menu)
     (use-package dired-sort-menu+)
   :defer 4
 )
)


;; Spell checking
;; https://lists.gnu.org/archive/html/help-gnu-emacs/2014-04/msg00030.html
;;
(with-timer "ispell"
  (use-package ispell
	:defer 15
    :init
      (setq ispell-local-dictionary-alist
	    	'(
		      (nil
		       "[[:alpha:]]"
		       "[^[:alpha:]]"
		       "[']"
		       t
		       ("-d" "default" "-p" "c:\\sys\\ezwinports\\share\\hunspell\\personal.en")
		       nil
		       iso-8859-1)
		      ("en_US"
		       "[[:alpha:]]"
		       "[^[:alpha:]]"
		       "[']"
		       t
		       ("-d" "en_US" "-p" "c:\\sys\\ezwinports\\share\\hunspell\\personal.en")
		       nil
		       iso-8859-1)
		     )
	  )
     (setq ispell-dictionary "en_US")
     (setq ispell-local-dictionary "en_US") 
     (setq ispell-really-hunspell t)
	 (setq ispell-hunspell-dictionary-alist ispell-local-dictionary-alist)
	:config
	 (progn
	  (dolist (hook '(text-mode-hook))
          (add-hook hook (lambda () (flyspell-mode 1))))
      (dolist (hook '(change-log-mode-hook log-edit-mode-hook))
          (add-hook hook (lambda () (flyspell-mode -1))))
      (add-hook 'c++-mode-hook
          (lambda ()
             (flyspell-prog-mode) 
		  )
	  )
	  (setq ispell-program-name "hunspell")
	  (setq ispell-extra-args   '("-d en_US"))
	 )
      	  
  )
)




;; Calendar/Diary
(setq diary-file (concat dropbox-root-path "/.emacs.d/diary"))
(setq view-diary-entries-initially t
	  mark-diary-entries-in-calendar t
	  number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

(add-hook 'list-diary-entries-hook 'sort-diary-entries t)

;; (setq calendar-week-start-day 1) ;; Monday

;; add week numbers
(setq calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'font-lock-warning-face))

(setq calendar-intermonth-header
      (propertize "Wk"                  ; or e.g. "KW" in Germany
                  'font-lock-face 'font-lock-keyword-face))



;; auto-fill for text modes
(setq-default fill-column 100)

;;; turn on auto-fill for all text mode buffers
(add-hook 'text-mode-hook '(lambda ()
                             (auto-fill-mode 1)))

;;; key sequence to enable auto-fill mode (if get used to this, disable above as sometimes you don't want autofill
(global-set-key (kbd "C-c q") 'auto-fill-mode)



;;; Default ag arguments
;; https://github.com/ggreer/the_silver_searcher
(defconst rgd/ag-arguments
  '("--nogroup" ;mandatory argument for ag.el as per https://github.com/Wilfred/ag.el/issues/41
    "--skip-vcs-ignores"                ;Ignore files/dirs ONLY from `.ignore'
    "--numbers"                         ;Line numbers
    "--smart-case"
    ;; "--one-device"                      ;Do not cross mounts when searching
    "--follow"                          ;Follow symlinks
    "--ignore" "#*#")                   ;Adding "*#*#" or "#*#" to .ignore does not work for ag (works for rg)
  "Default ag arguments used in the functions in `ag', `counsel' and `projectile' packages.")



(use-package mouse3)



