;; org.conf.el
;;
;;  see org.conf.archive.el - for previous stuff and extra comments, hints, etc.

(message "Configuring for org-mode")
(use-package org
	:init
	  (setq org-directory (expand-file-name (concat dropbox-root-path "/org")))
;	:ensure
;		org-plus-contrib
	:bind
	  (("\C-cl" . org-store-link)
	   ("\C-cc" . org-capture)
	   ("\C-ca" . org-agenda)
	   ("\C-cb" . org-iswitchb))
	:config
	  (setq org-use-speed-commands t) ;; use when on headline, '?' to see list; customize 'org-speed-commands-user' to modify
	  (setq org-agenda-tags-column (- 4 (window-width))) ;; set tags to right side of window
	  (setq org-tags-column (- 4 (window-width)))        ;; use: C-u C-c C-q to realign tags (org-align-all-tags)
	  (setq org-agenda-include-diary t)
      (setq org-mobile-directory (concat dropbox-root-path "/Apps/MobileOrg"))  ;; dropbox/org/mobile ??
      (setq org-mobile-inbox-for-pull (concat dropbox-root-path "/org/mobileorg.org"))
      (setq org-goto-interface 'outline-path-completion) ;; For Ivy support in org-goto:
      (setq org-outline-path-complete-in-steps nil)
      (setq org-agenda-files (list
						  (expand-file-name (concat dropbox-root-path "/org/work/ABBAdmin.org"))
						  (expand-file-name (concat dropbox-root-path "/org/projects.org"))
						  (expand-file-name (concat dropbox-root-path "/org/rel.org"))
						  (expand-file-name (concat dropbox-root-path "/org/rgd.org"))
						  (expand-file-name (concat dropbox-root-path "/org/schedule.org"))
						  (expand-file-name (concat dropbox-root-path "/org/todo.org"))
						  (expand-file-name (concat dropbox-root-path "/org/work/ABBtodo.org"))
						  (expand-file-name (concat dropbox-root-path "/org/work/Composer.org"))
						  (expand-file-name (concat dropbox-root-path "/org/work/dev.org"))
						  (expand-file-name (concat dropbox-root-path "/org/work/HarmonyAPI.org"))
						  (expand-file-name (concat dropbox-root-path "/org/work/SPE.org"))
					   ))
      (setq org-capture-templates
       '(("t" "Todo" entry (file+headline (expand-file-name (concat dropbox-root-path "/org/todo.org")) "To Do")
	          "* TODO %?\n  %U\n  %i\n  %a\n" :empty-lines 1)
	     ("n" "Note" entry (file+headline (expand-file-name (concat dropbox-root-path "/org/todo.org")) "Notes")
	          "* Note: %?\n  %U\n  %i\n  %a\n\n\n\n" :empty-lines 1)
	     ("p" "Task" entry (file+headline (expand-file-name (concat dropbox-root-path "/org/projects.org")) "Tasks")
	          "* TODO %?\n  %U\n  %i\n  %a\n\n\n\n" :empty-lines 1)
	     ("g" "Get" entry (file+olp (expand-file-name (concat dropbox-root-path "/org/todo.org")) "To Do" "To Get")
	          "* TODO Get %i%?\n  %U\n   %a\n\n\n\n" :empty-lines 1)
	     ("j" "Journal" entry (file+datetree expand-file-name (concat dropbox-root-path "/org/journal.org"))
	          "* %?\nEntered on %U\n  %i\n  %a\n" :empty-lines 1)
	     ("r" "Relationship note" entry (file+datetree (expand-file-name (concat dropbox-root-path "/org/rel.org")))
	          "* %?\nEntered on %U\n  %i\n  %a\n" :empty-lines 1)
	     ("b" "Bug" entry (file+headline (expand-file-name (concat dropbox-root-path "/org/work/ABBTodo.org")) "Bugs")
	          "* TFS Bug %?\n Entered %U\n  %^g\n" :empty-lines 1)
	     ("a" "ABB Task" entry (file+headline (expand-file-name (concat dropbox-root-path "/org/work/ABBTodo.org")) "Tasks")
	          "** Task %?\n Entered %U\n  %^g\n" :empty-lines 1)
	     ("L" "Protocol Link" entry (file+headline ,(concat dropbox-root-path "/org/todo.org") "Inbox")
              "* %? [[%:link][%:description]] \nCaptured On: %U")
        )
	   )
      (setq org-tag-persistent-alist '(
				 ("ABB" .       ?A)
				 ("Cars" .      ?a)
				 ("call" .      ?c)
				 ("Craig" .     ?C)
				 ("Deb" .       ?D)
				 ("Emacs" .     ?e)
				 ("Finances" .  ?F)
				 ("Family" .    ?f)
				 ("get" .       ?g)
				 ("HAPI" .      ?H)
				 ("Home" .      ?h)
				 ("Insurance" . ?i)
				 ("Jamie" .     ?J)
				 ("lookup" .    ?l)
				 ("Mom" .       ?M)
				 ("Medical" .   ?m)
				 ("org" .       ?o)
				 ("Church" .    ?p) ;; pioneer
				 ("Rel" .       ?r)
				 ("Sean" .      ?S)
				 ("College" .   ?s) ;; school
				 ("Traveller" . ?T)
				 ("UNCC" .      ?U)
				 ("School" .    ?w)
				 ("Composer" .  ?y) ;; coyote
				 ("Computer" .  ?z)
				 ))
)
				 
(use-package org-mouse
;;   :if (display-graphic-p)      ;; not getting loaded in daemon startup - it's not a graphic display (yet)
   :after (org)
   )

(use-package org-protocol
   :after (org)
   :init
     (setq org-default-notes-file (concat org-directory "/notes.org")) 
   )

(use-package org-dropbox
   :after (org)
   :init
      (setq org-dropbox-note-dir               (concat dropbox-root-path "/notes/"))
      (setq org-dropbox-datetree-file          (concat dropbox-root-path "/org/reference.org"))
      (setq org-dropbox-refile-timer-interval  86400)
   :config
	  (org-dropbox-mode 1)
   )

(use-package org-bullets 
  ;;    :if (display-graphic-p)              ;; seemed a good idea, but I use daemon mode during load which isn't a graphic display
  :init
  (setq org-bullets-bullet-list
	  '("◉" "◎" "○" "►" "◇" "⚫"))
  :after (org)
  :config
  (setcdr org-bullets-bullet-map nil)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;;   (org-bullets-mode 1)
   )
