;;; initd.el --- Summary
;;; Time-stamp: <2014-08-09 21:54:54 dwa>
;;; David Wallin <dwa@havanaclub.org>

;;; Code:
(defvar initd-init-dir "~/.emacs.d/einit"
  "Directory containing init files.")

(defvar initd-init-file-regexp "^ei.*\.el$"
  "Regexp that match init files.")

(defun initd-init (&optional dir)
  (mapcar #'load-file (directory-files (or dir initd-init-dir) t
                                       initd-init-file-regexp nil)))

(provide 'initd)
;;; initd.el ends here
