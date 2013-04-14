;;; Time-stamp: <2013-04-14 18:41:39 dwa>


;;; Code:

;;; ------------------------------------------------------------------ [paredit]

(unless (featurep 'paredit)
  (autoload 'paredit-mode "paredit"
    "Minor mode for pseudo-structurally editing Lisp code." t))

;; (eval-after-load "paredit"
;;   '(progn (define-key paredit-mode-map (kbd "RET") nil)
;; 	  (define-key lisp-mode-shared-map (kbd "RET") 'paredit-newline)
;; ;	  (define-key scheme-mode-shared-map (kbd "RET") 'paredit-newline)
;; 	  ))

(defvar uses-bracket-remapping nil)
;;
;; toggle-bracket-keymapping
;;
;; FIXME: An optional value should be allowed:

(defun swap-bracket-keymapping ()
  (interactive)
  (keyboard-translate ?\( ?\[)
  (keyboard-translate ?\[ ?\()
  (keyboard-translate ?\) ?\])
  (keyboard-translate ?\] ?\))
  (setq uses-bracket-remapping t))

(defun swap-bracket-keymapping-1 ()
  (interactive)
  (define-key key-translation-map [?\(] [?\[])
  (define-key key-translation-map [?\[] [?\(])
  (define-key key-translation-map [?\)] [?\]])
  (define-key key-translation-map [?\]] [?\)])
  (setq uses-bracket-remapping t))


(defun reset-bracket-keymapping ()
  (interactive)
  (keyboard-translate ?\( ?\()
  (keyboard-translate ?\[ ?\[)
  (keyboard-translate ?\) ?\))
  (keyboard-translate ?\] ?\])
  (setq uses-bracket-remapping nil))

(defun reset-bracket-keymapping-1 ()
  (interactive)
  (define-key key-translation-map [?\(] [?\(])
  (define-key key-translation-map [?\[] [?\[])
  (define-key key-translation-map [?\)] [?\)])
  (define-key key-translation-map [?\]] [?\]])
  (setq uses-bracket-remapping nil))


(defun toggle-bracket-keymapping ()
  "Toggles the remapping of the bracket keys."
  (interactive)
  (if uses-bracket-remapping
      (reset-bracket-keymapping)
    (swap-bracket-keymapping)))

(eval-after-load "paredit"
  '(progn (define-key paredit-mode-map (kbd "M-\(") nil)
;	  (define-key paredit-mode-map (kbd "M-\[") 'paredit-wrap-sexp)
          (define-key paredit-mode-map (kbd "M-[") nil)
	  (define-key paredit-mode-map (kbd "M-\)") nil)
	  (define-key paredit-mode-map (kbd "M-\]") 'paredit-close-parenthesis)

;          (swap-bracket-keymapping)
))

;; use it
(swap-bracket-keymapping-1)
