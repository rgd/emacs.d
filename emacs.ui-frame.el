;; do things requiring a frame (i.e. not for daemon mode)



(defun rgd/pre-setup-frame (frame)
  "Frame setup code; to be done before a frame is created in before-make-frame-hook; 
  called every time a new frame is created (take note - or else remove-hook somewhere)"
  (progn
    (message "executing pre-frame creation UI setup code")

	;; (rgd/default-frame-setup frame)
  )
)
	
(defun rgd/post-setup-frame ()
  "Do frame setup that can't be done in daemon mode startup; that requires fonts/frames to be initialized.
  ******** TODO *******  do a remove-hook somewhere to stop it
  
  based on https://lists.gnu.org/archive/html/help-gnu-emacs/2016-05/msg00182.html - it seems for initial frame in daemon mode it doesn't get called with frame parameters
  "
  
 ;; (with-selected-frame frame
  
  (progn
	(message "executing post-frame creation UI setup code")
	
	(display-time-mode 1)
	
	(setq visible-bell 1)

	(setq cursor-in-non-selected-windows '(hbar . 3))
	
	;; font stuff?  Literation Mono, Source Code Pro, D2Coding ??
	(if (display-graphic-p)
	  (progn
	    ;; default ------
		  
	      ;; DejaVu Sans Mono - nice but a tad bit narrow
          ;; (set-face-font 'default "-outline-DejaVu Sans Mono-normal-normal-normal-mono-14-*-*-*-c-*-iso8859-1")

		  ;; Consolas
		  (set-face-font 'default "-outline-Consolas-normal-normal-normal-mono-16-*-*-*-c-*-iso8859-1")
		
	    ;; modeline ------
		  ;; Droid Sans Mono - a little ragged
		  ;; (set-face-attribute 'mode-line nil :font
		  ;;                  "-outline-Droid Sans Mono for Powerline-normal-normal-normal-mono-14-*-*-*-c-*-iso8859-1")

		  ;; Source Code Pro for Powerline
		  (set-face-attribute 'mode-line nil :font
							  "-outline-Source Code Pro Semibold-semibold-normal-normal-mono-15-*-*-*-c-*-iso8859-1")
		  (set-face-attribute 'mode-line-inactive nil :font
							  "-outline-Source Code Pro Semibold-semibold-normal-normal-mono-15-*-*-*-c-*-iso8859-1")

		  ;; D2Coding - some oddities on right-end of mode-line 
          ;; (set-face-attribute 'mode-line nil :font
		  ;;                     "-outline-D2Coding for Powerline-normal-normal-normal-mono-15-*-*-*-c-*-iso8859-1")

		  (if (featurep 'org-bullets)
			(org-bullets-mode 1))
	  )
	)

	(set-scroll-bar-mode 'left)

	(with-timer "mode icons"
	  (use-package mode-icons
		:config
		(mode-icons-mode)      ) 	)
	
    (with-timer "powerline"
      (use-package powerline
		:config
		(powerline-default-theme)      )	)
  )
)


