;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(autoload 'darcsum-whatsnew "darcsum")
(setq darcsum-whatsnew-switches "-l")

(add-hook 'darcsum-comment-mode-hook 'turn-on-flyspell)
(add-hook 'log-edit-mode-hook 'turn-on-flyspell)

(add-hook 'darcsum-mode-hook 'hl-line-mode)

(global-set-key [S-f8] 'darcsum-whatsnew)

;;; ----------------------------------------------------------------- [the end]
