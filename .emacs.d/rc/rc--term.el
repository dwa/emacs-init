;;; Time-stamp: <2014-08-10 14:52:55 dwa>

(defun ansi-escape-sequences ()
  (interactive)
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
  (define-key input-decode-map "\e[1;8H" [C-M-home])

  ;; S-


  ;; C-
  (define-key input-decode-map "\e[27;5;13~" (kbd "C-RET"))
  (define-key input-decode-map "\e[27;5;39~" (kbd "C-\'"))
  (define-key input-decode-map "\e[27;5;44~" (kbd "C-,"))
  (define-key input-decode-map "\e[27;5;45~" (kbd "C--"))
  (define-key input-decode-map "\e[27;5;46~" (kbd "C-."))
  (define-key input-decode-map "\e[27;5;47~" (kbd "C-/"))
  (define-key input-decode-map "\e[27;5;59~" (kbd "C-\;"))
  (define-key input-decode-map "\e[27;5;61~" (kbd "C-="))

  (define-key input-decode-map "\e[27;5;48~" (kbd "C-0"))
  (define-key input-decode-map "\e[27;5;49~" (kbd "C-1"))
  (define-key input-decode-map "\e[27;5;50~" (kbd "C-2"))
  (define-key input-decode-map "\e[27;5;51~" (kbd "C-3"))
  (define-key input-decode-map "\e[27;5;52~" (kbd "C-4"))
  (define-key input-decode-map "\e[27;5;53~" (kbd "C-5"))
  (define-key input-decode-map "\e[27;5;54~" (kbd "C-6"))
  (define-key input-decode-map "\e[27;5;55~" (kbd "C-7"))
  (define-key input-decode-map "\e[27;5;56~" (kbd "C-8"))
  (define-key input-decode-map "\e[27;5;57~" (kbd "C-9"))

  ;; C- (mapped from C-S-)
  (define-key input-decode-map "\e[27;6;34~" (kbd "C-\""))
  (define-key input-decode-map "\e[27;6;38~" (kbd "C-&"))
  (define-key input-decode-map "\e[27;6;40~" (kbd "C-\("))
  (define-key input-decode-map "\e[27;6;41~" (kbd "C-\)"))
  (define-key input-decode-map "\e[27;6;125~" (kbd "C-\}"))
  (define-key input-decode-map "\e[27;6;58~" (kbd "C-:"))
  (define-key input-decode-map "\e[27;6;60~" (kbd "C-<"))
  (define-key input-decode-map "\e[27;6;62~" (kbd "C->"))
  (define-key input-decode-map "\e[27;6;63~" (kbd "C-?"))

  ;; M-S-
  (define-key input-decode-map "\e[27;4;13~" (kbd "M-S-RET"))

  ;; C-M-
  (define-key input-decode-map "\e[27;8;13~" (kbd "C-M-RET"))
  ;; C-M-S-
  (define-key input-decode-map "\e[27;9;13~" (kbd "C-M-S-RET"))

)

(defadvice server-create-tty-frame
  (after get-C/M/S-arrow-keys-to-work activate)
  "Use other escape sequences for the arrow + Ctrl/Meta/Shift keys"
  (ansi-escape-sequences))

;; https://lists.gnu.org/archive/html/help-gnu-emacs/2011-05/msg00211.html
(when system-uses-terminfo
  (ansi-escape-sequences))

;;; the end;
