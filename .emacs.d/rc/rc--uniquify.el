;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(require 'uniquify)

(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;;; ----------------------------------------------------------------- [the end]
