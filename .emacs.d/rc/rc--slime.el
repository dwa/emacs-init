;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(require 'slime)
;; (require 'slime-autoloads)


;;
;; defslime

(defmacro defslime (backend)
  (let ((buff (concat "*inferior-lisp-" (symbol-name backend) "*")))
    `(defun ,backend nil
       (interactive)
       (apply #'slime-start
	      (list* :buffer ,buff
		     (slime-lookup-lisp-implementation slime-lisp-implementations
						       (quote ,backend)))))))


;; (setq inferior-lisp-program "/usr/bin/sbcl")

(slime-setup '(slime-fancy slime-asdf slime-hyperdoc slime-highlight-edits))
;;(slime-setup '(slime-fancy))

;; (setq slime-multiprocessing t)

;(add-hook 'slime-load-hook (lambda () (require 'slime-asdf)))

;;; ----------------------------------------------------------------- [the end]
