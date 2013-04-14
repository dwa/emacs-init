;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(require 'js)
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-hook 'js-mode-hook 'js-custom-setup)
(defun js-custom-setup ()
  (moz-minor-mode 1))

;;; ----------------------------------------------------------------- [the end]
