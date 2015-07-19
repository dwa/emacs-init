;;; Time-stamp: <2015-07-15 21:39:53 davidwallin>


;;; Code:

(when (eq system-type 'darwin)

  (setq mac-command-key-is-meta t)

  ;;
  ;; untranslate some keypad keys:
  (mapc (lambda (x)
	  (define-key function-key-map (vector x) nil))
	'(kp-0 kp-1 kp-2 kp-3 kp-4 kp-5 kp-6 kp-7 kp-8 kp-9))

;  (setenv "SSH_AUTH_SOCK" "/tmp/501/SSHKeychain.socket")

  (setenv "PATH" (concat (expand-file-name "~/bin")
                         ":/usr/local/bin:" (getenv "PATH")))
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
