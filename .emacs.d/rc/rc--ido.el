;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(require 'filecache)
(require 'ido)

(defun file-cache-ido-find-file (file)
  "Using ido, interactively open file from file cache'.
First select a file, matched using ido-switch-buffer against the contents
in `file-cache-alist'. If the file exist in more than one
directory, select directory. Lastly the file is opened."
  (interactive (list (file-cache-ido-read "File: "
                                          (mapcar
                                           (lambda (x)
                                             (car x))
                                           file-cache-alist))))
  (let* ((record (assoc file file-cache-alist)))
    (find-file
     (expand-file-name
      file
      (if (= (length record) 2)
          (car (cdr record))
        (file-cache-ido-read
         (format "Find %s in dir: " file) (cdr record)))))))

(defun file-cache-ido-read (prompt choices)
  (let ((ido-make-buffer-list-hook
	 (lambda ()
	   (setq ido-temp-list choices))))
    (ido-read-buffer prompt)))

(setq ido-file-extensions-order '(".tex"))

(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)	; fuzzy matching is a must have

;(ido-mode t)
;(if drupal-project-path
;    (file-cache-add-directory-using-find drupal-project-path))

;(global-set-key (kbd "ESC ESC f") 'file-cache-ido-find-file)

(defun file-cache-add-this-file ()
  (and buffer-file-name
       (file-exists-p buffer-file-name)
       (file-cache-add-file buffer-file-name)))
;; (add-hook 'kill-buffer-hook 'file-cache-add-this-file)


(setq ido-execute-command-cache nil)

;;
;; from http://www.emacswiki.org/emacs/InteractivelyDoThings:
;; ChrisDone, modified by AttilaLendvai:
(defun ido-execute-command ()
  (interactive)
  (call-interactively
   (intern
    (ido-completing-read
     "M-x "
     (progn
       (unless ido-execute-command-cache
	 (mapatoms (lambda (s)
		     (when (commandp s)
		       (setq ido-execute-command-cache
			     (cons (format "%S" s) ido-execute-command-cache))))))
       ido-execute-command-cache)))))

;; (add-hook 'ido-setup-hook
;; 	  (lambda ()
;; 	    (setq ido-enable-flex-matching t)
;; 	    (global-set-key "\M-x" 'ido-execute-command)))

;;; ----------------------------------------------------------------- [the end]
