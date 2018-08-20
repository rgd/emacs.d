(message "Configuring for org-mode")

(cond
 ((string-match "HOMEPC" (system-name))
  (defvar dropbox-root-path "~/dropbox")
  )
 ((string-match "robslaptop" (system-name))
  (defvar dropbox-root-path "c:/rgd/dropbox")
  )
 ((string-match "composerD20" (system-name)) ;; Lenovo ThinkStation D20 Ubuntu box
  (defvar dropbox-root-path "~/dropbox")
  )
 ((string-match "USWIC-L-0074462" (system-name))
  (defvar dropbox-root-path "c:/rgd/dropbox")
  )
 ((string-match "US-L-7002395" (system-name))
  (defvar dropbox-root-path "d:/rgd/dropbox")
  )
 ((string-match "C64DEVROB" (system-name))
	(defvar dropbox-root-path "c:/rgd/dropbox")  )
 ((string-match "HAPIBUILD1" (system-name))
	(defvar dropbox-root-path "c:/rgd/dropbox")  )
)


(message "move this to main init .emacs file - pass command line parameter to indicate starting org mode")
(message "maybe sizing will work and only one place for dropbox-root-path setup etc")
(message "and if parameter found then load startorg.el")

(setq new-frame-width  (/ (- (display-pixel-width)  100) (frame-char-width)))
(setq new-frame-height (/ (- (display-pixel-height) 100) (frame-char-height)))
(message "New frame %d x %d" new-frame-width new-frame-height)
(set-frame-width (selected-frame) new-frame-width) 
(set-frame-height (selected-frame) new-frame-height) 

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if (display-graphic-p)
      (progn
	(set-frame-width (selected-frame) (/ (- (display-pixel-width) 100) (frame-char-width)))
	(set-frame-height (selected-frame) (/ (- (display-pixel-height) 100) (frame-char-height)))
)))

;; (defun set-frame-size-according-to-resolution ()
;;   (interactive)
;;   (if (display-graphic-p)
;;       (progn
;; 	;; use 120 char wide window for large-ish displays
;; 	;; and 80 char wide windows for small-ish displays
;; 	(if (> (display-pixel-width) 1280)
;; 	    (add-to-list 'default-frame-alist (cons 'width 132))
;; 	    (add-to-list 'default-frame-alist (cons 'width 80)))
;; 	;; for height, subtract a couple hundred pixels from screen height
;; 	(add-to-list 'default-frame-alist
;; 		     (cons 'height (/ (- (display-pixel-height) 200)
;; 				      (frame-char-height)))))))

;(set-frame-size-according-to-resolution)


(message "Configuring for org-mode")

(global-set-key (kbd "C-c t") (lambda ()
				 (interactive)
				 (find-file (concat dropbox-root-path "/org/todo.org"))
				 ))

(global-set-key (kbd "C-c e") (lambda ()
				 (interactive)
				 (find-file (concat dropbox-root-path "/.emacs.d/startorg.el"))
				 ))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; ;; this #$%^#$% thing isn't working - suspect its run too late and frame already created
;; ;; and set-frame-* doesn't affect things (calling it interactively now works. Great.)
;; ;; which, since I'm using this as a special startup file and avoiding other init files
;; ;; not sure where I'd put this.
;; ;; so using emacs -geometry 132x60+100+50 .... to invoke it. Sigh.
;; (defun set-frame-size-according-to-resolution ()
;;   (interactive)
;;   (if (display-graphic-p)
;;     (progn
;; 	;; use 120 char wide window for large-ish displays
;; 	;; and 80 char wide windows for small-ish displays
;; 	(if (> (display-pixel-width) 1280)
;; 	    (progn
;; 	      (message "Setting wide width")
;; 	      (add-to-list 'default-frame-alist (cons 'width 132))
;; 	      (add-to-list 'initial-frame-alist (cons 'width 132))
;; ;	      (set-frame-width (selected-frame) 132)
;;              )
;; 	    (progn
;; 	      (message "Setting narrow width")
;; 	      (add-to-list 'default-frame-alist (cons 'width 80))
;; 	      (add-to-list 'initial-frame-alist (cons 'width 80))
;; ;	      (set-frame-width (selected-frame) 80)
;; 	    )

;; 	;; for height, subtract a couple hundred pixels from screen height
;; 	(setq my-height (/ (- (display-pixel-height) 200) (frame-char-height)))
;; 	(add-to-list 'default-frame-alist
;; 		     (cons 'height (/ (- (display-pixel-height) 200)
;; 				      (frame-char-height))))
;; 	(add-to-list 'initial-frame-alist
;; 		     (cons 'height (/ (- (display-pixel-height) 200)
;; 				      (frame-char-height))))
;; ;	(set-frame-height (selected-frame) my-height)

;; 	(setq org-tags-column (- 4 (frame-width)))
;; 	(message "Set tags column %S" org-tags-column)
;;       ))))

;; (set-frame-size-according-to-resolution)
;(add-hook 'window-setup-hook 'set-frame-size-according-to-resolution)

 (message "Default frame alist: %S" default-frame-alist)
 (message "Initial frame alist: %S" initial-frame-alist)
 (message "Frame height %S" (frame-height))
 (message "Frame width  %S" (frame-width))
;; ;(setq frame-width 132)
;; (message "Frame width  %S" (frame-width))

(setq org-tags-column (- 4 (frame-width)))
(message "Tags column %S" org-tags-column)


;;; set size and position

;; ;;; ****************************************************************
;; ;;; ORG-MODE
;; ;;;
;; (add-to-list 'load-path (concat local-site-lisp-path "/org-8.2.4/lisp"))
;; (add-to-list 'load-path (concat local-site-lisp-path "/org-8.2.4/contrib/lisp") t)
;; ;;(add-to-list 'load-path (concat local-site-lisp-path "/org-trello-20140203.254") t)

;; (require 'org)
(setq inhibit-startup-screen t)
(setq org-directory (concat dropbox-root-path "/org"))
(setq org-mobile-inbox-for-pull (concat dropbox-root-path "/org/flagged.org")) ;; from-mobile.org
(setq org-mobile-directory (concat dropbox-root-path "/Apps/MobileOrg"))  ;; dropbox/org/mobile ??
(global-set-key (kbd "C-c l") 'org-store-link)

(setq backup-path (concat dropbox-root-path "/org/.backup"))

(setq backup-directory-alist '(("." . "~/.backup")))
;; (setq backup-directory-alist '(("." . (expand-file-name backup-path)))
(setq backup-by-copying t)
;(setq delete-old-version t
;      kept-new-versions 6
;      kept-old-versions 2
;      version-control t)

(setq org-agenda-files '("~/local.org"))
(add-to-list 'org-agenda-files (expand-file-name (concat dropbox-root-path "/org")))

;; (setq org-agenda-files (quote (
;;    (concat dropbox-root-path "/org/todo.org") 
;;    (concat dropbox-root-path "/org/abbtodo.org") 
;;    (concat dropbox-root-path "/org/work.org") 
;;    (concat dropbox-root-path "/org/home.org") 
;;    (concat dropbox-root-path "/org/rel.org")
;;    (concat dropbox-root-path "/org/org-notes.org") 
;;    (concat dropbox-root-path "/org/emacs-notes.org")
;; )))

;; Place tags close to the right-hand side of the window
;; (add-hook 'org-finalize-agenda-hook 'place-agenda-tags)
;; (defun place-agenda-tags ()
;;   "Put the agenda tags by the right border of the agenda window."
;;   (setq org-agenda-tags-column (- 4 (window-width)))
;;   (org-agenda-align-tags))

;; ;; not needed when using package system : ;;(require 'org-trello)
;; ;; ;; v--- seems required for org-trello
;; ;; (require 'cl)
;; ;; disabling until get it working from behind proxy
;; ;; (add-hook 'org-mode-hook 'org-trello-mode)

;; (message "Configuring org - done.")
