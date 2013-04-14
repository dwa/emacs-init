;;; Time-stamp: <2013-04-14 12:05:59 dwa>


;;; Code:

;(add-to-list 'load-path "/Users/david/Gentoo/usr/share/emacs/site-lisp/git")
;;(require 'git)
;;(require 'gitsum)

;; (add-to-list 'load-path "~/sw/emacs/magit")
;; (autoload 'magit-status "magit" nil t)

;; FIXME: Convert these to magit/git?:
;; (add-hook 'darcsum-comment-mode-hook 'turn-on-flyspell)
;; (add-hook 'log-edit-mode-hook 'turn-on-flyspell)
;; (add-hook 'darcsum-mode-hook 'hl-line-mode)

(global-set-key [f12] 'magit-status)

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

;(add-hook 'magit-mode-hook 'yas/minor-mode-off)

;;; ----------------------------------------------------------------- [the end]
