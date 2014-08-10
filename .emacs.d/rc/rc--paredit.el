;;; Time-stamp: <2014-08-09 23:32:07 dwa>


;;; Code:

;;; ------------------------------------------------------------------ [paredit]

(unless (featurep 'paredit)
  (autoload 'paredit-mode "paredit"
    "Minor mode for pseudo-structurally editing Lisp code." t))

(eval-after-load "paredit"
  '(progn (define-key paredit-mode-map (kbd "M-\(") nil)
;	  (define-key paredit-mode-map (kbd "M-\[") 'paredit-wrap-sexp)
          (define-key paredit-mode-map (kbd "M-[") nil)
	  (define-key paredit-mode-map (kbd "M-\)") nil)
	  (define-key paredit-mode-map (kbd "M-\]") 'paredit-close-parenthesis)))
