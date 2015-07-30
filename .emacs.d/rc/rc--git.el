;;; Time-stamp: <2015-07-24 00:51:07 davidwallin>

;;; Code:

(use-package magit
  :commands (magit-status)
  :bind ("<f12>" . magit-status)
  :config
  ;; http://www.newartisans.com/blog/2008/08/omitting-git-ignored-files-in-emacs-dired.html :

  (add-hook 'dired-load-hook #'(lambda nil (load "dired-x" t)))
  (eval-after-load "dired-x"
    '(progn
       (defvar dired-omit-regexp-orig (symbol-function 'dired-omit-regexp))

       (defun dired-omit-regexp ()
         (let ((file (expand-file-name ".git"))
               parent-dir)
           (while (and (not (file-exists-p file))
                       (progn
                         (setq parent-dir
                               (file-name-directory
                                (directory-file-name
                                 (file-name-directory file))))
                         ;; Give up if we are already at the root dir.
                         (not (string= (file-name-directory file)
                                       parent-dir))))
             ;; Move up to the parent dir and try again.
             (setq file (expand-file-name ".git" parent-dir)))
           ;; If we found a change log in a parent, use that.
           (if (file-exists-p file)
               (let ((regexp (funcall dired-omit-regexp-orig)))
                 (assert (stringp regexp))
                 (concat
                  regexp
                  (if (> (length regexp) 0)
                      "\\|" "")
                  "\\("
                  (mapconcat
                   #'(lambda (str)
                       (concat "^"
                               (regexp-quote
                                (substring str 13
                                           (if (= ?/ (aref str (1- (length str))))
                                               (1- (length str))
                                             nil)))
                               "$"))
                   (split-string (shell-command-to-string
                                  "git clean -d -x -n")
                                 "\n" t)
                   "\\|")
                  "\\)"))
             (funcall dired-omit-regexp-orig))))))

  (add-to-list 'special-display-buffer-names '("*magit-commit*" (same-frame . t)))
  :ensure t)

;;; ----------------------------------------------------------------- [the end]
