
;; dashboard seems exceptionally slow only on work laptop - use 'dash' command to load it
;;  12/6/17 - now that daemon mode is working well, going to reinstate this for work laptop
;; 5/29/18 - turning back off as it's still slower than I'd like (at least on work laptop)
(if (not (string-match "US-L-7002395" (system-name)))
	  (progn
		(message "Loading dashboard")

		(defun rgd-dashboard-setup-startup-hook ()
		  "Setup post initialization hooks.
If a command line argument is provided, assume a filename and skip displaying Dashboard"
		  (if (< (length command-line-args) 2 )
			  (progn
				(add-hook 'after-init-hook (lambda ()
											 (dashboard-insert-startupify-lists)) ) ;; Display useful lists of items
				)
			)
		  )

		(defun dash ()
		  (interactive)
		  (progn
			(switch-to-buffer "*dashboard*")
			(goto-char (point-min))
			(redisplay)
			)
		  )


		(run-at-time "20 sec" nil #'dash) ;; load dashboard a minute after startup

		(with-timer "dashboard"
		  (use-package dashboard
			:config                                 ;; config defers until after autoloading occurs (i.e. package-initialize I think)
			(rgd-dashboard-setup-startup-hook)

			(setq dashboard-items '(
									(recents  . 5)
									(bookmarks . 5)
									(projects . 2)
									;; (agenda . 5)  need org loaded/inited first
									)
				  )
			(setq dashboard-banner-logo-title "Emacs Dashboard")
			(setq dashboard-startup-banner 'logo)
			)
		  )

		;; Value can be
		;; 'official which displays the official emacs logo
		;; 'logo which displays an alternative emacs logo
		;; 1, 2 or 3 which displays one of the text banners
		;; "path/to/your/image.png which displays whatever image you would prefer

		;; ;; example:
		;; ;;(defun dashboard-insert-custom (list-size)
		;; ;;  (insert "Custom text"))
		;; ;;(add-to-list 'dashboard-item-generators  '(custom . dashboard-insert-custom))
		;; ;;(add-to-list 'dashboard-items '(custom . 1))

		;; FORTUNE WIDGET
		;;  TODO: worklaptop's new D drive, moved dropbox there; need to make this code refer to c: dropbox
		;;  version of fortune-c.ps1 for machines with dropbox on c not d.
		;;  
		(defun dashboard-insert-fortune (list-size)
		  (insert
		   (format 
			"** FORTUNE **\n(use C-c f to edit fortunes)\n\n %s\n" 
			(replace-regexp-in-string 
			 "\n$" ""    ; remove trailing linebreak
			 (shell-command-to-string (concat "powershell -file " fortune-script-path)))
			))
		  )
		(add-to-list 'dashboard-item-generators  '(fortune . dashboard-insert-fortune))
		(add-to-list 'dashboard-items '(fortune . 1))


		;; TIP OF THE DAY WIDGET
		(defun dashboard-insert-totd (list-size)
		  (totd))
		(add-to-list 'dashboard-item-generators  '(totd . dashboard-insert-totd))
		(add-to-list 'dashboard-items '(totd . 1) t)


		) ;; progn
  ) ;; not work laptop


(if (not (string-match "US-L-7002395" (system-name)))
 ;;	(string-match "RobsLaptop" (system-name)) ;; )
	;; ehh - turning off dashboard on work laptop because mcafee slows it down so can't expect to add weather widget to it
 ;; turning it back on now that I've got daemon mode working pretty well

 ;; turning it back off now (5/29/18) as it's still slower than I'd like and I don't use the dashboard much
	(progn 
	  (message "adding weather widget to dashboard - for machines with speedy internet access")
	  ;; WEATHER WIDGET
	  ;; wttrin
	  ;; make sure to set calendar-location-name (or make new weather-location?) city name? airport? etc.
	  ;;  add weather-timeout option (5) or weather-command (curl) or weather-options (-s) 
	  (defun dashboard-insert-weather (list-size)
		(insert
		 (format
		  "** WEATHER **\n\n%s\n"
		  (shell-command-to-string "curl -s -m 5 wttr.in/CLE?1qT") ;; chcp 65001 $T curl.
    	  ;; (shell-command-to-string (concat "curl -s -m 5 wttr.in/" (concat calendar-location-name "?0qT")))
      ;; chcp 65001 $T curl...
		  ))
		)
	  (add-to-list 'dashboard-item-generators '(weather . dashboard-insert-weather))  
	  (add-to-list 'dashboard-items '(weather . 1))
	  )

  )

;; CALENDAR WIDGET? Display current month? Holidays in that month?
;; DIARY WIDGET?

