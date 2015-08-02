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

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/einit"))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize)
  :ensure t)

(require 'initd)
(initd-init)

(use-package helm
  :config
  ;; some stuff here comes from:
  ;; https://tuhdo.github.io/helm-intro.html
  ;;
  ;; must set before helm-config,  otherwise helm use default
  ;; prefix "C-x c", which is inconvenient because you can
  ;; accidentially pressed "C-x C-c"
  (setq helm-command-prefix-key "C-c h")
  (require 'helm-config)
  (require 'helm-eshell)
  (require 'helm-files)
  (require 'helm-grep)

  (global-set-key (kbd "M-x") 'helm-M-x)
  ;; This is your old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  (define-key helm-map (kbd "C-RET") 'helm-execute-persistent-action)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
  (global-set-key (kbd "C-x C-r") 'helm-recentf)

  (setq ido-use-virtual-buffers t ; Needed in helm-buffers-list (?)
        )
  (helm-mode 1)
  (add-to-list 'special-display-regexps
               '("\\*[hH]elm.*\\*$" (same-frame . t)))
  (add-to-list 'special-display-buffer-names
               '("*helm buffers*" (same-frame . t)))
  (add-to-list 'special-display-buffer-names
               '("*helm mini*" (same-frame . t)))
  (set-face-attribute 'helm-selection nil
                                        ;                                            :background "#441100"
                      :underline nil)
  :ensure t)

(use-package helm-ag
  :commands (helm-ag)
  :bind ("C-c C-a" . helm-ag)
  :ensure t)

(use-package helm-descbinds
  :config
  (helm-descbinds-install)
  :ensure t)

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
