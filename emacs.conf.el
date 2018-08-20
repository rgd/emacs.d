;; prototype 'clean' emacs.conf.el
;; divide up into separate .el files:
;; 1) options
;; 2) UI setup
;; 3) machine-specific setup
;; 4) functions
;; 5) keymappings

;; - what GUI setup exactly is prohibited during daemon startup?
;; - how to write the hook to do the GUI setup correctly and at the right time?
;; - what about console-mode startup within cmd?
;; - set emacs to start daemon mode on login
;; - how to restart daemon after change requires it (since I fuss with config so much)? quickly?
;; - is it worth it over the current way (seperate gui/console use cases; gui startup is still only a few seconds;
;; - do lisp profiling on startup?

;; PROFILING
;; M-x profiler-start  ;; or eval (profiler-start 'cpu) (if profiling M-x!)
;; M-x profiler-report) ;; or eval (profiler-report)
;; M-x profiler-stop)

(message "<dropbox>/.emacs.d/emacs.conf.el - start")

;; from https://emacs.stackexchange.com/questions/539/how-do-i-measure-performance-of-elisp-code 
(defmacro with-timer (title &rest forms)
  "Run the given FORMS, counting the elapsed time.
A message including the given TITLE and the corresponding elapsed
time is displayed."
  (declare (indent 1))
  (let ((nowvar (make-symbol "now"))
        (body   `(progn ,@forms)))
    `(let ((,nowvar (current-time)))
       (message "%s..." ,title)
       (prog1 ,body
         (let ((elapsed
                (float-time (time-subtract (current-time) ,nowvar))))
           (message "%s... done (%.3fs)" ,title elapsed))))))


;; General Emacs options
;;
(setq emacs-opt-el (expand-file-name (concat dropbox-root-path "/.emacs.d/emacs.opt.el")))
(with-timer "emacs-opt"
  (load-file emacs-opt-el))

;; Define local functions
;;
(setq emacs-fn-el (expand-file-name (concat dropbox-root-path "/.emacs.d/emacs.fn.el")))
(with-timer "emacs-fn"
 (load-file emacs-fn-el))


;; Machine-specific setup
;;
(setq emacs-spec-el (expand-file-name (concat dropbox-root-path "/.emacs.d/emacs.spec.el")))
(with-timer "emacs-spec"
(load-file emacs-spec-el))


;; Define key mappings
;;
(setq emacs-key-el (expand-file-name (concat dropbox-root-path "/.emacs.d/emacs.key.el")))
(with-timer "emacs-key"
  (load-file emacs-key-el))




(unless (or quick-switch-found news-switch-found) ;; things to do if NOT in quick mode or news mode
  (progn


    ;; intialize package system and load packages
    ;;
    (setq emacs-pkg-el (expand-file-name (concat dropbox-root-path "/.emacs.d/emacs.pkg.el")))
 	(with-timer "emacs-pkg"
      (load-file emacs-pkg-el))


    ;; load org conf is -org
    ;;
    (if (or org-switch-found
			(daemonp))
      (progn
        (message "%s for org-mode config" org-conf-el)
        (if (file-exists-p org-conf-el)
	      (progn
	        (message "org-mode config %s"
					 (expand-file-name (concat dropbox-root-path "/.emacs.d/org.conf.el")))
			(with-timer "org-conf"
	         (load-file org-conf-el))
		  )
          (message "%s not found to load for org-mode configuration" org-conf-el)
		)
      )
    )

    ;; load emacs server if
	;; - not running as org mode emacs
	;; - not if the server is already running, 
	;; - not if in daemon mode because that will start the server itself,
	;; then we can start the server 
    (unless (or org-switch-found
	            (daemonp)
				(and (fboundp 'server-running-p)
				     (server-running-p)))
		(progn 
		  (with-timer "server" ;; use-package??
		    (use-package server
			  :config
              (server-start))
		  )
		)
    ) ;; done loading server stuff

    (with-timer "edit-server"
      (use-package edit-server
		:config
		(edit-server-start) )
    )

	;; UI setup - default frame geometry, fonts, etc. defines function rgd/default-frame-setup
    ;;
	
	;; emacs.ui.el - defuns default-frame-setup, new-frame-setup (set up frame parameters based on monitor [* no good under daemon??])
	;;               and invoker functions for pre/post hook functions (too much indirection??)
	;;
    (setq emacs-ui-el (expand-file-name (concat dropbox-root-path "/.emacs.d/emacs.ui.el")))
    (with-timer "emacs-ui"
      (load-file emacs-ui-el))

	(rgd/initial-frame-setup) ;; set initial-frame-alist parameters to match registry / ~/.XResources ;  defined in emacs.ui.el 
	(rgd/default-frame-setup) ;; set default-frame-alist to override registry/initial alist for subsequent frames
	  
   ;; emacs.ui-frame.el defuns the body of the pre and post setup frame functions that will be called by the invoker functions 
   ;;   i.e. the sexps we can't call when starting daemon mode because fonts/frames are not set up yet
   ;;   
   (setq emacs-ui-frame-el (expand-file-name (concat dropbox-root-path "/.emacs.d/emacs.ui-frame.el")))
   (load-file emacs-ui-frame-el)
   
   
   ;; if in daemon mode, defer doing the frame setup functions until just before/after frame is created
   ;; otherwise do it now
    
   (if (daemonp)
     (progn 
	    ;; if in daemon mode, defer until frame creation via emacsclient
	   (message "deferring UI frame setup")
;	   (add-hook 'before-make-frame-hook #'rgd/invoke-pre-setup-frame)
	   (add-to-list 'after-make-frame-functions #'rgd/invoke-post-setup-frame)    ;; apparently ineffective for initial frame (none in daemon mode) https://lists.gnu.org/archive/html/help-gnu-emacs/2016-05/msg00182.html
	   
	 )
	 (progn  
	   ;; otherwise just do it now
;	  (rgd/pre-setup-frame) 
	  (rgd/post-setup-frame)
	  )
	)
	
	
  )
) ;; done with non-quick/full-version stuff



(message "<dropbox>/.emacs.d/emacs.conf.el - done")
