;;; keyremapping.el --- Summary
;;; Time-stamp: <2014-08-09 21:58:02 dwa>
;;; Commentary:
;;; use it like this:
;;; (swap-bracket-keymapping-1)
;;; David Wallin <dwa@havanaclub.org>

;;; Code:

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

(provide 'keyremapping)
;;; keyremapping.el ends here
