;;; -*- emacs-lisp -*-
;;; Time-stamp: <2013-04-14 21:12:25 dwa>
;;; David Wallin <dwa@havanaclub.org>

;; TODO :
;; - Try and fix when to open new frames or when to split windows
;;   C-h v special-display-regexps RET
;;   special-display-buffer-names
;;

;(load-file "~/.emacs.d/elisp/cedet-1.1/common/cedet.el")
;(load-file "~/.emacs.d/elisp/cedet/cedet-devel-load.el")

(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/einit"))

;;(setq default-directory "~/.emacs.d/")
;;(normal-top-level-add-subdirs-to-load-path)

(require 'initd)
(initd-init)


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
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;;; ------------------------------------------------------------------ [the end]
