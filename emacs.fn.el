

;;; *****************************************************************
;;;  Function definitions 

(defun rgd-server-shutdown ()
   "Save buffers, Quit and Shutdown (kill) server"
   (interactive)
    (if (daemonp)
     (progn 
	  (save-some-buffers t) ;; t == save all with no questions   (what about non-file buffers?)
	  (kill-emacs)
	 )
	 (message "Daemon not running - not shutting down.") ;; else case
	)
)

;; from kaushal modi: 
;  (if (daemonp)
;      (save-buffers-kill-emacs)
;    (save-buffers-kill-terminal)))
	
(defun rgd-emacs-shutdown ()
   "Save buffers, Quit and Shutdown (kill) server"
   (interactive)
     (progn 
	  (save-some-buffers)
	  (kill-emacs)
	 )
)

;; http://stackoverflow.com/a/20747279/1219634 ;; from kmodi
(defun rgd/read-file (f)
  "Return the contents of file F as a string."
  (with-temp-buffer
    (insert-file-contents f)
    (buffer-substring-no-properties (point-min) (point-max))))

;;; Tip of the Day  (source = ?)
;; (require 'cl)
 (defun tod ()
  (interactive)
  (with-output-to-temp-buffer "*Tip of the day*"
    (let* ((commands (cl-loop for s being the symbols
                           when (commandp s) collect s))
           (command (nth (random (length commands)) commands)))
      (princ
       (concat "Your tip for the day is:\n========================\n\n"
               (describe-function command)
               "\n\nInvoke with:\n\n"
               (with-temp-buffer
                 (where-is command t)
                 (buffer-string)))))))
;;(totd)

(defun totd()
  (let* ((commands (cl-loop for s being the symbols
								 when (commandp s) collect s))
		 (command (nth (random (length commands)) commands)))
	(insert 
			(format "** Tip of the day: ** \nCommand: %s\n\n%s\n\nInvoke with:\n\n"
         			(symbol-value 'command)
		        	(documentation command)
					)
		  )
    (where-is command t)
  )
)

;;; proxy setting functions
(defun set-proxy-nil ()
  (interactive)
  (message "Setting url-proxy-services to nil")
  (setq url-proxy-services nil)
)

(defun set-proxy-abb ()
  (interactive)
  (setq url-proxy-services '(("no_proxy" . "us\\.abb\\.com\\;tfs2\\.de\\.abb\\.com;\\*\\.de\\.abb:8080\\.com;110\\.130\\.\\*\\.\\*")
							 ;;                           ("http" . "proxy.us.abb.com:8080")
							 ;;							 ("https" . "proxy.us.abb.com:8080")
							 ("http" . "access401.cws.sco.cisco.com:8080")
							 ("https" . "access401.cws.sco.cisco.com:8080")
							 ))
  (message (concat "Setting url-proxy-services to " (prin1-to-string url-proxy-services)))
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


;; for use in abbadmin.org for entering time notes;
;; maybe use yasnippets??
;; calculate week ending date??
;;
(define-skeleton time-week-skeleton
  "Inserts a time entry week skeleton"
  "Week Number:"
  "****** W" str " - ending " \n
  "M - " \n
  "T - " \n
  "W - " \n
  "T - " \n
  "F - "
  )

(global-set-key "\C-c0" 'time-week-skeleton)

(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis. Else go to the
   opening parenthesis one level up."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1))
        (t
         (backward-char 1)
         (cond ((looking-at "\\s\)")
                (forward-char 1) (backward-list 1))
               (t
                (while (not (looking-at "\\s("))
                  (backward-char 1)
                  (cond ((looking-at "\\s\)")
                         (message "->> )")
                         (forward-char 1)
                         (backward-list 1)
                         (backward-char 1)))
                  ))))))

(global-set-key "\M-]" 'goto-match-paren)
(global-set-key "\M-[" 'goto-match-paren)
