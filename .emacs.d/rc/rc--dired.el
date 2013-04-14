;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

;;; -------------------------------------------------------------------- [dired]

;; (kmacro-end-or-call-macro ARG &optional NO-REPEAT)
;; make a macro out of this:
;;
;; (dolist (file (dired-get-marked-files nil nil 'dired-nondirectory-p))
;;   (let ((buffer (get-file-buffer file)))
;;     (if (and buffer (with-current-buffer buffer
;;                       buffer-read-only))
;;         (error "File `%s' is visited read-only" file))))


(defun dired-do-occur (regexp &optional nlines)
  (interactive
   (occur-read-primary-args))
  (let ((buffers (loop for i in (dired-get-marked-files)
                    collect (find-file-noselect i))))
    (multi-occur buffers regexp nlines)))

(add-hook 'dired-mode-hook (lambda ()
			     (define-key dired-mode-map (kbd "b")
			       'browse-url-of-dired-file)
			     (define-key dired-mode-map (kbd "% O")
			       'dired-do-occur)
			    (local-set-key [mouse-2] 'dired-find-file)))

(setq dired-recursive-deletes 'top
      dired-recursive-copies 'top)

(add-hook 'dired-mode-hook 'hl-line-mode)

;;
;; this doesn't seem to do much:
;; (eval-after-load "dired"
;;   (setq ls-lisp-dirs-first t))		;display dirs first in dired

(require 'dired-x)
;(eval-after-load "dired" (load "dired-x"))

;;; ----------------------------------------------------------------- [the end]
