;;; Time-stamp: <2013-04-14 00:25:07 dwa>


;;; Code:

(if (not (featurep 'semantic))
    (require 'semantic))

(setq semanticdb-default-save-directory (expand-file-name "~/.emacs.d/.semanticdb")
      semanticdb-persistent-path
      (list (expand-file-name "~/.emacs.d/semantic-cache")))

(global-semanticdb-minor-mode 1); Initialize semanticdb
;; Load support for the auto-add
;;(semantic-load-enable-gaudy-code-helpers)
;(semantic-load-enable-code-helpers)

(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;;(add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-show-unmatched-syntax-mode t)

(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode t)

;(semantic-mode 1)

;;; ----------------------------------------------------------------- [the end]
