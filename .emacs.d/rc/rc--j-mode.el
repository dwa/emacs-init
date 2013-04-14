;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(autoload 'j-mode "j-mode.el"  "Major mode for J." t)
(autoload 'j-shell "j-mode.el" "Run J from emacs." t)

(setq j-path (concat (getenv "HOME") "/j601/"))

(add-hook 'j-mode-hook 'imenu-add-menubar-index)
;;(which-func-mode 1) ; shows the current function in statusbar

(add-to-list 'auto-mode-alist '("\\.ij[rstp]" . j-mode))

;;; ----------------------------------------------------------------- [the end]
