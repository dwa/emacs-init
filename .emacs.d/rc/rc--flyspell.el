;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(setq-default ispell-program-name "aspell")

(setq ispell-local-dictionary "english")

(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
(autoload 'tex-mode-flyspell-verify "flyspell" "" t)

;;; prefer to have M-TAB for other things:
(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "M-TAB") nil))


;; the default flyspell behaviour
(put 'LaTeX-mode 'flyspell-mode-predicate 'tex-mode-flyspell-verify)

;; some extra flyspell delayed command
(mapcar 'flyspell-delay-command '(scroll-up1 scroll-down1))

(add-hook 'LaTeX-mode-hook (lambda () (setq ispell-parser 'tex)))
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)

;;; ----------------------------------------------------------------- [the end]
