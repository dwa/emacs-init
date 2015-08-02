;;; Time-stamp: <2015-08-02 23:11:29 davidwallin>

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
        ;; (:name auto-complete-clang
        ;;        :after (progn
        ;;                 (require 'auto-complete-clang)
        ;;                 (setq ac-clang-flags
        ;;                       (mapcar (lambda (item)(concat "-I" item))
        ;;                               (split-string
        ;;                                (shell-command-to-string
        ;;                                 "echo \"\" | g++ -v -x c++ -E - 2>&1| awk '/^#include <...>/,/^End/'|awk '/^ /{ print; }'"))))
        ;;                 ;; we don't want to use clang with Java:
        ;;                 ;; (add-hook 'c-mode-common-hook
        ;;                 ;;           '(lambda ()
        ;;                 ;;              (add-to-list 'ac-sources 'ac-source-clang)))
        ;;                 (add-hook 'c-mode-hook
        ;;                           '(lambda ()
        ;;                              (add-to-list 'ac-sources 'ac-source-clang)))
        ;;                 (add-hook 'c++-mode-hook
        ;;                           '(lambda ()
        ;;                              (add-to-list 'ac-sources 'ac-source-clang)))))
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
        ;; clojure-mode
        ;; swank-clojure
        ;; dbgr
        ;; (:name ein
        ;;        :after (progn
	;; 		(require 'ein)
        ;;                 (setq ein:use-auto-complete-superpack t
        ;;                       ein:propagate-connect t)
        ;;                 (setq ein:connect-default-notebook "88888/SeamlessNotebook")
        ;;                 (add-hook 'python-mode-hook 'ein:connect-to-default-notebook)
        ;;                 (add-hook 'ein:connect-mode-hook 'ein:jedi-setup)
        ;;                 ;; load notebook list if Emacs is idle for 3 sec after start-up
        ;;                 (run-with-idle-timer 3 nil #'ein:notebooklist-load)))
        erc-extras
        gnus
        google-maps
        google-weather
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
        (:name js2
               :after (progn (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
                             (add-hook 'js2-mode-hook
                                       '(lambda ()
                                          (local-set-key (kbd "M-n") 'next-error)
                                          (local-set-key (kbd "M-p") 'previous-error)))))
        offlineimap

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
        ))
(el-get 'sync)


(defun my-install-el-get-packages-on-new-computer ()
  (interactive)
  (dolist (i (mapcar (lambda (x) (if (listp x) (plist-get x :name) x)) el-get-sources))
    (el-get-install i)))

;;; ----------------------------------------------------------------- [the end]
