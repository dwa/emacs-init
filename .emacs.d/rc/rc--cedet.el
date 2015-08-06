;;; Time-stamp: <2015-08-06 02:11:32 davidwallin>
;;; Code:

(use-package cedet
  :init
  (setq semanticdb-default-save-directory (expand-file-name "~/.emacs.d/.semanticdb")
        semanticdb-persistent-path
        (list (expand-file-name "~/.emacs.d/semantic-cache")))
  :config
  (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
  (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode t)
  (add-to-list 'semantic-default-submodes 'global-semantic-show-unmatched-syntax-mode t)

  (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
  (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

  (global-ede-mode 1)

  (semantic-load-enable-code-helpers)
  (global-semanticdb-minor-mode 1))

;;; ----------------------------------------------------------------- [the end]
