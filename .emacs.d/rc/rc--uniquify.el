;;; Time-stamp: <2015-07-21 12:49:51 davidwallin>
;;; Code:

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'reverse)
  (setq uniquify-separator "|")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*"))

;;; ----------------------------------------------------------------- [the end]
