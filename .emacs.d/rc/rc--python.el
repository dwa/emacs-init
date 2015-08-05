;;; Time-stamp: <2015-07-24 00:55:53 davidwallin>
;;; Code:

(use-package jedi
  :commands (jedi:setup)
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'inferior-python-mode-hook 'jedi:setup)
  ;; (setq jedi:tooltip-method nil)
  :defer t
  :disabled t
  :ensure t)

(use-package anaconda-mode
  :commands (anaconda-mode)
  :init
  (add-hook 'python-mode-hook #'anaconda-mode)
  :ensure t)

(use-package ac-anaconda
  :commands (ac-anaconda-setup)
  :init
  (add-hook 'python-mode-hook #'ac-anaconda-setup)
  :ensure t)

(use-package python
  :init
  (add-hook 'python-mode-hook 'turn-on-eldoc-mode)

  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args ""
        python-shell-prompt-regexp "In \\[[0-9]+\\]: "
        python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
        ;; python-shell-completion-setup-code
        ;; "from IPython.core.completerlib import module_completion"
        ;; python-shell-completion-string-code
        ;; "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
        )

  (defun peRtty-python ()
    (interactive)
    (substitute-patterns-with-unicode
     (list (cons "\\(lambda\\)[[:blank:]]*[^:]*:" 'lambda))))

  (add-hook 'python-mode-hook 'peRtty-python))

;;; ----------------------------------------------------------------- [the end]
