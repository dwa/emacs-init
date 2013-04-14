;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(defun byte-compile-init-file ()
   (when (equal user-init-file buffer-file-name)
     (when (file-exists-p (concat user-init-file ".elc"))
       (delete-file (concat user-init-file ".elc")))
     (byte-compile-file user-init-file)))

(add-hook 'after-save-hook 'byte-compile-init-file)

;;; ----------------------------------------------------------------- [the end]
