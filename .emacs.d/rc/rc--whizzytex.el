;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

;; WhizzyTeX

;; (setq load-path (cons "/Users/david/Desktop/wtex/whizzytex-xxx/src" load-path))
;; (require 'whizzytex)

;; (setq-default whizzy-viewers '(("-pdf" "/Applications/Skim.app/
;; Contents/MacOS/Skim")))


(when (eq system-type 'gnu/linux)
  (add-to-list 'load-path (expand-file-name "/usr/local/share/whizzytex/emacs"))

  (autoload 'whizzytex-mode "whizzytex"
    "WhizzyTeX, a minor-mode WYSIWYG environment for LaTeX" t)

  ;;  (setq-default whizzy-viewers '(("-pdf" "xpdf") ("-advi" "advi -html Start-Document")))

  (add-hook 'whizzytex-mode-hook '(lambda ()
				   ;; use paragraph mode for the LaTeX class "beamer":
				   (add-to-list 'whizzy-class-mode-alist '("beamer" . paragraph))
				   (whizzy-default-bindings) ;keep default whizzytex-mode-hook
				   ))
  ;;slice on every frame while in paragraph mode:
  ;;  (setq whizzy-paragraph-regexp "\n\\\\frame\\b[^{]*{")
  ;;or slice also on sectioning:
  (setq whizzy-paragraph-regexp "\\\\\\(\\(s\\(ubs\\(ub\\|\\)\\|\\)ection\\)\\|chapter\\|part\\|frame\\)\\b[^{]*{")
  )

;;; ----------------------------------------------------------------- [the end]
