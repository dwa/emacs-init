;;; Time-stamp: <2015-07-31 01:42:52 davidwallin>


;;; Code:

;; org

(use-package org
  :commands (org-store-link org-agenda)

  :mode ("\\.org$" . org-mode)
  :mode ("TODO$" . org-mode)
  :mode ("NOTES$" . org-mode)

  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda))
  :init
  ;; (bind-key "\C-cl" 'org-store-link)
  ;; (bind-key "\C-ca" 'org-agenda)

  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'turn-on-font-lock)
  (add-hook 'org-mode-hook 'turn-on-flyspell)
  (setq org-return-follows-link t)
  (setq org-log-done t)
  (setq org-agenda-include-diary t)
  (setq org-agenda-window-setup 'current-window)
  (add-hook 'org-agenda-mode-hook 'hl-line-mode)

  :config
  (eval-after-load "session"
    '(add-to-list 'session-globals-exclude 'org-mark-ring))
  (add-to-list 'org-agenda-files "~/org/")
  (setq org-default-notes-file (concat org-directory "notes.org"))

  ;;
  ;;
;  (add-to-list 'load-path "~/.emacs.d/remember-el")
;  (autoload 'remember "remember" nil t)
;  ;; (require 'remember)
;  (setq remember-annotation-functions '(org-remember-annotation))
;  (setq remember-handler-functions '(org-remember-handler))
;  (add-hook 'remember-mode-hook 'org-remember-apply-template)


;  (setq org-capture-templates
;        '(("w"
;           "Default template"
;           entry
;           (file+headline "~/org/capture.org" "Notes")
;           "* %^{Title}\n\n  Source: %u, %c\n\n  %i"
;           :empty-lines 1)
;          ;; ... more templates here ...
;          ))

;  (setq org-remember-templates
;        '((?w "* %c\n\n  Source: %u, %c\n\n  %i" nil "Firefox Notes")
;          (?l "* Foo %?\n  %i\n  %a" "~/Plans/JOURNAL.org" "Life")
;          (?a "* %?\n\n  %i\n  %a" "~/Plans/work.org" "Work")
;          (?p "* %?\n\n  %i\n  %a" "~/Plans/phd.org" "PhD")
;          (?i "* %^{Title}\n  %i\n  %a" "~/Plans/JOURNAL.org" "New Ideas")
;          (?n "* %^{Title}\n\n" "~/Plans/notes.org" "Quick Notes")))

;  (setq org-export-with-LaTeX-fragments t)
;  (setq org-export-htmlize-output-type 'css)

;  (require 'org-protocol)

;  (require 'ob)
;  (require 'ob-R)

 ; (eval-after-load "org-latex"
 ;   '(add-to-list 'org-export-latex-classes
 ;                 '("letter" "\\documentclass[a4paper, 12pt]{letter}\n\\usepackage[utf8]{inputenc}\n\\usepackage[T1]{fontenc}\\usepackage{hyperref}\\hypersetup{colorlinks=true}\\sloppy\\nonfrenchspacing\\renewcommand{\\baselinestretch}{1.0}\n"
;                    ("\\begin{letter}{%s}" "\\end{letter}")
;                    ("\\section{%s}" . "\\section*{%s}")
;                    ("\\subsection{%s}" . "\\subsection*{%s}")
;                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;                    ("\\paragraph{%s}" . "\\paragraph*{%s}")
;                    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
;                    )))

;  (setq org-export-allow-BIND t)

  :ensure t)

(use-package ox-reveal
  :ensure t)


;;;(setq org-agenda-directory "~/org/")

;;;; (defun my-rescan-agenda-files ()
;;;;   (interactive)
;;;;   (setq org-agenda-files
;;;; 	(directory-files (expand-file-name org-agenda-directory) t "^.*\\.org$")))

;;;; (my-rescan-agenda-files)

;;(define-key global-map "\C-cr" 'org-remember)

;; (add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))

;; http://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.php

;(setq org-export-exclude-tags '())

;; use our own css to colorize code:

;;; ----------------------------------------------------------------- [the end]
