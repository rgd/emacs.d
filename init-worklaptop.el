;;
;; init.el is LOCAL to PC - must copy to each local emacs init
;;
;; - it ONLY finds dropbox path and calls emacs.conf.el
;; - that's where all machine-specific config (and all global config is done!)
;;
;;
(setq debug-on-error t)

;; timestamps in *Messages*
;; via http://www.reddit.com/r/emacs/comments/1auqgm/speeding_up_your_emacs_startup/
(defun current-time-microseconds ()
  (let* ((nowtime (current-time))
         (now-ms (nth 2 nowtime)))
    (concat (format-time-string "[%Y-%m-%d %T" nowtime) (format ".%d] " now-ms))))

(defadvice message (before when-was-that activate)
    "Add timestamps to `message' output."
    (ad-set-arg 0 (concat (current-time-microseconds) 
                          (ad-get-arg 0)) ))

;; to disable:
;;    (ad-disable-advice 'message 'before 'when-was-that)
;;    (ad-update 'message)


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(message "<%s home>/.emacs.d/init.el - start" system-name)

;; *****************************************************************
;; MACHINE SPECIFIC SETUP
(cond
 ((string-match "HOMEPC" (system-name))
  (defvar dropbox-root-path "~/Dropbox")
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
(message (system-name))

;; *****************************************************************
;; LOAD CUSTOM FILE FOR MACHINE
;;
(defvar emacs-conf-path (concat dropbox-root-path "/.emacs.d/emacs.conf.el"))
(setq custom-file (concat dropbox-root-path "/.emacs.d/emacs.custom.el"))
(load custom-file)

;;; Custom theme path (was (add-to-list ...   ??? Use this?
;;; (add-to-list 'custom-theme-load-path (concat dropbox-root-path "/.emacs.d/lisp/themes"))
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

;; stop putting timestamps on messages - just want that for improving startup times.
;;
(ad-disable-advice 'message 'before 'when-was-that)
(ad-update 'message)

;; To use it, simply call M-x `paradox-list-packages' (instead of the
;; regular `list-packages').
;; This will give you most features out of the box. If you want to be
;; able to star packages as well, just configure the
;; `paradox-github-token' variable then call `paradox-list-packages'
;; again.

;; If you'd like to stop using Paradox, you may call `paradox-disable'
;; and go back to using the regular `list-packages'.

