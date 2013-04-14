;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(require 'flymake-shell)

;; (add-to-list 'flymake-allowed-shell-file-name-masks
;; 	     '( ".$" flymake-shell-init))

(add-hook 'sh-set-shell-hook 'flymake-shell-load)
;;(add-hook 'sh-mode-hook 'flymake-shell-load)
(add-hook 'sh-mode-hook 'my-flymake-keybindings)

;;; ----------------------------------------------------------------- [the end]
