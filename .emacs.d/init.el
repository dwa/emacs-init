;;; -*- emacs-lisp -*-
;;; Time-stamp: <2015-08-02 23:29:08 davidwallin>
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

(use-package session
  :init
  (add-hook 'after-init-hook 'session-initialize)
  :ensure t)

(setq custom-file "~/.emacs.d/elisp/custom.el")
(load custom-file)


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
  :bind (("M-x" . helm-M-x)
         ("C-c C-c M-x" . execute-extended-command)
         ("C-RET" . helm-execute-persistent-action)
         ("C-x C-f" . helm-find-files)
         ("C-x C-b" . helm-buffers-list)
         ("C-x C-r" . helm-recentf))
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

(use-package helm-swoop
  :commands (helm-swoop-from-isearch helm-multi-swoop-all-from-helm-swoop)
  :bind (("M-i" . helm-swoop)
         ("M-I" . helm-swoop-back-to-last-point)
         ("C-c M-i" . helm-multi-swoop)
         ("C-x M-i" . helm-multi-swoop-all))
  :config
  ;; When doing isearch, hand the word over to helm-swoop
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
  ;; From helm-swoop to helm-multi-swoop-all
  (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
  ;; When doing evil-search, hand the word over to helm-swoop
  ;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

  ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
  (define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

  ;; Move up and down like isearch
  (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
  (define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t)

  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows nil)

  ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
  (setq helm-swoop-split-direction 'split-window-vertically)

  ;; If nil, you can slightly boost invoke speed in exchange for text color
  (setq helm-swoop-speed-or-color nil)

  ;; ;; Go to the opposite side of line from the end or beginning of line
  (setq helm-swoop-move-to-line-cycle t)

  ;; Optional face for line numbers
  ;; Face name is `helm-swoop-line-number-face`
  (setq helm-swoop-use-line-number-face t)
  :ensure t)

(use-package edit-list
  :commands (edit-list)
  :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (setq yas/trigger-key "S-SPC")
  (yas-global-mode 1))

(use-package auto-complete
  :init
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  :config
  (require 'auto-complete)
  (require 'auto-complete-config)
  (ac-config-default)
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (add-to-list 'ac-sources 'ac-source-yasnippet))

(use-package smartparens
  :init
  :config
  (require 'smartparens)
  (require 'smartparens-config)
  (setq sp-highlight-pair-overlay nil)
  (sp-use-paredit-bindings)
  (define-key sp-keymap (kbd ")") 'sp-up-sexp)
  (smartparens-global-mode t)
  (show-smartparens-global-mode t)
  :ensure t)

(use-package ack-menu
  :ensure t)

(use-package ansible-doc
  :ensure t)

(use-package yaml-mode
  :init
  (add-hook 'yaml-mode-hook #'ansible-doc-mode)
  :ensure t)

(use-package dictionary
  :bind (("C-c s" . dictionary-search)
         ("C-c m" . dictionary-match-words))
  :ensure t)

(use-package color-moccur
  :commands (isearch-moccur isearch-all)
  :bind ("M-s O" . moccur)
  :init
  (bind-key "M-o" 'isearch-moccur isearch-mode-map)
  (bind-key "M-O" 'isearch-moccur-all isearch-mode-map)
;  :config
;  (use-package moccur-edit :ensure t)
  :ensure t)

(use-package flycheck
  :config
  (defun my-flycheck-keybindings ()
    (interactive)
    (local-set-key (kbd "C-c C-k") 'flycheck-buffer)
    (local-set-key (kbd "M-n") 'next-error)
    (local-set-key (kbd "M-p") 'previous-error))

  (add-hook 'flycheck-mode-hook
            #'my-flycheck-keybindings)

  ;; https://github.com/flycheck/flycheck/issues/692
  (declare-function python-shell-calculate-exec-path "python")

  (defun flycheck-virtualenv-set-python-executables ()
    "Set Python executables for the current buffer."
    (let ((exec-path (python-shell-calculate-exec-path)))
      (setq-local flycheck-python-pylint-executable
                  (executable-find "pylint"))
      (setq-local flycheck-python-flake8-executable
                  (executable-find "flake8"))))

  (add-hook 'hack-local-variables-hook
            #'(lambda ()
                (when (derived-mode-p 'python-mode)
                (flycheck-virtualenv-set-python-executables)))
            'local)

  (add-hook 'after-init-hook #'global-flycheck-mode)
  :ensure t)

(use-package lentic
  :ensure t)

(use-package lacarte
  :ensure t)

(use-package multiple-cursors
  :ensure t)

(use-package request-deferred
  :ensure t)

(use-package rainbow-delimiters
  :ensure t)

;; docker
(use-package docker
  :ensure t)

;(use-package docker-tramp
;  :ensure t)

(use-package dockerfile-mode
  :mode "Dockerfile"
  :ensure t)

;; SQL

(use-package edbi
  :ensure t)

(use-package pass
  :ensure t)

(use-package smart-mode-line
  :config
  (setq sml/theme 'respectful)
  (sml/setup)
  :ensure t)
(use-package ssh-tunnels
  :commands (ssh-tunnels)
  :init
  (load-file "~/.secrets.d/ssh-tunnels.el")
  :ensure t)

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

;;; ------------------------------------------------------------------ [the end]
