;;; Time-stamp: <2013-04-14 11:16:10 dwa>
;;; David Wallin <dwa@havanaclub.org>

(defvar initd-init-dir "~/.emacs.d/einit"
  "Directory containing init files.")

(defvar initd-init-file-regexp "^ei.*\.el$"
  "Regexp that match init files.")

(defun initd-init (&optional dir)
  (mapcar #'load-file (directory-files (or dir initd-init-dir) t
                                       initd-init-file-regexp nil)))

(provide 'initd)
