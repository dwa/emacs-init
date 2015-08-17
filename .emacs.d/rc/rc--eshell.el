;;; Time-stamp: <2015-08-17 15:21:38 davidwallin>
;;; Code:

(use-package eshell
  :config
  (defun eshell-handle-ansi-color ()
    (ansi-color-apply-on-region eshell-last-output-start
                                eshell-last-output-end))

  ;; from http://www.emacswiki.org/emacs/EshellBmk:
  ;; eshell/bmk - version 0.1.2

  (defun pcomplete/eshell-mode/bmk ()
    "Completion for `bmk'"
    (pcomplete-here (bookmark-all-names)))

  (defun eshell/bmk (&rest args)
    "Integration between EShell and bookmarks.
For usage, execute without arguments."
    (setq args (eshell-flatten-list args))
    (let ((bookmark (car args))
          filename name)
      (cond
       ((eq nil args)
        (format "Usage: bmk BOOKMARK to change directory pointed to by BOOKMARK
    or bmk . BOOKMARK to bookmark current directory in BOOKMARK.
Completion is available."))
       ((string= "." bookmark)
        ;; Store current path in EShell as a bookmark
        (if (setq name (car (cdr args)))
            (progn
              (bookmark-set name)
              (bookmark-set-filename name (eshell/pwd))
              (format "Saved current directory in bookmark %s" name))
          (error "You must enter a bookmark name")))
       (t
        ;; Assume the user wants to go to the path pointed out by a bookmark.
        (if (setq filename (cdr (car (bookmark-get-bookmark-record bookmark))))
            (if (file-directory-p filename)
                (eshell/cd filename)
              ;; TODO: Handle this better and offer to go to directory
              ;; where the file is located.
              (error "Bookmark %s points to %s which is not a directory"
                     bookmark filename))
          (error "%s is not a bookmark" bookmark))))))


  ;; http://osdir.com/ml/emacs.help/2002-12/msg00642.html
  (defun eshell/less (&rest args)
    "Invoke `view-file' on the file.
\"less +42 foo\" also goes to line 42 in the buffer."
    (while args
      (if (string-match "\\`\\+\\([0-9]+\\)\\'" (car args))
          (let* ((line (string-to-number (match-string 1 (pop args))))
                 (file (pop args)))
            (view-file file)
            (goto-line line))
        (view-file (pop args)))))
  (use-package pcmpl-git :ensure t)
  (use-package pcmpl-pip :ensure t)
  (use-package pcmpl-homebrew :ensure t)
  (use-package pcomplete-extension :ensure t))

;;; ----------------------------------------------------------------- [the end]
