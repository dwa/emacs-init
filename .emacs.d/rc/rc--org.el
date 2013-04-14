;;; Time-stamp: <2013-04-14 12:11:39 dwa>


;;; Code:

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook 'turn-on-flyspell)

(add-to-list 'auto-mode-alist '("NOTES$" . org-mode))
(add-to-list 'auto-mode-alist '("TODO$" . org-mode))


;(setq org-agenda-directory "~/org/")

;; (defun my-rescan-agenda-files ()
;;   (interactive)
;;   (setq org-agenda-files
;; 	(directory-files (expand-file-name org-agenda-directory) t "^.*\\.org$")))

;; (my-rescan-agenda-files)

(eval-after-load "session"
'(add-to-list 'session-globals-exclude 'org-mark-ring))
(setq org-return-follows-link t)
(setq org-log-done t)
(setq org-agenda-include-diary t)

(setq org-agenda-window-setup 'current-window)

(add-hook 'org-agenda-mode-hook 'hl-line-mode)

;;
;;
(add-to-list 'load-path "~/.emacs.d/remember-el")
(autoload 'remember "remember" nil t)
;; (require 'remember)
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(eval-after-load "org"
  '(progn
     (add-to-list 'org-agenda-files "~/org/")
     (setq org-default-notes-file (concat org-directory "notes.org"))))

(define-key global-map "\C-cr" 'org-remember)


(setq org-capture-templates
      '(("w"
         "Default template"
         entry
         (file+headline "~/org/capture.org" "Notes")
         "* %^{Title}\n\n  Source: %u, %c\n\n  %i"
         :empty-lines 1)
        ;; ... more templates here ...
        ))


(setq org-remember-templates
      '((?w "* %c\n\n  Source: %u, %c\n\n  %i" nil "Firefox Notes")
	(?l "* Foo %?\n  %i\n  %a" "~/Plans/JOURNAL.org" "Life")
        (?a "* %?\n\n  %i\n  %a" "~/Plans/work.org" "Work")
        (?p "* %?\n\n  %i\n  %a" "~/Plans/phd.org" "PhD")
        (?i "* %^{Title}\n  %i\n  %a" "~/Plans/JOURNAL.org" "New Ideas")
	(?n "* %^{Title}\n\n" "~/Plans/notes.org" "Quick Notes")))


;; (add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))

(setq org-export-with-LaTeX-fragments t)

;; http://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.php

;(setq org-export-exclude-tags '())

;; use our own css to colorize code:
(setq org-export-htmlize-output-type 'css)


(require 'org-protocol)

(require 'ob)
(require 'ob-R)
;(org-babel-load-library-of-babel)

(eval-after-load "org-latex"
  '(add-to-list 'org-export-latex-classes
		'("letter" "\\documentclass[a4paper, 12pt]{letter}\n\\usepackage[utf8]{inputenc}\n\\usepackage[T1]{fontenc}\\usepackage{hyperref}\\hypersetup{colorlinks=true}\\sloppy\\nonfrenchspacing\\renewcommand{\\baselinestretch}{1.0}\n"
		  ("\\begin{letter}{%s}" "\\end{letter}")
		  ("\\section{%s}" . "\\section*{%s}")
		  ("\\subsection{%s}" . "\\subsection*{%s}")
		  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		  ("\\paragraph{%s}" . "\\paragraph*{%s}")
		  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
		  )))

(setq org-export-allow-BIND t)
(require 'org-export-as-s5)

;;; ----------------------------------------------------------------- [the end]
