;;; Time-stamp: <2014-08-10 16:06:50 dwa>

;;; Code:

(add-hook 'python-mode-hook 'turn-on-eldoc-mode)
(add-hook 'python-mode-hook 'jedi:setup)

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args ""
      python-shell-prompt-regexp "In \\[[0-9]+\\]: "
      python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
      ;; python-shell-completion-setup-code
      ;; "from IPython.core.completerlib import module_completion"
      ;; python-shell-completion-module-string-code
      ;; "';'.join(module_completion('''%s'''))\n"
      ;; python-shell-completion-string-code
      ;; "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
)

(add-hook 'inferior-python-mode-hook 'jedi:setup)

(defun peRtty-python ()
  (interactive)
  (substitute-patterns-with-unicode
   (list (cons "\\(lambda\\)[[:blank:]]*[^:]*:" 'lambda))))

(add-hook 'python-mode-hook 'peRtty-python)

;; (add-hook 'python-mode-hook
;;           #'(lambda ()
;;               (setq autopair-handle-action-fns
;;                     (list #'autopair-default-handle-action
;;                           #'autopair-python-triple-quote-action))))

;;; ----------------------------------------------------------------- [the end]
