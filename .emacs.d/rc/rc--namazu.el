;;; Time-stamp: <2014-08-10 20:25:32 dwa>


;;; Code:

(setq namazu-default-dir "~/namazu-idx/colgate")
(setq namazu-search-num 10)

(defun namazu-browse-file ()
  "Takes the name of the file at point and passes it on to
   the (web) browser to display."
  (interactive)
  (browse-url-of-file (thing-at-point 'filename)))

(defun namazu-dired-jump ()
  "Shows the file (at point) in dired."
  (interactive)
  (let* ((file (thing-at-point 'filename))
	 (dir (if file (file-name-directory file) default-directory)))
    (dired dir)
    (dired-goto-file file)))


(eval-after-load "namazu"
  '(progn
     (define-key namazu-mode-map (kbd "!") 'namazu-browse-file)
     (define-key namazu-mode-map (kbd "C-x C-j") 'namazu-dired-jump)))


;;; ----------------------------------------------------------------- [the end]
