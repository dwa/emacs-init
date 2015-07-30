;;; Time-stamp: <2015-07-21 12:52:02 davidwallin>
;;; Code:

(use-package dired
  :config

  (defun dired-do-occur (regexp &optional nlines)
    (interactive
     (occur-read-primary-args))
    (let ((buffers (loop for i in (dired-get-marked-files)
                         collect (find-file-noselect i))))
      (multi-occur buffers regexp nlines)))

  (add-hook 'dired-mode-hook (lambda ()
                               (define-key dired-mode-map (kbd "b")
                                 'browse-url-of-dired-file)
                               (define-key dired-mode-map (kbd "% O")
                                 'dired-do-occur)
                               (local-set-key [mouse-2] 'dired-find-file)))

  (setq dired-recursive-deletes 'top
        dired-recursive-copies 'top)

  (add-hook 'dired-mode-hook 'hl-line-mode))

;(use-package dired-x)

;;; ----------------------------------------------------------------- [the end]
