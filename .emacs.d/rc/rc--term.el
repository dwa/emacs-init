;;; Time-stamp: <2013-08-01 00:35:29 dwa>

(defun my-arrow-escape-sequences ()
  (define-key input-decode-map "\e[1;2D" [S-left])
  (define-key input-decode-map "\e[1;2C" [S-right])
  (define-key input-decode-map "\e[1;2B" [S-down])
  (define-key input-decode-map "\e[1;2A" [S-up])
  (define-key input-decode-map "\e[1;2F" [S-end])
  (define-key input-decode-map "\e[1;2H" [S-home])

  (define-key input-decode-map "\e[1;3D" [M-left])
  (define-key input-decode-map "\e[1;3C" [M-right])
  (define-key input-decode-map "\e[1;3B" [M-next])
  (define-key input-decode-map "\e[1;3A" [M-prior])
  (define-key input-decode-map "\e[1;3F" [M-end])
  (define-key input-decode-map "\e[1;3H" [M-home])

  (define-key input-decode-map "\e[1;4D" [M-S-left])
  (define-key input-decode-map "\e[1;4C" [M-S-right])
  (define-key input-decode-map "\e[1;4B" [M-S-next])
  (define-key input-decode-map "\e[1;4A" [M-S-prior])
  (define-key input-decode-map "\e[1;4F" [M-S-end])
  (define-key input-decode-map "\e[1;4H" [M-S-home])

  (define-key input-decode-map "\e[1;5D" [C-left])
  (define-key input-decode-map "\e[1;5C" [C-right])
  (define-key input-decode-map "\e[1;5B" [C-next])
  (define-key input-decode-map "\e[1;5A" [C-prior])
  (define-key input-decode-map "\e[1;5F" [C-end])
  (define-key input-decode-map "\e[1;5H" [C-home])

  (define-key input-decode-map "\e[1;6D" [C-S-left])
  (define-key input-decode-map "\e[1;6C" [C-S-right])
  (define-key input-decode-map "\e[1;6B" [C-S-next])
  (define-key input-decode-map "\e[1;6A" [C-S-prior])
  (define-key input-decode-map "\e[1;6F" [C-S-end])
  (define-key input-decode-map "\e[1;6H" [C-S-home])

  (define-key input-decode-map "\e[1;8D" [C-M-left])
  (define-key input-decode-map "\e[1;8C" [C-M-right])
  (define-key input-decode-map "\e[1;8B" [C-M-next])
  (define-key input-decode-map "\e[1;8A" [C-M-prior])
  (define-key input-decode-map "\e[1;8F" [C-M-end])
  (define-key input-decode-map "\e[1;8H" [C-M-home]))

(defadvice server-create-tty-frame
  (after get-C/M/S-arrow-keys-to-work activate)
  "Use other escape sequences for the arrow + Ctrl/Meta/Shift keys"
  (my-arrow-escape-sequences))

;; https://lists.gnu.org/archive/html/help-gnu-emacs/2011-05/msg00211.html
(when system-uses-terminfo
  (my-arrow-escape-sequences))

;;; the end;
