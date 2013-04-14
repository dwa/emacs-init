;;; Time-stamp: <2013-04-14 00:25:06 dwa>


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


(defvar anything-c-source-namazu
  '((name . "namazu")
    (candidates . (lambda ()
                    (start-process-shell-command "namazu-process" nil
                                                 (format  "namazu -l %s" anything-pattern namazu-default-dir))))
    (type . file)
    (requires-pattern . 3)
;;     (action . (
;; 	       ("Send to browser" . (lambda (candidate)
;; 				      ()))
;; 	       ("Namazu" . (lambda (candidate)
;; 			     (namazu 1 anything-pattern namazu-default-dir)))))
    (delayed))
  "Source for retrieving files via the command line
utility namazu.")
(add-to-list 'anything-sources anything-c-source-namazu)


(defvar anything-c-source-recoll
  '((name . "recoll")
    (candidates . (lambda ()
                    (start-process-shell-command
                     "recoll-process" nil
                     (format  "recoll -t -b %s" anything-pattern))))
    (type . file)
    (requires-pattern . 3)
    ;;     (action . (
    ;; 	       ("Send to browser" . (lambda (candidate)
    ;; 				      ()))
    ;; 	       ("Namazu" . (lambda (candidate)
    ;; 			     (namazu 1 anything-pattern namazu-default-dir)))))
    (delayed))
  "Source for retrieving files via the command line utility recoll.")

(defun anything-recoll ()
  "Anything recoll search"
  (interactive)
  (anything-other-buffer '(anything-c-source-recoll)
                         "*anything recoll*"))

(defun anything-namazu ()
  "Anything namazu search"
  (interactive)
  (anything-other-buffer '(anything-c-source-namazu)
                         "*anything namazu*"))

;;; ----------------------------------------------------------------- [the end]
