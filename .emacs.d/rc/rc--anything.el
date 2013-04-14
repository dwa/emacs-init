;;; Time-stamp: <2013-04-14 00:25:07 dwa>


;;; Code:

;; (require 'anything-startup)
;; (require 'anything)
(require 'anything-config)

;; (defun anything-c-buffer-list ()
;;   "Return the list of names of buffers with the `anything-buffer'
;; and hidden buffers filtered out.  The first buffer in the list
;; will be the last recently used buffer that is not the current
;; buffer."
;;   (let ((buffers (remove-if (lambda (name)
;;                               (or (equal name anything-buffer)
;;                                   (eq ?\  (aref name 0))))
;;                             (mapcar 'buffer-name (buffer-list)))))
;;     (append (cdr buffers) (list (car buffers)))))

;; (defvar anything-c-buffers-face1 'bold)
;; (defvar anything-c-buffers-face2 'font-lock-type-face)
;; (defvar anything-c-buffers-face3 'italic)
;; (defun anything-c-highlight-buffers (buffers)
;;   (let ((cand-mod (loop for i in buffers
;; 			if (rassoc (get-buffer i) dired-buffers)
;; 			collect (propertize i
;; 					    'face anything-c-buffers-face1)
;; 			if (buffer-file-name (get-buffer i))
;; 			collect (propertize i
;; 					    'face anything-c-buffers-face2)
;; 			if (and (not (rassoc (get-buffer i) dired-buffers))
;; 				(not (buffer-file-name (get-buffer i))))
;; 			collect (propertize i
;; 					    'face anything-c-buffers-face3))))
;;     cand-mod))

;; (defvar anything-c-source-buffers
;;   '((name . "Buffers")
;;     (candidates . anything-c-buffer-list)
;;     (volatile)
;;     (type . buffer)
;;     (candidate-transformer . (lambda (candidates)
;;                                (anything-c-compose
;;                                 (list candidates)
;;                                 '(anything-c-highlight-buffers))))
;;     (persistent-action . (lambda (name)
;;                            (flet ((kill (item)
;; 					(with-current-buffer item
;; 					  (if (and (buffer-modified-p)
;; 						   (buffer-file-name (current-buffer)))
;; 					      (progn
;; 						(save-buffer)
;; 						(kill-buffer item))
;; 					    (kill-buffer item))))
;;                                   (goto (item)
;; 					(switch-to-buffer item)))
;;                              (if current-prefix-arg
;;                                  (progn
;;                                    (kill name)
;;                                    (anything-delete-current-selection))
;; 			       (goto name)))))))

;; (add-to-list 'anything-sources anything-c-source)


(defvar anything-c-source-occur
  '((name . "Occur")
    (init . (lambda ()
              (setq anything-occur-current-buffer
                    (current-buffer))))
    (candidates . (lambda ()
                    (let ((anything-occur-buffer (get-buffer-create "*Anything Occur*")))
                      (with-current-buffer anything-occur-buffer
                        (occur-mode)
                        (erase-buffer)
                        (let ((count (occur-engine anything-pattern
                                                   (list anything-occur-current-buffer) anything-occur-buffer
                                                   list-matching-lines-default-context-lines case-fold-search
                                                   list-matching-lines-buffer-name-face
                                                   nil list-matching-lines-face
                                                   (not (eq occur-excluded-properties t)))))
                          (when (> count 0)
                            (setq next-error-last-buffer anything-occur-buffer)
                            (cdr (split-string (buffer-string) "\n" t))))))))
    (action . (("Goto line" . (lambda (candidate)
                                (with-current-buffer "*Anything Occur*"
                                  (search-forward candidate))
                                (goto-line (string-to-number candidate) anything-occur-current-buffer)))))
    (requires-pattern . 3)
    (volatile)
    (delayed)))

;;(add-to-list 'anything-sources anything-c-source-occur)

(defvar org-remember-anything
  '((name . "Org Remember")
    (candidates . (lambda () (mapcar 'car org-remember-templates)))
    (action . (lambda (name)
                (let* ((orig-template org-remember-templates)
                       (org-remember-templates
                        (list (assoc name orig-template))))
                  (call-interactively 'org-remember))))))

;; (add-to-list 'anything-sources org-remember-anything)

;; (defvar anything-c-source-lacarte
;;   '((name . "Lacarte")
;;     (init . (lambda ()
;;               (setq anything-c-lacarte-current-buffer (current-buffer))))
;;     (candidates .
;;                 (lambda ()
;;                   (with-current-buffer anything-c-lacarte-current-buffer
;;                     (delete '(nil) (lacarte-get-overall-menu-item-alist)))))
;;     (candidate-number-limit . 9999)
;;     (action . (("Open" . (lambda (candidate)
;;                            (call-interactively candidate)))))))
;; (add-to-list 'anything-sources anything-c-source-lacarte)

;(require 'lacarte)

(defvar my-global-anything-sources '(anything-c-source-lacarte
				     anything-c-source-register
				     anything-c-source-buffers
				     ;; anything-c-source-file-name-history
				     ;; anything-c-source-info-pages
				     ;; anything-c-source-info-elisp
				     ;; anything-c-source-man-pages
				     ;; anything-c-source-locate
				     ;; anything-c-source-emacs-commands
				     ))

(defun my-global-anything ()
  (interactive)
  (anything-other-buffer
   my-global-anything-sources
   "*anything[G]*"))
(global-set-key (kbd "C-x C-a") 'my-global-anything)


;;; LaCarte

;; from http://www.emacswiki.org/emacs/AnythingSources#toc38

;; Here’s an updated LaCarte that grabs the menu from the active buffer, not the
;; anything buffer:

(defvar anything-c-source-lacarte-active
  '((name . "Lacarte")
    (init . (lambda ()
              (setq anything-c-lacarte-current-buffer (current-buffer))))
    (candidates .
                (lambda ()
                  (with-current-buffer anything-c-lacarte-current-buffer
                    (delete '(nil) (lacarte-get-overall-menu-item-alist)))))
    (candidate-number-limit . 9999)
    (action . (("Open" . (lambda (candidate)
                           (call-interactively candidate)))))))


(defun my-lacarte-anything ()
  (interactive)
  (anything-other-buffer
   '(anything-c-source-lacarte-active)
   "*Anything LaCarte Menu*"))
(global-set-key (kbd "M-`") 'my-lacarte-anything)


;;; Math mode in LaTeX

(eval-after-load "latex"
  '(progn
     (setq LaTeX-math-menu-unicode t)
     (define-key LaTeX-mode-map (kbd "C-`") 'anything-math-symbols)))

(defvar anything-c-source-lacarte-math
  '((name . "Math Symbols")
    (init . (lambda()
              (setq anything-c-lacarte-major-mode major-mode)))
    (candidates
     . (lambda () (if (eq anything-c-lacarte-major-mode 'latex-mode)
                      (delete '(nil) (lacarte-get-a-menu-item-alist LaTeX-math-mode-map)))))
    (action . (("Open" . (lambda (candidate)
                           (call-interactively candidate)))))))

(defun anything-math-symbols ()
  "Anything for searching math menus"
  (interactive)
  (anything-other-buffer '(anything-c-source-lacarte-math)
;            (thing-at-point 'symbol) "Symbol: "
;            nil nil
            "*anything math symbols*"))



;;; ---

(defvar anything-c-recoll-option
  '("recoll" "-t")
  "A list where the `car' is the name of the recoll program followed by options.
You do not need to include the -c option since this is already included, and the config directory
can be passed as a argument to `anything-c-source-recoll'")

(defun anything-c-source-recoll (name confdir)
  "Function to create anything source for recoll search results.
The source variable will be named `anything-c-source-recoll-NAME' where NAME is the first arg to the function
 (and should be a valid symbol name - i.e. no spaces).
The CONFDIR arg should be a string indicating the path to the config directory which recoll should use."
  (eval
   `(defvar ,(intern (concat "anything-c-source-recoll-" name))
      '((name . ,(concat "Recoll " name))
        (candidates . (lambda ()
                        (apply 'start-process "recoll-process" nil
                               (append (list (car anything-c-recoll-options))
                                       '("-c" ,confdir)
                                       (cdr anything-c-recoll-options)
                                       (list anything-pattern)))))
        (candidate-transformer
         . (lambda (cs)
             (mapcar (function (lambda (c)
                                 (replace-regexp-in-string "file://" "" c)))
                     cs)))
        (type . file)
        (requires-pattern . 3)
        (delayed))
      ,(concat "Source for retrieving files matching the current input pattern, using recoll with the configuration in "
               confdir))))

;(anything-c-source-recoll "docs" "~/.recoll")


(defun anything-recoll-docs ()
  "Anything for searching docs"
  (interactive)
  (anything-other-buffer '(anything-c-source-recoll-docs)
;            (thing-at-point 'symbol) "Symbol: "
;            nil nil
            "*anything recoll docs*"))

;;; ----------------------------------------------------------------- [the end]
