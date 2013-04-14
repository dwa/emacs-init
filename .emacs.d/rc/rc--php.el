;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

;; (add-to-list 'load-path "~/.emacs.d/php-mode-1.5.0")
;; (require 'php-mode)

;; (require 'flymake-php)
;; (add-hook 'php-mode-user-hook 'flymake-php-load)

;; (add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
;; (add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
;; (add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
;; (add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))

(setq flymake-php-on t)

;; CakePHP template files:
(add-to-list 'auto-mode-alist '("\\.ctp$" . php-mode))

(defun wicked/php-mode-init ()
  "Set some buffer-local variables."
  (setq case-fold-search t)
  (setq indent-tabs-mode nil)
  (setq fill-column 78)
  (setq c-basic-offset 2)
  (c-set-offset 'arglist-cont 0)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'case-label 2)
  (c-set-offset 'arglist-close 0))
;; (add-hook 'php-mode-hook 'wicked/php-mode-init)


;;; ----------------------------------------------------------------- [the end]
