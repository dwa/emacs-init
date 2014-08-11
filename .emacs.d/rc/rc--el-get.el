;;; Time-stamp: <2014-08-10 20:46:30 dwa>

(when (>= emacs-major-version 24)
  (eval-after-load "package"
    '(progn (add-to-list 'package-archives
                         '("melpa" . "http://melpa.milkbox.net/packages/") t)
            (add-to-list 'package-archives
                         '("marmalade" . "http://marmalade-repo.org/packages/") t)))
  (package-initialize))

;;; Code:

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (end-of-buffer)
      (eval-print-last-sexp))))


(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")
(setq el-get-sources
      '(el-get
        (:name ack-menu)
        (:name auto-complete
               :after (progn
			(require 'auto-complete)
                        (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
			(require 'auto-complete-config)
                        (ac-config-default)
                        (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

                        (add-to-list 'ac-sources 'ac-source-yasnippet)))
        (:name auto-complete-clang
               :after (progn
                        (require 'auto-complete-clang)
                        (setq ac-clang-flags
                              (mapcar (lambda (item)(concat "-I" item))
                                      (split-string
                                       (shell-command-to-string
                                        "echo \"\" | g++ -v -x c++ -E - 2>&1| awk '/^#include <...>/,/^End/'|awk '/^ /{ print; }'"))))
                        ;; we don't want to use clang with Java:
                        ;; (add-hook 'c-mode-common-hook
                        ;;           '(lambda ()
                        ;;              (add-to-list 'ac-sources 'ac-source-clang)))
                        (add-hook 'c-mode-hook
                                  '(lambda ()
                                     (add-to-list 'ac-sources 'ac-source-clang)))
                        (add-hook 'c++-mode-hook
                                  '(lambda ()
                                     (add-to-list 'ac-sources 'ac-source-clang)))))
        cdlatex-mode
        (:name cedet
               :after (progn
                        (setq semanticdb-default-save-directory (expand-file-name "~/.emacs.d/.semanticdb")
                              semanticdb-persistent-path
                              (list (expand-file-name "~/.emacs.d/semantic-cache")))

                        (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
                        (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode t)
                        (add-to-list 'semantic-default-submodes 'global-semantic-show-unmatched-syntax-mode t)

                        (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
                        (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)
                        (global-ede-mode 1)

                        (semantic-load-enable-code-helpers)
                        (global-semanticdb-minor-mode 1)))
        (:name coffee-mode
               :after (progn (setq coffee-command
                                   "~/.npm/coffee-script/1.3.3/package/bin/coffee")
                             (add-hook 'coffee-mode-hook
                                       '(lambda ()
                                          (coffeelintnode-hook)
                                          (coffee-cos-mode t)))))
        (:name coffeelintnode
               :after (progn (require 'flymake-coffeelint)
                             (setq coffeelintnode-location "~/.emacs.d/el-get/coffeelintnode"
                                   coffeelintnode-node-program "/usr/bin/node"
                                   coffeelintnode-coffeelint-excludes (list 'max_line_length)
                                   coffeelintnode-coffeelint-includes '()
                                   coffeelintnode-coffeelint-set ""
                                   ;; Start the server when we first open a coffee file and start checking
                                   coffeelintnode-autostart 'true)))
        clojure-mode
        swank-clojure
        color-moccur
        moccur-edit
        dbgr
        (:name dictionary
               :after (progn
                        ;(setq dictionary-server "localhost")
                        (global-set-key "\C-cs" 'dictionary-search)
                        (global-set-key "\C-cm" 'dictionary-match-words)))
        (:name ein
               :after (progn
			(require 'ein)
                        (setq ein:use-auto-complete-superpack t
                              ein:propagate-connect t)
                        (setq ein:connect-default-notebook "88888/SeamlessNotebook")
                        (add-hook 'python-mode-hook 'ein:connect-to-default-notebook)
                        (add-hook 'ein:connect-mode-hook 'ein:jedi-setup)
                        ;; load notebook list if Emacs is idle for 3 sec after start-up
                        (run-with-idle-timer 3 nil #'ein:notebooklist-load)))
        edit-list
        erc-extras
        (:name ess
               :after (progn
                        (setq ess-use-auto-complete t)))
        gnus
        google-maps
        google-weather
        (:name helm
               :after (progn
                        (global-set-key (kbd "M-x") 'helm-M-x)
                        ;; This is your old M-x.
                        (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

                        (global-set-key (kbd "C-x C-f") 'helm-find-files)
                        (global-set-key (kbd "C-x C-b") 'helm-mini)
                        (helm-mode 1)))
        (:name helm-ag
               :after (progn
                        (global-set-key (kbd "C-x C-a") 'helm-ag)))
        (:name helm-descbinds
               :after (progn
                        (helm-descbinds-install)))
        (:name html5
               :after (progn
                        (eval-after-load "rng-loc"
                          '(add-to-list 'rng-schema-locating-files
                                        "~/.emacs.d/el-get/html5-el/schemas.xml"))

                        (require 'whattf-dt)
                        (eval-after-load "nxml"
                          (progn
                            (defun nxml-html-outline()
                              (interactive)
                              "Sets up the outline mode for XHTML5 for this buffer"
                              (make-local-variable 'nxml-section-element-name-regexp)
                              (setq nxml-section-element-name-regexp "head\\|body\\|blockquote\\|details\\|fieldset\\|figure\\|td\\|section\\|article\\|nav\\|aside")
                              (make-local-variable 'nxml-heading-element-name-regexp)
                              (setq nxml-heading-element-name-regexp "title\\|h[1-9]"))

                            (defun my-nxml-hook()
                              (when (string-match ".x?html$")
                                (nxml-html-outline)))
                            (add-hook 'nxml-mode-hook 'my-nxml-hook)))))
        (:name lacarte
               :after (progn (require 'lacarte)))
        (:name jedi
               :after (progn (add-hook 'python-mode-hook 'jedi:setup)
                             ;(setq jedi:tooltip-method nil)
                             ))
        (:name js2
               :after (progn (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
                             (add-hook 'js2-mode-hook
                                       '(lambda ()
                                          (local-set-key (kbd "M-n") 'next-error)
                                          (local-set-key (kbd "M-p") 'previous-error)))))
        offlineimap
        (:name parenface
               :after (progn
                        ;;
                        ;; the brackets gets invisible on the terminal with parenface:
                        (when t ;window-system
                          (require 'parenface))))
        (:name pcmpl-git :after (require 'pcmpl-git))
        (:name pcmpl-ssh :after (require 'pcmpl-ssh))
        (:name flycheck :after (progn (defun my-flycheck-keybindings ()
                                        (interactive)
                                        (local-set-key (kbd "C-c C-k") 'flycheck-buffer)
                                        (local-set-key (kbd "M-n") 'next-error)
                                        (local-set-key (kbd "M-p") 'previous-error))

                                      (add-hook 'flycheck-mode-hook
                                                #'my-flycheck-keybindings)
                                      (add-hook 'after-init-hook #'global-flycheck-mode)))
        (:name session
	       :after (progn (add-hook 'after-init-hook 'session-initialize)))
        (:name smartparens
               :after (progn
                        (require 'smartparens)
                        (require 'smartparens-config)
                        (setq sp-highlight-pair-overlay nil)
                        (sp-use-paredit-bindings)
                        (define-key sp-keymap (kbd ")") 'sp-up-sexp)
                        (smartparens-global-mode t)
                        (show-smartparens-global-mode t)))
        ;; (:name smex
        ;;        :after (progn
        ;;                 (global-set-key (kbd "M-x") 'smex)
        ;;                 (global-set-key (kbd "M-X") 'smex-major-mode-commands)
        ;;                 ;; This is your old M-x.
        ;;                 (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)))
        (:name visual-regexp)
        (:name visual-regexp-steroids
               :after (progn (require 'visual-regexp-steroids)
                             (define-key global-map (kbd "C-c r") 'vr/replace)
                             (define-key global-map (kbd "C-c q") 'vr/query-replace)
                             ;; to use visual-regexp's isearch instead of the
                             ;; built-in regexp isearch, also include the
                             ;; following lines:
                             (define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
                             (define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s
                             ))
        (:name auto-complete-yasnippet)
        (:name yasnippet
               :after (progn (setq yas/trigger-key "S-SPC")
                             (yas/global-mode 1)))
	))
(el-get 'sync)


(defun my-install-el-get-packages-on-new-computer ()
  (interactive)
  (dolist (i (mapcar (lambda (x) (if (listp x) (plist-get x :name) x)) el-get-sources))
    (el-get-install i)))

;;; ----------------------------------------------------------------- [the end]
