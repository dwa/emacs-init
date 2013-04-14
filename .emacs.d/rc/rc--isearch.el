;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(defun isearch-yank-regexp (regexp)
  "Pull REGEXP into search regexp."
  (let ((isearch-regexp nil)) ;; Dynamic binding of global.
    (isearch-yank-string regexp))
  (isearch-search-and-update))

(defun isearch-yank-symbol ()
  "Put symbol at current point into search string."
  (interactive)
  (let ((sym (find-tag-default)))
    (if (null sym)
	(message "No symbol at point")
      (isearch-yank-regexp
       (regexp-quote sym)))))

(define-key isearch-mode-map "\C-\M-w" 'isearch-yank-symbol)

(defun isearch-yank-sexp ()
  "Pull next sexp from buffer into search string."
  (interactive)
  (isearch-yank-string
   (save-excursion
     (and (not isearch-forward) isearch-other-end
	  (goto-char isearch-other-end))
     (buffer-substring-no-properties
      (point) (progn (forward-sexp 1) (point))))))
;; (define-key isearch-mode-map "\C-\M-w" 'isearch-yank-sexp)

(defun isearch-occur ()
  "Invoke `occur' from within isearch."
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

;;; ----------------------------------------------------------------- [the end]
