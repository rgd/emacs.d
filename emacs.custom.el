(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-delay 1.0)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(bm-cycle-all-buffers t)
 '(bm-highlight-style (quote bm-highlight-only-fringe))
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (adwaita)))
 '(custom-safe-themes
   (quote
	("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "726dd9a188747664fbbff1cd9ab3c29a3f690a7b861f6e6a1c64462b64b306de" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a71be4e5e9e418025daea651f8a1628953abb7af505da5e556e95061b6a6e389" default)))
 '(diredp-hide-details-initially-flag nil)
 '(display-time-day-and-date t)
 '(fci-rule-color "#eee8d5")
 '(flyspell-issue-message-flag nil)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
	(solarized-color-blend it "#fdf6e3" 0.25)
	(quote
	 ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
	(("#eee8d5" . 0)
	 ("#B4C342" . 20)
	 ("#69CABF" . 30)
	 ("#69B7F0" . 50)
	 ("#DEB542" . 60)
	 ("#F2804F" . 70)
	 ("#F771AC" . 85)
	 ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
	("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
	("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(image-dired-external-viewer "imdisplay.exe")
 '(inhibit-startup-screen t)
 '(ispell-program-name "hunspell")
 '(locate-command "c:/rgd/dropbox/cmd/locate.cmd")
 '(magit-diff-use-overlays nil)
 '(org-agenda-files (quote ("c:/rgd/dropbox/org")))
 '(org-cycle-separator-lines 1)
 '(org-link-frame-setup
   (quote
	((vm . vm-visit-folder-other-frame)
	 (vm-imap . vm-visit-imap-folder-other-frame)
	 (gnus . org-gnus-no-new-news)
	 (file . find-file)
	 (wl . wl-other-frame))))
 '(org-log-refile (quote time))
 '(org-mobile-directory "c:/rgd/dropbox/MobileOrg" t)
 '(org-mobile-files (quote (org-agenda-files "c:/rgd/dropbox/org")))
 '(org-mobile-inbox-for-pull "c:/rgd/dropbox/org/mobileorg.org")
 '(org-modules
   (quote
	(org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-mouse org-rmail org-w3m)))
 '(org-refile-allow-creating-parent-nodes (quote confirm))
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 6) (nil :level . 1))))
 '(org-refile-use-outline-path (quote file))
 '(org-return-follows-link t)
 '(org-trello-current-prefix-keybinding "C-c o")
 '(package-archives
   (quote
	(("gnu" . "http://elpa.gnu.org/packages/")
	 ("org" . "http://orgmode.org/elpa/")
	 ("melpa" . "http://stable.melpa.org/packages/"))))
 '(package-selected-packages (quote (org edit-server ggtags dired+ helm gtags)))
 '(paradox-github-token t)
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(tab-width 4)
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
	((20 . "#dc322f")
	 (40 . "#c85d17")
	 (60 . "#be730b")
	 (80 . "#b58900")
	 (100 . "#a58e00")
	 (120 . "#9d9100")
	 (140 . "#959300")
	 (160 . "#8d9600")
	 (180 . "#859900")
	 (200 . "#669b32")
	 (220 . "#579d4c")
	 (240 . "#489e65")
	 (260 . "#399f7e")
	 (280 . "#2aa198")
	 (300 . "#2898af")
	 (320 . "#2793ba")
	 (340 . "#268fc6")
	 (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
	(unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diredp-dir-priv ((t (:foreground "DarkRed"))))
 '(diredp-exec-priv ((t (:foreground "green"))))
 '(diredp-read-priv ((t (:foreground "red"))))
 '(diredp-write-priv ((t (:foreground "purple"))))
 '(helm-ff-dotted-directory ((t (:background "DimGray" :foreground "white"))))
 '(helm-ff-executable ((t (:foreground "red"))))
 '(helm-selection ((t (:background "dark gray" :distant-foreground "white"))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :height 0.8)))))
