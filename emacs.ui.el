;; UI setup
;;
(defvar startup-width-ratio 0.75)
(defvar startup-height-ratio 0.95)
(defvar startup-top-ratio 0.005)
(defvar startup-left-ratio 0.10)


(defun rgd/initial-frame-setup (&optional frame)
"rgd: set the initial-frame-alist parameters - minimal acceptable settings, trying to match ones set in registry/~/.XResources"
  (progn
    (add-to-list 'initial-frame-alist '(height . 24))
    (add-to-list 'initial-frame-alist '(width . 80))  
;;    (add-to-list 'initial-frame-alist '(font . "Lucida Console"))  
  )
)



(defun rgd/default-frame-setup ()
  "rgd: setup default-frame-alist parameters frame"
  (progn 
	 (message "rgd/default-frame-setup")
	 
     (if (display-graphic-p)
	     (progn 
		   (message "Graphic display detected")
		   (display-monitor-attributes-list))
	   (progn
		 (message "Non-graphic display detected") ;; daemon, batch, -nw modes?
		 (display-monitor-attributes-list))
	   )

	 (add-to-list 'default-frame-alist '(height . 50))  ;; make proportional to font size... see ratios above
	 (add-to-list 'default-frame-alist '(width . 130))
     (add-to-list 'default-frame-alist '(top . 60))
	 (add-to-list 'default-frame-alist '(left . 120))
	 
     (message "default frame setup:")
	 (prin1 default-frame-alist)

     ;; https://www.reddit.com/r/emacs/comments/25v0eo/you_emacs_tips_and_tricks/
     (setq frame-title-format '(buffer-file-name "Emacs: %b (%f)" "Emacs: %b"))
	 
	)
   (message "rgd/default-frame-setup - done")
)


(defun rgd/new-frame-setup ()
"rgd: setup new frame configuration based on monitor attributes - UNFINISHED"
(interactive)
  (progn
     (message "rgd/new-frame-setup")
	 
     (if (display-graphic-p)
	     (progn 
		   (message "Graphic display detected")
		   (display-monitor-attributes-list (selected-frame)))
		 (progn
		   (message "Non-graphic display detected") ;; daemon, batch, -nw modes?
		   (display-monitor-attributes-list (selected-frame)))
	 )

     ;; get dimensions of monitor
     (setq mon-left   (nth 1 (nth 1 (nth 0 (display-monitor-attributes-list)))))
	 (setq mon-top    (nth 2 (nth 1 (nth 0 (display-monitor-attributes-list)))))
	 (setq mon-width  (nth 3 (nth 1 (nth 0 (display-monitor-attributes-list)))))
	 (setq mon-height (nth 4 (nth 1 (nth 0 (display-monitor-attributes-list)))))

	  ;; calculate new frame parameters based on monitor attributes and ratios at top of file
     (setq new-frame-left (round (* mon-width  startup-left-ratio)))
     (setq new-frame-top (round (* mon-height startup-top-ratio)))
     (setq new-frame-width  (/ (round (* mon-width startup-width-ratio))  (frame-char-width)))
     (setq new-frame-height (/ (round (* mon-height startup-height-ratio)) (frame-char-height)))
	 
	 ;; log new values
     (message "new-frame-left %d" new-frame-left)	 
     (message "new-frame-top %d" new-frame-top)	 
     (message "new-frame-width  %d" new-frame-width)
     (message "new-frame-height %d" new-frame-height)

	 ;; update the frame with those values
	(set-frame-size (selected-frame) new-frame-width new-frame-height)
	(set-frame-position (selected-frame) new-frame-left new-frame-top)	
	
	(message "rgd/new-frame-setup - done")	
	)
)

(setq emacs-ui-frame-el (expand-file-name (concat dropbox-root-path "/.emacs.d/emacs.ui-frame.el")))
(declare-function rgd/pre-setup-frame emacs-ui-frame-el)
(declare-function rgd/post-setup-frame emacs-ui-frame-el)

(defun rgd/invoke-pre-setup-frame ()
	"called in before-make-frame-hook if in daemon mode; otherwise call rgd/setup-frame directly"
	(progn
		(message "invoking pre frame setup code")
		;;(load-file emacs-ui-frame-el)
		
	    (rgd/pre-setup-frame (selected-frame))
	)
)

(defun rgd/invoke-post-setup-frame (frame)
	"called in after-make-frame-functions if in daemon mode; otherwise call rgd/setup-frame directly"
	(with-selected-frame frame
		(message "invoking post frame setup code")
		
		;;(rgd/new-frame-setup frame) -- be nice if this worked to resize frame based on monitor -- some day...
		
	    (rgd/post-setup-frame)
	)
)
