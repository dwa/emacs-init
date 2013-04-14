;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("\\<\\(FIXME\\):"
				       1 font-lock-warning-face)))))

;; (font-lock-add-keywords 'LaTeX-mode
;; 			'(("\\(\\(\\if\\)\\(\\s_\\|\\w\\)*\\)"
;; 			   1 font-lock-keyword-face)))

;; (font-lock-add-keywords 'LaTeX-mode
;; 			'(("\\(\\State\\)"
;; 			   1 font-latex-sedate-face)))

;; (font-lock-add-keywords 'PDFLaTeX-mode
;; 			'(("\\(\\State\\)"
;; 			   1 font-latex-sedate-face)))
