;;; Time-stamp: <2015-08-02 01:49:25 davidwallin>

;;; Code:

(defun ll-count-lines (start end)
  "Return number of lines between START and END.
This is usually the number of newlines between them,
but can be one more if START is not equal to END
and the greater of them is not at the start of a line."
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (save-match-data
	(let ((done 0))
	  (while (search-forward "\n" nil t)
	    (when (get-text-property (match-beginning 0) 'hard)
	      (incf done)))
	  (goto-char (point-max))
	  (if (and (/= start end)
		   (not (bolp)))
;; 	      done
;; 	    (- done 1)
	      (1+ done)
	    done

)))
      )))


(defun ll-line-number-at-pos (&optional pos)
  "Return (narrowed) buffer line number at position POS.
If POS is nil, use current buffer location.
Counting starts at (point-min), so the value refers
to the contents of the accessible portion of the buffer."
  (let ((opoint (or pos (point))) start)
    (save-excursion
      (goto-char (point-min))
      (setq start (point))
      (goto-char opoint)
      (forward-line 0)
      (1+ (ll-count-lines start (point))))))

;(defalias 'TeX-line-number-at-pos 'll-line-number-at-pos)


;;; ---------------------------------------------------------------------- [TeX]

(set-default 'TeX-PDF-mode t)

(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.

;;
;; reftex
(add-hook 'LaTeX-mode-hook 'reftex-mode)
(setq reftex-plug-into-AUCTeX t)

;; http://thread.gmane.org/gmane.emacs.auctex.general/718
;; (add-hook 'LaTeX-mode-hook
;; 	  (lambda ()
;; 	    (when (member "beamer" TeX-active-styles)
;; 	      (set (make-local-variable 'reftex-section-levels)
;; 		   '(("lecture" . 1) ("frametitle" . 2))))
;; 	    ;;				   (reftex-reset-mode)
;; 	     ))
(setq reftex-section-levels
      '(("part" . 0) ("chapter" . 1) ("section" . 2) ("subsection" . 3)
        ("frametitle" . 4) ("subsubsection" . 4) ("paragraph" . 5)
        ("subparagraph" . 6) ("addchap" . -1) ("addsec" . -2)))

(eval-after-load 'tex '(add-to-list 'TeX-command-list
				    (list "PDF"
					  "%(o?)dvipdf %d "
					  'TeX-run-command t t
				     :help "Generate PDF file from dvi.")))

(eval-after-load "tex"
'(add-to-list 'TeX-expand-list
	     (list "%(lln)" (lambda ()
			      (format "%d" (1+ (ll-line-number-at-pos)))))))


(defun reftex-occur-document (regexp &optional nlines)
  "Run an occur query through all files related to this document.
With prefix arg, force to rescan document.
No active TAGS table is required."
  (interactive (occur-read-primary-args))
  (reftex-access-scan-info current-prefix-arg)
  (let* ((buffers (loop for i in (reftex-all-document-files t)
			collect (find-file-noselect i))))
    (multi-occur buffers regexp nlines)))

;; TODO: ensure auctex
;; add to cdlatex:
;; q1 : \( \)
;; q2 : \[ \]
(use-package cdlatex
  :commands (turn-on-cdlatex cdlatex-mode)
  :init
  (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
  :config
  (add-to-list 'cdlatex-command-alist
               '("cp" "add \\citep{}" "\\citep{?}"cdlatex-position-cursor nil t nil))
  (add-to-list 'cdlatex-command-alist
               '("q1" "add math environment \\( \\)" "\\(?\\)"
                 cdlatex-position-cursor nil t nil))
  (add-to-list 'cdlatex-command-alist
               '("q2" "add math environment \\[ \\]" "\\[?\\]"
                 cdlatex-position-cursor nil t nil))
  (cdlatex-compute-tables)
  :ensure t)

;;
;; use cref instead:
(defun reftex-cleveref-cref ()
  "Insert a reference using the `\\cref' macro from the cleveref package."
  (interactive)
  (let ((reftex-format-ref-function 'reftex-format-cref)
        ;;(reftex-guess-label-type nil) ;FIXME do we want this????
        )
    (reftex-reference)))

(defun reftex-cleveref-Cref ()
  "Insert a reference using the `\\Cref' macro from the cleveref package."
  (interactive)
  (let ((reftex-format-ref-function 'reftex-format-Cref)
        ;;(reftex-guess-label-type nil) ;FIXME do we want this????
        )
    (reftex-reference)))

(defun reftex-format-Cref (label def-fmt)
  (format "\\Cref{%s}" label))
(defun reftex-format-cref (label def-fmt)
  (format "\\cref{%s}" label))

(defun reftex-cref-keybindings ()
  (local-set-key (kbd "C-c f") 'reftex-cleveref-cref)
  (local-set-key (kbd "C-c F") 'reftex-cleveref-Cref))

(add-hook 'reftex-mode-hook 'reftex-cref-keybindings)




;;
;; Replace the xpdf as View command (with 'open') on the mac:
(defun redefine-auctex-pdf-view-style ()
  ;; replace current pdf ...
  (setq TeX-output-view-style (remove-if (lambda (x)
					   (equal (car x) "^pdf$"))
					 TeX-output-view-style))
  ;; (add-to-list 'TeX-output-view-style (list "^pdf$" "." "evince --page-label=%(outpage) %o"))
  ;; (add-to-list 'TeX-output-view-style (list "^pdf$" "." "evince %o"))
  (add-to-list 'TeX-output-view-style (list "^pdf$" "." "mupdf -r 94 %o")))

;;   (eval-after-load "tex"
;;     '(add-hook 'LaTeX-mode-hook 'redefine-auctex-pdf-view-style))

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'redefine-auctex-pdf-view-style)

(add-to-list 'auto-mode-alist '("\\.tikz$" . latex-mode))

(autoload 'ebib "ebib" "Ebib, a BibTeX database manager." t)

;; (add-hook 'LaTeX-mode-hook #'(lambda ()
;;                                (local-set-key "\C-cb" 'ebib-insert-bibtex-key)))

;;; ----------------------------------------------------------------- [the end]
