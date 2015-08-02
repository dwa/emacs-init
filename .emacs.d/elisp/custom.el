;;; custom.el -
;;;
;;;
;;; Time-stamp: <2015-08-02 02:16:16 davidwallin>
;;;
;;; copyright (c) 2008. all rights reserved.
;;; David Wallin <dwa@havanaclub.org>


;;; Code:

(put 'package 'safe-local-variable 'symbolp)
(put 'Package 'safe-local-variable 'symbolp)
(put 'syntax 'safe-local-variable 'symbolp)
(put 'Syntax 'safe-local-variable 'symbolp)
(put 'Base 'safe-local-variable 'integerp)
(put 'base 'safe-local-variable 'integerp)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "fa11ec1dbeb7c54ab1a7e2798a9a0afa1fc45a7b90100774d7b47d521be6bfcf" default)))
 '(load-home-init-file t t)
 '(safe-local-variable-values
   (quote
    ((flycheck-checker quote python-pylint)
     (flycheck-checker quote python-flake8)
     (flycheck-checker . "python-flake8")
     (python-shell-interpreter-args . "-m IPython.terminal.ipapp")
     (python-shell-interpreter . "python")
     (python-shell-completion-string-code . "';'.join(get_ipython().Completer.all_completions('''%s'''))
")
     (python-shell-completion-module-string-code . "';'.join(module_completion('''%s'''))
")
     (python-shell-completion-setup-code . "from IPython.core.completerlib import module_completion")
     (python-shell-interpreter-args . "")
     (python-shell-interpreter . "ipython"))))
 '(session-use-package t nil (session)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
