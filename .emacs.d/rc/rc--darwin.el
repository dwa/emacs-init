;;; Time-stamp: <2015-08-08 01:29:25 davidwallin>
;;; Code:

(when (eq system-type 'darwin)
  ;;
  ;; untranslate some keypad keys:
  (mapc (lambda (x)
	  (define-key function-key-map (vector x) nil))
	'(kp-0 kp-1 kp-2 kp-3 kp-4 kp-5 kp-6 kp-7 kp-8 kp-9))

  ;;
  ;; Replace the xpdf as View command (with 'open') on the mac:
  (defun redefine-auctex-pdf-view-style ()
    ;; replace current pdf ...
    (setq TeX-output-view-style (remove-if (lambda (x)
					     (equal (car x) "^pdf$"))
					   TeX-output-view-style))
    ;; with 'open'
    ;;     (add-to-list 'TeX-output-view-style (list "^pdf$" "." "open %o"))
    ;;     (add-to-list 'TeX-output-view-style (list "^pdf$" "." "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b"))
    (add-to-list 'TeX-output-view-style (list "^pdf$" "." "/Applications/Skim.app/Contents/SharedSupport/displayline %(lln) %o %b")))

  ;;   (eval-after-load "tex"
  ;;     '(add-hook 'LaTeX-mode-hook 'redefine-auctex-pdf-view-style))
  (add-hook 'LaTeX-mode-hook 'redefine-auctex-pdf-view-style))

;;; ------------------------------------------------------------------ [the end]
