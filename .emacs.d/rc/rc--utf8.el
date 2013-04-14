;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(defun to-utf8 ()
  "Change coding system to unicode utf-8"
  (interactive)
  (set-buffer-file-coding-system 'utf-8-unix))

(setq read-quoted-char-radix 16)

;; (defun unicode-insert (char)
;;   "Read a unicode code point and insert said character.
;;     Input uses `read-quoted-char-radix'.  If you want to copy
;;     the values from the Unicode charts, you should set it to 16."
;;   (interactive (list (read-quoted-char "Char: ")))
;;   (ucs-insert char))

;;; ----------------------------------------------------------------- [the end]
