;;; Time-stamp: <2014-08-10 20:24:03 dwa>


(require 'ess-eldoc)

(eval-after-load "ess"
;;   '(setq-default ess-language "R")
  '(setq-default ess-local-process-name "R"))

(setq ess-ask-for-ess-directory nil)

(add-hook 'ess-mode-hook
	  (lambda ()
	    (yas/minor-mode-on)))

;;
;; inferior ESS
(add-hook 'inferior-ess-mode-hook
	  (lambda ()
            (setq ess-history-directory "~/.R/")))

(add-hook 'inferior-ess-mode-hook 'ess-use-eldoc)
;; (add-hook 'ess-mode-hook 'ess-use-eldoc)

;; from ess-help:
;; http://permalink.gmane.org/gmane.emacs.ess.general/3723
(add-hook 'ess-help-mode-hook
	  (lambda ()
	    (set (make-local-variable 'font-lock-defaults)
		 '(ess-R-mode-font-lock-keywords t))))

(add-to-list 'special-display-regexps '("\\*help\\[R\\].*\\*$" (same-frame . t)))


;;; ---

(let ((fl (lambda ()
            (font-lock-add-keywords nil '(("\\(%[^[:space:]%]+%\\)" .
                                           font-lock-keyword-face))))))
  (add-hook 'inferior-ess-mode-hook fl)
  (add-hook 'ess-mode-hook fl))


(require 'pretty-symbols)
(defun peRtty-R ()
  (interactive)
  (substitute-patterns-with-unicode
   (list (cons "\\(<<-\\)" 'left-double-arrow)
         (cons "\\(->>\\)" 'right-double-arrow)
         (cons "[^<]\\(<-\\)" 'left-arrow)
         (cons "\\(->\\)[^>]" 'right-arrow)
         (cons "\\(\\.\\.\\.\\)" 'horizontal-ellipsis)

         (cons "\\(function\\)[[:blank:]]*(" 'lambda)
         ;; (cons "\\(\\$\\)" 'superset-of)

         (cons "\\(>\\)\\[^=\\]" 'greater-than)
         (cons "\\(<\\)\\[^=\\]" 'less-than)

         (cons "\\(>=\\)" 'greater-than-or-equal-to)
         (cons "\\(<=\\)" 'less-than-or-equal-to)

         (cons "\\(?:^\\|[^=]\\)\\(==\\)[^=]" 'identical) ;; 'equal is problematic
         (cons "\\(!=\\)" 'not-equal)

         (cons "\\(&&\\)" 'n-ary-logical-and)
         (cons "\\(||\\)" 'n-ary-logical-or)

         (cons "[^&]\\(&\\)[^&]" 'logical-and)
;         (cons "[^|]\\(|\\)[^|]" 'logical-or) ;; confusing

         (cons "[^#]\\(!\\)[^=]" 'logical-neg)

         (cons "\\(%\\*%\\)" 'bullet)
         ;; (cons "\\(%x%\\)" 'n-ary-circled-times)

         (cons "\\(%in%\\)" 'element-of)

         (cons "\\(%\\)[^[:space:]%]+%" 'middle-dot)
         (cons "%[^[:space:]%]+\\(%\\)" 'middle-dot)

         ;; (cons "\\[^=\\]\\(=\\)\\[^=\\]" 'equal)
         )))

(add-hook 'ess-mode-hook 'peRtty-R)
(add-hook 'inferior-ess-mode-hook 'peRtty-R)

;; (define-key ess-help-mode-map (vector '<return>) '(scroll-up 1))
(add-hook 'ess-help-mode-hook '(lambda ()
                                 (local-set-key (kbd "<return>")
                                                (lambda ()
                                                  (interactive)
                                                  (scroll-up 1)))))

;;; ------------------------------------------------------------------ [the end]
