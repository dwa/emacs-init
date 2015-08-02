;;; Time-stamp: <2015-08-02 03:04:59 davidwallin>


;;; Code:

(add-to-list 'auto-mode-alist '( "\\.asd$" . lisp-mode))
(add-to-list 'auto-mode-alist '( "\\.cl$" . lisp-mode))

(add-to-list 'auto-mode-alist '( "\\.ede$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '( "\\.ede$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '( "\\.bmk$" . emacs-lisp-mode))


(add-to-list 'interpreter-mode-alist '( "scsh" . scheme-mode))

; to set the major mode of the '*scratch*' buffer:
;(setq initial-major-mode )

(font-lock-add-keywords 'lisp-mode
   '(("\\(\\(define-\\|do-\\|with-\\)\\(\\s_\\|\\w\\)*\\)"
     1 font-lock-keyword-face)))

;;
;; asdf
(font-lock-add-keywords 'lisp-mode
			'(("\\(defsystem\\|use-package\\)"
			   1 font-lock-keyword-face)))

;;
;; some powerloom (lisa) keywords:
(font-lock-add-keywords 'lisp-mode
			'(("\\(deffunction\\|defrule\\)"
			   1 font-lock-keyword-face)
			  ("\\(deffunction\\|defrule\\)\\(?:[[:blank:]]+\\)\\(\\(\\s_\\|\\w\\)+\\)"
			   2 font-lock-function-name-face)))


;;
;; some weblocks + elephant keywords:
(font-lock-add-keywords 'lisp-mode
			'(("\\(defpclass\\|defwebapp\\|defview\\)"
			   1 font-lock-keyword-face)
			  ("\\(defpclass\\|defwebapp\\|defview\\)\\(?:[[:blank:]]+\\)\\(\\(\\s_\\|\\w\\)+\\)"
			   2 font-lock-type-face)))


;;
;; stefil
(font-lock-add-keywords 'lisp-mode
   '(("\\(defsuite\\(?:\\*\\)?\\|deftest\\|defixture\\)"
      1 font-lock-keyword-face)
     ("\\(deftest\\|defixture\\)\\(?:[[:blank:]]+\\)\\(\\(\\s_\\|\\w\\)+\\)"
      2 font-lock-function-name-face)))

;;
;; swap-key-bindings

(defun swap-key-bindings (x y &optional global)
  (let ((old (key-binding x)))
    (if global
	(progn
	  (global-set-key x (key-binding y))
	  (global-set-key y old))
      (progn
	(local-set-key x (key-binding y))
	(local-set-key y old))
	)))

;;
;; my-lisp-keybindings

(defun my-lisp-keybindings ()
  "Binds bracket keys to strange places."
  (smartparens-strict-mode t))


;; use my lisp keybindings in emacs lisp + scheme mode:
(add-hook 'emacs-lisp-mode-hook (lambda ()
				  (my-lisp-keybindings)
				  (eldoc-mode 1)))

(add-hook 'lisp-interaction-mode-hook (lambda ()
                                        (my-lisp-keybindings)
                                        (eldoc-mode 1)))

(add-hook 'scheme-mode-hook (lambda () (my-lisp-keybindings)))



(setq common-lisp-hyperspec-root
      (cond ((eq system-type 'darwin)
	     "file:///Users/david/Documents/References/HyperSpec/"
	     (eq system-type 'gnu/linux)
	     "file:///usr/share/doc/hyperspec-7.0/HyperSpec/")))

;;
;; courtesy Bill Clementson:
;;
;; FIXME: use w3m here?
(defun lispdoc ()
  "Searches lispdoc.com for SYMBOL, which is by default the symbol
currently under the cursor"
  (interactive)
  (let* ((word-at-point (word-at-point))
         (symbol-at-point (symbol-at-point))
         (default (symbol-name symbol-at-point))
         (inp (read-from-minibuffer
               (if (or word-at-point symbol-at-point)
                   (concat "Symbol (default " default "): ")
		 "Symbol (no default): "))))
    (if (and (string= inp "") (not word-at-point) (not
						   symbol-at-point))
        (message "you didn't enter a symbol!")
      (let ((search-type (read-from-minibuffer
			  "full-text (f) or basic (b) search (default b)? ")))
	(w3m-browse-url (concat "http://lispdoc.com?q="
			    (if (string= inp "")
				default
			      inp)
			    "&search="
			    (if (string-equal search-type "f")
				"full+text+search"
			      "basic+search")))))))
;(define-key lisp-mode-map (kbd "C-c l") 'lispdoc)

(setq pop-up-windows nil)

(add-to-list 'special-display-buffer-names "*compiler notes*")
(add-to-list 'special-display-buffer-names "*compilation*")
(add-to-list 'special-display-buffer-names "*Backtrace*")

(use-package slime
  :commands (slime slime-start)
  :config

  (defmacro defslime (backend)
    (let ((buff (concat "*inferior-lisp-" (symbol-name backend) "*")))
      `(defun ,backend nil
         (interactive)
         (apply #'slime-start
                (list* :buffer ,buff
                       (slime-lookup-lisp-implementation slime-lisp-implementations
                                                         (quote ,backend)))))))

  (slime-setup '(slime-fancy slime-asdf slime-hyperdoc slime-highlight-edits))

  (defslime sbcl)
  ;; (defslime cmucl)
  (defslime clisp)
  (defslime clozure)
  ;; (defslime abcl)

  (add-to-list 'slime-lisp-implementations
               '(sbcl ("sbcl") :coding-system utf-8-unix))

  (add-to-list 'slime-lisp-implementations
               '(clisp ("clisp" "-ansi" "-I") :coding-system utf-8-unix))

  (add-to-list 'slime-lisp-implementations
               '(clozure ("ccl"
                          "-K" "utf-8"
                          "--eval" "(require :asdf)") :coding-system utf-8-unix))

  (add-hook 'inferior-lisp-mode-hook (lambda ()
                                       (inferior-slime-mode t)
                                       (my-lisp-keybindings)))

  (add-hook 'slime-repl-mode-hook (lambda ()
                                    (my-lisp-keybindings)))

  (add-hook 'lisp-mode-hook (lambda ()
                              (slime-mode t)
                              ;; 			    (slime-highlight-edits-mode t)
                              (local-set-key "\r" 'newline-and-indent)
                              (local-set-key [C-S-tab]
                                             'slime-indent-and-complete-symbol)
                              (local-set-key [C-S-iso-lefttab]
                                             'slime-indent-and-complete-symbol)

                              ;; use my keybindings (see above):
                              (my-lisp-keybindings)
                              (setq lisp-indent-function
                                    'common-lisp-indent-function)
                              (setq indent-tabs-mode nil)))
  (add-to-list 'special-display-buffer-names "*SLIME Compiler-Notes*")
  (add-to-list 'special-display-buffer-names '("*SLIME macroexpansion*" (same-frame . t)))
  (add-to-list 'special-display-regexps '("\\*sldb sbcl/[0-9]+\\*" (same-frame . t)))
  :ensure t)


;;; ------------------------------------------------------------------ [the end]
