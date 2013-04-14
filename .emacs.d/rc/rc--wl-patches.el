;;; Time-stamp: <2013-04-14 00:25:05 dwa>


;;; Code:

(load "~/.emacs.d/wl/wl-draft-jit-lock")

(eval-after-load 'std11
  '(defun std11-parse-word-or-comment (lal)
    (let ((ret (std11-parse-token-or-comment lal)))
      (if ret
	  (let ((elt (car ret))
		(rest (cdr ret)))
	    (cond ((or (assq 'atom elt)
		       (assq 'quoted-string elt)
		       (and (assq 'specials elt) (rassoc "." elt)))
		   (cons (cons 'word elt) rest))
		  ((assq 'comment elt)
		   (cons (cons 'comment-word elt) rest))))))))

;;
;; needs a little massaging:
(defconst email-regexp "[-a-zA-Z]+@[-a-zA-Z]+\.[-.a-zA-Z]+"
  "Simple regexp to match email address.")

;;; ----------------------------------------------------------------- [the end]
