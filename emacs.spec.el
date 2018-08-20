
;; MACHINE SPECIFIC SETUP

;; TODO - now that dropbox path is on d drive on work laptop - thanks to new SSD drive - several settings here
;;  (mostly for org) are not always "c:/rgd/dropbox/..." and some things are customized and stuck with hardcoded
;;  c: in emacs.custom.el - these should be removed from there and set on startup here per machine
;;
;;  fortune-dir
;;  locate-command
;;  org-agenda-files
;;  org-mobile-directory
;;  org-mobile-files
;;  org-mobile-inbox-for-pull

;; for now these will work on work laptop but not home or most other machines :(

;; and in dropbox/sys/fortune/fortune.ps1 has hard-coded c drive path

;; Location settings
(cond
 ( (or (string-match "HOMEPC" (system-name))
       (string-match "ROBSLAPTOP" (system-name)))

   ;;   (home stuff)
  (message "Setting location for home computer")
  (setq calendar-latitude 41.35)  ;; put in site-start.el (?)
  (setq calendar-longitude -81.44)
  (setq calendar-location-name "Twinsburg")
  (setq calendar-location-airport "CLE")
  (setq calendar-time-zone -300) ;; GMT -5 5*60 = 300; 4*60=240
  (setq calendar-standard-time-zone-name "EST")
  (setq calendar-daylight-time-zone-name "EDT")  
  (setq calendar-daylight-time-offset 60)
  (setq sunshine-location "Twinsburg, Ohio")
 )
 ( (or (string-match "ComposerDevD20" (system-name))
       (string-match "USWIC-L-0074462" (system-name))
	   (string-match "US-L-7002395" (system-name))
	   (string-match "c64devrob" (system-name))
	   (string-match "w10devrob" (system-name))
	   (string-match "w10devrob2" (system-name))
	   (string-match "HAPIDev10" (system-name))
	   (string-match "hapibuild10" (system-name))
	   (string-match "LV426" (system-name))
	   (string-match "hapibuild1" (system-name)))

  ;;   (work stuff)
  (message "Setting location for work computer")
  (setq calendar-latitude 41.4505)  ;; put in site-start.el (?)
  (setq calendar-longitude -81.5185)
  (setq calendar-location-name "Highland Hills")
  (setq calendar-location-airport "CAK")
  (setq calendar-time-zone -300) ;; GMT -5 5*60 = 300; 4*60=240
  (setq calendar-standard-time-zone-name "EST")
  (setq calendar-daylight-time-zone-name "EDT")  
  (setq calendar-daylight-time-offset 60)
  (setq sunshine-location "Cleveland, Ohio")
 )
)

;; Calendar settings - in the U.S.
;;  (setq calendar-daylight-savings-starts (calendar-nth-named-day 2 0 3 year))
;;  (setq calendar-daylight-savings-ends (calendar-nth-named-day 1 0 11 year))

(cond
 ((string-match "HOMEPC" (system-name))
  (defvar local-site-lisp-path "/usr/local/share/emacs/site-lisp")
  ;; (setq printer-name "CN2462H16F05RQ:") ;;; how to print at home? can't share network printer.
  ;; color theme?
  (defvar fortune-script-path "c:\\rgd\\dropbox\\sys\\fortune\\fortune-c.ps1")
  )
 ((string-match "ROBSLAPTOP" (system-name))
  (defvar local-site-lisp-path "c:/rgd/dropbox/.emacs.d/lisp")
  (defvar local-find-exe "c:/rgd/dropbox/wbin/find.exe") ;; ??
  (defvar fortune-script-path "c:\\rgd\\dropbox\\sys\\fortune\\fortune-c.ps1")
  (set-proxy-nil)
  ;; PRINTING AT HOME
  (require 'printing)
  (pr-update-menus t)
  
  (setq printer-name "\\\\ROBSLAPTOP\\HP6700") ;;; how to print at home? can't share network printer.
  ;; or using lerup's PrintFile32
 ;; (setq printer-name nil) 
  (setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
  (setq lpr-switches '("/q")) 
  (setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
  (setq ps-lpr-switches '("/q")) 
  ;; color theme?
  )
 ((string-match "composerD20" (system-name)) ;; Lenovo ThinkStation D20 Ubuntu box
  (defvar local-site-lisp-path "/usr/local/share/emacs/site-lisp")
  (defvar local-find-exe "/usr/bin/find")
  (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
  ;; color theme?
  (set-proxy-abb)
  )
 ((string-match "LV426" (system-name)) ;; Lenovo ThinkStation D20 Ubuntu box
  (defvar local-site-lisp-path "/usr/local/share/emacs/site-lisp")
  (defvar local-find-exe "/usr/bin/find")
  (defvar fortune-script-path "~/Dropbox/sys/fortune/fortune.ps1")
  ;;(setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
  ;; color theme?
  (set-proxy-abb)
  )
 ((string-match "US-L-7002395" (system-name))

  (defvar local-site-lisp-path "d:/rgd/dropbox/.emacs.d/lisp")
  (defvar local-find-exe "d:/rgd/dropbox/wbin/find.exe") ;; ??
  (defvar fortune-script-path "d:\\rgd\\dropbox\\sys\\fortune\\fortune.ps1")

  (set-proxy-abb)

  ;; PRINTING AT WORK - various options
  ;;
;;  (require 'printing)
;;  (pr-update-menus t) ;; the menus seem more for ps printing, not lpr printing - couldn't find item that would do (print-buffer)
  ;; doing M-x print-buffer workes with option (3) set for PrFile32.
  ;;
  ;; TODO: how to configure the printing settings for prfile32?
  ;;       by default it's finding the default printer (currently PDF-XChange6 and blapping 'permission denied')
  ;;       maybe set default printer back to the "US-P-CLEPX1032-" - that will probably work nicely but then have no control - it'll print right then.
  ;;       or figure out how to fix option 5
  ;;
  ;;
  ;; TODO - CONFIGURE PRINTING OPTIONS - printer alist CLEPX1032-, PDFPrinter, PDFEdit, PrFile32, etc... some for PS, other LPR

  ;; BE CAREFUL of having pr.exe and lpr.exe clones on your machine, if Emacs finds them it uses them and changes
  ;; its printing behavior (possibly preventing Windows-specific behavior)
  
;;  (setq lpr-headers-switches nil) ;; <-- !! or else get "page headers are not supported"

  ;; ;; (1) print to network printer
  ;;  (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
  ;;(setq printer-name "US-P-CLEPX1032-") ;; X_10.127.230.32    ;; no longer possible after Wickliffe, not existing in Highland Hills
  ;;
  ;; ;; (2) print using network printer connected to local LPT3: port
  ;;  (setq printer-name "LPT3:")
  ;; net use lpt3: \\127.0.0.1\US-P-CLEPX1032-
  ;; shared printer on work laptop (but not PS)
  ;; 
  ;; ;; (3) using lerup's PrintFile32
;;  (setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
;;  (setq lpr-switches '("/q")) 
  ;; (setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
  ;; (setq ps-lpr-switches '("/q")) 
  ;;

;;  (setq printer-name "\\\\US-L-7002395\\PDFPrinter") ;; see a document in that printer queue flicker past but no output.
  
  ;; ;; (4) using a local shared printer (PDFPrinter) the share for PDF-XChange... printer (BCE load)
  ;;(setq printer-name "\\\\us-l-7002395\\PDF-XChange Standard V6") - nope
  ;;(setq ps-printer-name "\\\\us-l-7002395\\PDF-XChange Standard V6") - loser 
  ;;(setq printer-name "\\\\PDF-XChange6") - bad
  ;;(setq ps-printer-name "\\\\PDF-XChange6") - didn't work either
  
  ;; (5) using PDF XChange's "PDF Editor"
  (setq printer-name nil)
  (setq lpr-headers-switches nil) ;; <-- !! or else get "page headers are not supported"
  (setq lpr-command "c:\\program files\\tracker software\\PDF Editor\\PDFXEdit.exe")

  ;; ^--- !! "works" - converts text to PDF but proportional font so it's messed up. :( 
  
    ;;(setq lpr-switches '("/A")) ;; needed?
  ;;(setq ps-lpr-command "c:\\program files\\tracker software\\PDF Editor\\PDFXEdit.exe") ;; but this did not, showed the PS source...
  ;;(setq ps-lpr-switches '("/A")) ;; needed?

;; CHECK FOR lpr-headers-switches - that's where (page headers are not supported) is coming from - set to nil?!
  ;; if that works could use prfile32 or PDFEdit - at least for non-PS printing
  ;; PS printing... eh, probably need the network/share printing to work to connect to real PS printer since emacs is sending PS code
  ;; printing, per Emacs manual, G.9 Printing and MS-Windows
;;  (setq lpr-command "")
;;  (setq printer-name "LPT1") 
  ;; nope - keeps going into debugger complaining about "C:/LPT1"; even after nuking all pr.exe/lpr.exe clones on here (gnuwin32,
  ;; usr/local/wbin, Git,...)

  ;; color theme
  )
 ((string-match "C64DEVROB" (system-name))
	(defvar local-site-lisp-path "C:/rgd/dropbox/.emacs.d/lisp")
	(defvar local-find-exe "c:/rgd/dropbox/wbin/find.exe")
        (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
	(set-proxy-abb)

	;; using lerup's PrintFile32
	(setq printer-name nil) 
	(setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq lpr-switches '("/q")) 
	(setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq ps-lpr-switches '("/q")) 


	)
 ((string-match "W10DEVROB2" (system-name))
	(defvar local-site-lisp-path "C:/rgd/dropbox/.emacs.d/lisp")
	(defvar local-find-exe "c:/rgd/dropbox/wbin/find.exe")
        (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
    (set-proxy-abb)
    (defvar fortune-script-path "c:\\rgd\\dropbox\\sys\\fortune\\fortune-c.ps1")

	;; using lerup's PrintFile32
	(setq printer-name nil) 
	(setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq lpr-switches '("/q")) 
	(setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq ps-lpr-switches '("/q")) 

	)
 ((string-match "W10DEVROB" (system-name))
	(defvar local-site-lisp-path "C:/rgd/dropbox/.emacs.d/lisp")
	(defvar local-find-exe "c:/rgd/dropbox/wbin/find.exe")
        (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
    (set-proxy-abb)
    (defvar fortune-script-path "c:\\rgd\\dropbox\\sys\\fortune\\fortune-c.ps1")

	;; using lerup's PrintFile32
	(setq printer-name nil) 
	(setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq lpr-switches '("/q")) 
	(setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq ps-lpr-switches '("/q")) 

	)
 ((string-match "HAPIDev10" (system-name))
	(defvar local-site-lisp-path "C:/rgd/dropbox/.emacs.d/lisp")
	(defvar local-find-exe "c:/rgd/dropbox/wbin/find.exe")
        (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
    (set-proxy-abb)
    (defvar fortune-script-path "c:\\rgd\\dropbox\\sys\\fortune\\fortune-c.ps1")

	;; using lerup's PrintFile32
	(setq printer-name nil) 
	(setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq lpr-switches '("/q")) 
	(setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq ps-lpr-switches '("/q")) 

	) ((string-match "HAPIBUILD10" (system-name))
	(defvar local-site-lisp-path "C:/rgd/dropbox/.emacs.d/lisp")
	(defvar local-find-exe "c:/rgd/dropbox/wbin/find.exe")
        (setq printer-name "//uswic-s-file001/USCLEPX005-M_PS")
    (set-proxy-abb)

    (defvar fortune-script-path "c:\\rgd\\dropbox\\sys\\fortune\\fortune.ps1")
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
    (set-proxy-abb)

	;; using lerup's PrintFile32
	(setq printer-name nil) 
	(setq lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq lpr-switches '("/q")) 
	(setq ps-lpr-command "C:/Program Files (x86)/PrintFile/prfile32.exe") 
	(setq ps-lpr-switches '("/q")) 
	
	)
 )
;; log results of machine specific setup
(message "System: %s" (system-name))
(message "dropbox-root-path = %s" dropbox-root-path)
(message "local-site-lisp-path = %s" local-site-lisp-path)
(message "local-find-exe = %s" local-find-exe)
(message "emacs-conf-path = %s" emacs-conf-path)
(message "custom file = %s" custom-file)
(message "themes path = %s" custom-theme-load-path)
(message "printer = %s" printer-name)

;; Add machine-specific paths to other elisp to the load-path
;;
(add-to-list 'load-path local-site-lisp-path)


