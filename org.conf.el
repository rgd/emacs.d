;; org.conf.el

(message "Configuring for org-mode")
(require 'org-mouse)
(require 'org-protocol)
(setq org-directory (expand-file-name (concat dropbox-root-path "/org")))
(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-feed-file (concat org-directory "feeds.org"))

(setq org-feed-slashdot `("Slashdot" "http://rss.slashdot.org/Slashdot/slashdot" ,org-feed-file "Slashdot Entries"))

(setq org-feed-NPRTech `("NPRTech" "http://www.npr.org/rss/rss.php?id=1019" ,org-feed-file "NPR Tech Entries"))

(setq org-feed-alist
	  (list org-feed-slashdot org-feed-NPRTech))

;; so can use helm-org-in-buffer-headings when doing org-refile:
;;
(setq org-outline-path-complete-in-steps nil)
(setq org-completion-use-ido nil)

;; org-agenda-files currently customized. put them here instead?
;; (setq org-agenda-files '("~/local.org"))
;; (add-to-list 'org-agenda-files (expand-file-name (concat dropbox-root-path "/org")))

;; calendar ID: rob.davenport@gmail.com
;; bill pay: rssekfs00mvulrdg616f5g5bk0@group.calendar.google.com
;; birthdays: #contacts@group.v.calendar.google.com
;; davenport family: pi7cdia256f9kctrmecu9pgou8@group.calendar.google.com
;; mobile-org: r9250gi6a06evkdn9602da5ihs@group.calendar.google.com

;(require 'org-gcal)
;(setq org-gcal-client-id "698096590406-1tvliuj33f7aq59hm1odduihg9nd7dfp.apps.googleusercontent.com"
;      org-gcal-client-secret "bT7EC2-I1Q-4q7VNujCIGoYy"
;      org-gcal-file-alist '(("2kunsou3op826ovp668h0h2eec@group.calendar.google.com" . (expand-file-name (concat dropbox-root-path "/org/sc;hedule.org")) ))) ;; work ABB
;;;      org-gcal-file-alist '(
;;;                             ("2kunsou3op826ovp668h0h2eec@group.calendar.google.com" . "c:/rgd/dropbox/org/schedule.org" ) ;; work ABB;
;							;; ("rob.davenport@gmail.com" .  "c:/rgd/dropbox/org/schedule.org") ;; Rob
;                            ;; ("rssekfs00mvulrdg616f5g5bk0@group.calendar.google.com" . "c:/rgd/dropbox/org/schedule.org") ;; bill pay;
;	                        ;; ("r9250gi6a06evkdn9602da5ihs@group.calendar.google.com" . "c:/rgd/dropbox/org/schedule.org") ;; mobile org
;	                        ;; ("#contacts@group.v.calendar.google.com" . "c:/rgd/dropbox/org/schedule.org") ;; birthdays
;;;						   ))
;(require 'calfw-cal)
;(require 'calfw-ical)
;(require 'calfw-org)
;;;(setq cfw:ical-url-to-buffer-get 'cfw:ical-url-to-buffer-external) ;; may need this only when behind proxy - TODO make this conditional
;;;(setq cfw:ical-calendar-external-shell-command "wget --no-check-certificate -O - ")
;(defun my-open-calendar ()
;  (interactive)
;  (cfw:open-calendar-buffer
;   :contents-sources
;   (list
;;;	(cfw:org-create-source "Brown") ; orgmode source
;	(cfw:cal-create-source "Orange") ; diary source
;	(cfw:ical-create-source "gcalbill" "https://calendar.google.com/calendar/ical/rssekfs00mvulrdg616f5g5bk0%40group.calendar.google.com/private-3d1187760e072dcba5a364cf26987ed3/basic.ics" "IndianRed") ; google calendar ICS;
;	)))

;;	(cfw:ical-create-source "gcal" "https://calendar.google.com/calendar/ical/rob.davenport%40gmail.com/private-0ea182b3aba33fba88b657d13f962c4e/basic.ics" "DarkBlue") ; google calendar ICS

;; org-journal... You can add all those calendar files to your org-agenda
;; by adding org-journal-dir to org-agenda-files and setting org-agenda-file-regexp
;; to include files with an all-numeric name (\\`[^.].*\\.org'\\|[0-9]+).
;; That way, you can use org-agenda to search for TODO items or tagged items in your org-journal.


;; (global-set-key (kbd "C-c t") (lambda ()
;; 				(interactive)
;; 				(find-file (concat dropbox-root-path "/org/todo.org"))
;; 				))
;; (global-set-key (kbd "C-c e") (lambda ()
;; 				      (interactive)
;; 				      (find-file (concat dropbox-root-path "/.emacs.d/startorg.el"))
;; 				      ))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-tags-column (- 16 new-frame-width))

;;(setq org-directory (concat dropbox-root-path "/org"))
;; (setq org-mobile-inbox-for-pull (concat dropbox-root-path "/org/flagged.org")) ;; from-mobile.org (ipod?) mobileorg.org (android)
(setq org-mobile-directory (concat dropbox-root-path "/Apps/MobileOrg"))  ;; dropbox/org/mobile ??

(setq org-journal-dir (concat org-directory "/journal"))
	  
;; keys description type target template properties
;; type - entry (org node child of target org file)
;;      - item (plain list item)
;;      - checkitem (checkbox item)
;;      - table-line (new line in first table in target)
;;      - plain (text inserted as is)
;; target - (file "path/to/file")
;;        - (id "id of existing org entry")
;;        - (file+headline "path/to/file" "node headline")
;;        - (file+olp "path/to/file" "l1 heading" "l2 head" ...)
;;        - (file+regexp "path/to/file" "regxp to position point")
;;        - (file+datetree "path/to/file") - create heading for today's date
;;        - (file+datetree+prompt "path/to/file") - prompt for date
;;        - (file+function "path/to/file" function-finding-location)
;;        - (clock) - file to the entry currently being clocked
;;        - (function function-finding-location) - write your own function
;; template - %[file] %[sexp] %t %T %u %U (date/timestamps - active, inactive, date, date+time), %i initial content %a annotation
;;            %c kill ring head, %k title of currently clocked task, %K link to currently clocked task, %n username, %f file where capture called (%F full path)
;;            %^g prompt for tags, %^t prompt for date, .... and more!
;; properties - :[prepend :immediate-finish :empty-lines :clock-in :clock-keep :clock-resume :unnarrowed :table-line-pos :kill-buffer
;;
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (expand-file-name (concat dropbox-root-path "/org/todo.org")) "To Do")
	 "* TODO %?\n  %U\n  %i\n  %a\n" :empty-lines 1)
	("p" "Task" entry (file+headline (expand-file-name (concat dropbox-root-path "/org/projects.org")) "Tasks")
	 "* TODO %?\n  %U\n  %i\n  %a\n\n\n\n" :empty-lines 1)
	("g" "Get" entry (file+olp (expand-file-name (concat dropbox-root-path "/org/todo.org")) "To Do" "To Get")
	 "* TODO Get %i%?\n  %U\n   %a\n\n\n\n" :empty-lines 1)
	("j" "Journal" entry (file+datetree expand-file-name (concat dropbox-root-path "/org/journal.org"))
	 "* %?\nEntered on %U\n  %i\n  %a\n" :empty-lines 1)
	("r" "Relationship note" entry (file+datetree (expand-file-name (concat dropbox-root-path "/org/rel.org")))
	 "* %?\nEntered on %U\n  %i\n  %a\n" :empty-lines 1)
	("b" "Bug" entry (file+headline (expand-file-name (concat dropbox-root-path "/org/ABBTodo.org")) "Bugs") "* TFS Bug %?\n Entered %U\n  %^g\n" :empty-lines 1)
	("a" "ABB Task" entry (file+headline (expand-file-name (concat dropbox-root-path "/org/ABBTodo.org")) "Tasks") "** Task %?\n Entered %U\n  %^g\n" :empty-lines 1)
       )
)
;; "g" something to get/buy - what where
;; appointments, birthdays, events, anniversarys, contacts
;; ("c" "Contacts" entry (file+headline "/Users/HOME/.0.data/*TODO*" "CONTACTS")
;;   "\n\n** Delegated [#D] %?\n   :PROPERTIES:\n   :ToodledoID:\n   :ToodledoFolder: CONTACT\n   :Hash:\n   :END:"
;;    :empty-lines 1)

;; org-tag-alist - list of global tags
;; org-tag-persistent-alist - for all files
(setq org-tag-persistent-alist '(
				 ("get" .       ?g)
				 ("call" .      ?c)
				 ("email" .     ?e)
				 ("lookup" .    ?l)
				 ("Home" .      ?h)
				 ("School" .    ?w)
				 ("Family" .    ?f)
				 ("College" .   ?v)
				 ("Medical" .   ?m)
				 ("Cars" .      ?a)
				 ("Craig" .     ?k)
				 ("UNCC" .      ?u)
				 ("Sean" .      ?s)
				 ("Deb" .       ?d)
				 ("Mom" .       ?o)
				 ("Jamie" .     ?j)
				 ("Finances" .  ?n)
				 ("Insurance" . ?i)
				 ("Church" .    ?p)
				 ("Rel" .       ?r)
				 ("Emacs" .     ?e)
				 ("Computer" .  ?z)
				 ("ABB" .       ?b)
				 ("Composer" .  ?y)
				 ("HAPI" .      ?q)
				 ))
;; #+TAGS: ORG Phone Android ipod PC Don Jan



