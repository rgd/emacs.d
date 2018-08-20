
;;; KEYBOARD CHANGES
;;;

(message "Configuring keyboard mappings.")
(define-key global-map (kbd "RET") 'newline-and-indent) ;; auto indent when hit enter
(global-set-key (kbd "C-c i") 'indent-region)
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c f") (lambda () (interactive) (find-file "d:\\rgd\\dropbox\\sys\\fortune-powershell\\fortune.txt")))
;(global-set-key "\M-]" 'forward-list) ;; move to matching parentheses
;(global-set-key "\M-[" 'backward-list) ; http://www.uhoreg.ca/programming/emacs - 2-Oct-08
;; now trying goto-match-paren in emacs.fn.el
(global-set-key [f5] 'call-last-kbd-macro)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)
(global-set-key (kbd "<M-f2>") 'bm-show-all);;  to show all bookmarks
(global-set-key (kbd "M-,") 'tags-loop-continue)

;; https://sites.google.com/site/steveyegge2/effective-emacs: 
;; (global-set-key "\C-w" 'backward-kill-word) -- good idea but my fingers are too programmed to C-w being 'kill-region'
;; (global-set-key "\C-x\C-k" 'kill-region)
;; (global-set-key "\C-c\C-k" 'kill-region)

;; from help-emacs-w 6/17:
(setq w32-pass-lwindow-to-system nil
      w32-pass-rwindow-to-system nil
      w32-pass-apps-to-system    nil
      w32-lwindow-modifier       'super   ;; Left Windows
      w32-rwindow-modifier       'super   ;; Right Windows
      w32-apps-modifier          'hyper)  ;; App-Menu (key to right of Right Windows)
;; (global-set-key [(super \,)] (lambda () (interactive) (insert  ?« )))
;; (global-set-key [(super \.)] (lambda () (interactive) (insert  ?» )))
;; (global-set-key [(super \')] (lambda () (interactive) (insert  ?“ )))
;; (global-set-key [(super  \")] (lambda () (interactive) (insert  ?” )))


(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
    (define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

(global-set-key (kbd "C-c n") 'create-scratch-buffer)

(global-set-key (kbd "C-c e") (lambda ()
				 (interactive)
				 (find-file (concat dropbox-root-path "/.emacs.d/emacs.custom.el"))
				 (find-file (concat dropbox-root-path "/.emacs.d/emacs.opt.el"))
				 (find-file (concat dropbox-root-path "/.emacs.d/emacs.ui.el"))
				 (find-file (concat dropbox-root-path "/.emacs.d/emacs.ui-frame.el"))
				 (find-file (concat dropbox-root-path "/.emacs.d/emacs.fn.el"))
				 (find-file (concat dropbox-root-path "/.emacs.d/emacs.key.el"))
				 (find-file (concat dropbox-root-path "/.emacs.d/emacs.pkg.el"))
				 (find-file (concat dropbox-root-path "/.emacs.d/emacs.spec.el"))
				 (find-file (concat dropbox-root-path "/.emacs.d/org.conf.el"))
				 (find-file (concat dropbox-root-path "/.emacs.d/emacs.conf.el"))
				 (find-file "~/.emacs.d/init.el") ;;; /.emacs.d/init.el"))
				 ))

(global-set-key (kbd "C-c t")
				(lambda ()
				  (interactive)
				  (progn
					(if (daemonp)
						(progn
						  (message "daemon started; assuming org-conf-el loaded; opening todo.org")
					      (find-file (concat dropbox-root-path "/org/todo.org"))
					    )
					    (progn
						  (message "no daemon started; loading %s for org-mode configuration if needed" org-conf-el)
						  (if (file-exists-p org-conf-el)
							(progn
							  (message "loading org-mode configuration file %s"
									   (expand-file-name (concat dropbox-root-path "/.emacs.d/org.conf.el")))
							  (load-file org-conf-el)
							)
							(progn
							  (message "no org-conf-el found; no loading")
							)
						  )
						  (find-file (concat dropbox-root-path "/org/todo.org"))
					    )
					)
				  )
			  )
)
(message "Configuring keyboard mappings - done.")


