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

(use-package auto-complete
  :init
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  :config
  (require 'auto-complete)
  (require 'auto-complete-config)
  (ac-config-default)
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (add-to-list 'ac-sources 'ac-source-yasnippet))

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

(use-package session
  :init
  (add-hook 'after-init-hook 'session-initialize)
  :ensure t)

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
  :commands (dictionary-search dictionary-match-words)
  :init
  (bind-key "\C-cs" 'dictionary-search)
  (bind-key "\C-cm" 'dictionary-match-words)
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
