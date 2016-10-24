;;
;; init.el is LOCAL to PC - must copy to each local emacs init
;;
;; - it ONLY finds dropbox path and calls emacs.conf.el
;; - that's where all machine-specific config (and all global config is done!)
;;
;;
(message "Processing <%s home>/.emacs.d/init.el" system-name)

(setq debug-on-error t)

;; *****************************************************************
;; MACHINE SPECIFIC SETUP
(cond
 ((string-match "HOMEPC" (system-name))
  (defvar dropbox-root-path "~/Dropbox")
  )
 ((string-match "ROBSLAPTOP" (system-name))
  (defvar dropbox-root-path "c:/rgd/Dropbox")
  )
 ((string-match "ComposerDevD20" (system-name)) ;; Lenovo ThinkStation D20 Ubuntu box
  (defvar dropbox-root-path "~/Dropbox")
  )
 ((string-match "USWIC-L-0074462" (system-name))
  (defvar dropbox-root-path "c:/rgd/dropbox")
  )
 ((string-match "US-L-7002395" (system-name))
  (defvar dropbox-root-path "c:/rgd/dropbox")
  )
 ((string-match "C64DEVROB" (system-name))
	(defvar dropbox-root-path "c:/rgd/dropbox")
  )
)

;; *****************************************************************
;; LOAD CUSTOM FILE
;;
(defvar emacs-conf-path (concat dropbox-root-path "/.emacs.d/emacs.conf.el"))
(setq custom-file (concat dropbox-root-path "/.emacs.d/emacs.custom.el"))
(message "Loading %s custom file" custom-file)
(load custom-file)
(message "Done loading %s custom file" custom-file)

;;; Custom theme path (was (add-to-list ...   ??? Use this?
;;; (add-to-list 'custom-theme-load-path (concat dropbox-root-path "/.emacs.d/liap/themes"))
;;(add-to-list 'custom-theme-load-path "c:/rgd/dropbox/.emacs.d/lisp/themes")

;; *****************************************************************
;; GLOBAL CUSTOMIZATION - <Dropbox>/.emacs.d/emacs.conf.el
;;

;; load global customization file emacs.conf.el from dropbox
(if (file-exists-p emacs-conf-path)
    (progn
     (message "loading Emacs configuration file %s" emacs-conf-path)
     (load-file emacs-conf-path)))

(message "<%s home>/.emacs.d/init.el - done loading %s" system-name emacs-conf-path)

(message "<%s home>/.emacs.d/init.el - done" system-name)

