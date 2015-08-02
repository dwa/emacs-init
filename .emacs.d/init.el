;;; -*- emacs-lisp -*-
;;; Time-stamp: <2015-07-30 15:04:04 davidwallin>
;;; David Wallin <dwa@havanaclub.org>

;;; Code:

(when (>= emacs-major-version 24)
  (eval-after-load "package"
    '(progn (add-to-list 'package-archives
                         '("melpa" . "http://melpa.milkbox.net/packages/") t)
            (add-to-list 'package-archives
                         '("marmalade" . "https://marmalade-repo.org/packages/") t)))
  (package-initialize))

(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/einit"))

(require 'initd)
(initd-init)

(use-package edit-list
  :commands (edit-list)
  :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (setq yas/trigger-key "S-SPC")
  (yas-global-mode 1))

;; (use-package auto-complete-yasnippet
;;   :ensure t)

;;; --------------------------------------------------- [line ending conversion]

(defun to-mac ()
  "Change coding system to undecided-mac"
  (interactive)
  (set-buffer-file-coding-system 'undecided-mac))

(defun to-unix ()
  "Change coding system to undecided-unix"
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix))

(defun to-dos ()
  "Change coding system to undecided-dos"
  (interactive)
  (set-buffer-file-coding-system 'undecided-dos))


;;
;; rotate the following keybindings:
(global-set-key (kbd "M-,") 'pop-tag-mark)
(global-set-key (kbd "M-*") 'tags-loop-continue)

(cd "~/")

;;; ------------------------------------------------------------------- [custom]
(setq custom-file "~/.emacs.d/elisp/custom.el")
(load custom-file 'noerror)

;;; ------------------------------------------------------------------ [the end]
