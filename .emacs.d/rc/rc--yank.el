;;; Time-stamp: <2013-04-14 00:25:05 dwa>


;;; Code:

;; http://trey-jackson.blogspot.com/2008/03/emacs-tip-15-indent-yanked-code.html

;; Emacs Tip #15: indent yanked code

;; I'm a bit apprehensive about this chunk of code, mainly because
;; it facilitates cut/paste coding, which I abhor. Nevertheless, it
;; does come in handy.

;; When you (shudder) cut/paste code, one of the first things you do
;; is immediately indent the code appropriately. Well, why not have
;; that done automatically for you? This chunk of emacs lisp does
;; the trick rather nicely.

;; It will not indent regions that are too large (see
;; yank-advised-indent-threshold) and given a prefix argument, it
;; will not indent.


;; automatically indenting yanked text if in programming-modes
(defvar yank-indent-modes '(emacs-lisp-mode
			    lisp-mode
                            c-mode c++-mode
                            tcl-mode sql-mode
                            perl-mode cperl-mode
                            java-mode jde-mode
                            lisp-interaction-mode
                            LaTeX-mode TeX-mode)
  "Modes in which to indent regions that are yanked (or yank-popped)")

(defvar yank-advised-indent-threshold 1000
  "Threshold (# chars) over which indentation does not automatically occur.")

;; my contribution to this:
(defun yank-indent-region-beginning ()
  (save-excursion (goto-char (region-beginning))
		  (move-beginning-of-line 1)
		  (point)))

(defun yank-advised-indent-function (beg end)
  "Do indentation, as long as the region isn't too large."
  (if (<= (- end beg) yank-advised-indent-threshold)
      (indent-region beg end nil)))

(defadvice yank (after yank-indent activate)
  "If current mode is one of 'yank-indent-modes, indent yanked text (with prefix arg don't indent)."
  (if (and (not (ad-get-arg 0))
           (member major-mode yank-indent-modes))
      (let ((transient-mark-mode nil))
    (yank-advised-indent-function (yank-indent-region-beginning)
				  (region-end)))))

(defadvice yank-pop (after yank-pop-indent activate)
  "If current mode is one of 'yank-indent-modes, indent yanked text (with prefix arg don't indent)."
  (if (and (not (ad-get-arg 0))
           (member major-mode yank-indent-modes))
    (let ((transient-mark-mode nil))
    (yank-advised-indent-function (yank-indent-region-beginning)
				  (region-end)))))
