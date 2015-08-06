;;; Time-stamp: <2015-08-06 15:46:05 davidwallin>
;;; Code:

(use-package flyspell
  :commands (flyspell turn-on-flyspell tex-mode-flyspell-verify)
  :init
  (setq-default ispell-program-name "aspell")
  (setq ispell-local-dictionary "english")

  ;; (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
  ;; (autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
  ;; (autoload 'tex-mode-flyspell-verify "flyspell" "" t)
  :config
  ;; prefer to have M-TAB for other things:
  (define-key flyspell-mode-map (kbd "M-TAB") nil)

  ;; the default flyspell behaviour
  (put 'LaTeX-mode 'flyspell-mode-predicate 'tex-mode-flyspell-verify)

  ;; some extra flyspell delayed command
  (mapcar 'flyspell-delay-command '(scroll-up1 scroll-down1))

  (add-hook 'LaTeX-mode-hook (lambda () (setq ispell-parser 'tex)))
  (add-hook 'LaTeX-mode-hook 'turn-on-flyspell)
  :ensure t)

;;; ----------------------------------------------------------------- [the end]
