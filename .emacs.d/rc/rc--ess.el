;;; Time-stamp: <2013-04-14 00:25:06 dwa>


(require 'ess-eldoc)
;(require 'anything-R)

(eval-after-load "ess"
;;   '(setq-default ess-language "R")
  '(setq-default ess-local-process-name "R"))

(setq ess-ask-for-ess-directory nil)

(add-hook 'ess-mode-hook
	  (lambda ()
	    (yas/minor-mode-on)))

;;
;; inferior ESS
(add-hook 'inferior-ess-mode-hook
	  (lambda ()
            (setq ess-history-directory "~/.R/")))

(add-hook 'inferior-ess-mode-hook 'ess-use-eldoc)
;; (add-hook 'ess-mode-hook 'ess-use-eldoc)

;; from ess-help:
;; http://permalink.gmane.org/gmane.emacs.ess.general/3723
(add-hook 'ess-help-mode-hook
	  (lambda ()
	    (set (make-local-variable 'font-lock-defaults)
		 '(ess-R-mode-font-lock-keywords t))))

(add-to-list 'special-display-regexps '("\\*help\\[R\\].*\\*$" (same-frame . t)))

;; anything

;;
;; ESS/R

;; (defvar anything-c-source-R-help
;;   '((name . "R objects / help")
;;     (init . (lambda ()
;; 	      ;; this grabs the process name associated with the buffer
;;               (setq anything-c-ess-local-process-name ess-local-process-name)))
;;     (candidates . (lambda ()
;;                     (condition-case nil
;;                         (ess-get-object-list anything-c-ess-local-process-name)
;;                       (error nil))))
;;     (action
;;      ("help" . ess-display-help-on-object)
;;      ("head (10)" . (lambda(obj-name)
;;                       (ess-execute (concat "head(" obj-name ", n = 10)\n")
;; 				   nil
;; 				   (concat "R head: " obj-name))))
;;      ("head (100)" . (lambda(obj-name)
;;                        (ess-execute (concat "head(" obj-name ", n = 100)\n")
;; 				    nil
;; 				    (concat "R head: " obj-name))))
;;      ("tail" . (lambda(obj-name)
;;                  (ess-execute (concat "tail(" obj-name ", n = 10)\n")
;; 			      nil
;; 			      (concat "R tail: " obj-name))))
;;      ("str" . (lambda(obj-name)
;;                 (ess-execute (concat "str(" obj-name ")\n")
;; 			     nil
;; 			     (concat "R str: " obj-name))))
;;      ("summary" . (lambda(obj-name)
;;                     (ess-execute (concat "summary(" obj-name ")\n")
;; 				 nil
;; 				 (concat "R summary: " obj-name))))
;;      ("view source" . (lambda(obj-name)
;;                         (ess-execute (concat "print(" obj-name ")\n")
;; 				     nil
;; 				     (concat "R object: " obj-name))))
;;      ("dput" . (lambda(obj-name)
;;                  (ess-execute (concat "dput(" obj-name ")\n")
;; 			      nil
;; 			      (concat "R dput: " obj-name)))))
;;     (volatile)))


;; (defvar anything-c-source-R-local
;;   '((name . "R local objects")
;;     (init . (lambda ()
;; 	      ;; this grabs the process name associated with the buffer
;;               (setq anything-c-ess-local-process-name ess-local-process-name)
;;               ;; this grabs the buffer for later use
;;               (setq anything-c-ess-buffer (current-buffer))))
;;     (candidates . (lambda ()
;;                     (let (buf)
;;                       (condition-case nil
;; 			  (with-temp-buffer
;; 			    (progn
;; 			      (setq buf (current-buffer))
;; 			      (with-current-buffer anything-c-ess-buffer
;; 				(ess-command "print(ls.str(), max.level=0)\n" buf))
;; 			      (split-string (buffer-string) "\n" t)))
;;                         (error nil)))))
;;     (display-to-real . (lambda (obj-name) (car (split-string obj-name " : " t))))
;;     (action
;;      ("str" . (lambda(obj-name)
;;                 (ess-execute (concat "str(" obj-name ")\n") nil (concat "R str: " obj-name))))
;;      ("summary" . (lambda(obj-name)
;;                     (ess-execute (concat "summary(" obj-name ")\n") nil (concat "R summary: " obj-name))))
;;      ("head (10)" . (lambda(obj-name)
;;                       (ess-execute (concat "head(" obj-name ", n = 10)\n") nil (concat "R head: " obj-name))))
;;      ("head (100)" . (lambda(obj-name)
;;                        (ess-execute (concat "head(" obj-name ", n = 100)\n") nil (concat "R head: " obj-name))))
;;      ("tail" . (lambda(obj-name)
;;                  (ess-execute (concat "tail(" obj-name ", n = 10)\n") nil (concat "R tail: " obj-name))))
;;      ("print" . (lambda(obj-name)
;; 		  (ess-execute (concat "print(" obj-name ")\n") nil (concat "R object: " obj-name))))
;;      ("dput" . (lambda(obj-name)
;;                  (ess-execute (concat "dput(" obj-name ")\n") nil (concat "R dput: " obj-name)))))
;;     (volatile)))

;;
;;

(setq anything-c-source-R-packages
      '((name . "R installed packages")
        (init . (lambda ()
                  ;; this grabs the process name associated with the buffer
                  (setq anything-c-ess-local-process-name
                        ess-local-process-name)
                  ;; this grabs the buffer for later use
                  (setq anything-c-ess-buffer (current-buffer))))
        (candidates . (lambda ()
                        (let (buf)
                          (condition-case nil
                              (with-temp-buffer
                                (progn
                                  (setq buf (current-buffer))
                                  (with-current-buffer anything-c-ess-buffer
                                    (ess-command "cat (rownames(installed.packages()),sep=\"\\n\")\n"
                                                 buf))
                                  (split-string (buffer-string) "\n" t)))
                            (error nil)))))
        (display-to-real . (lambda (obj-name) (car (split-string obj-name " : " t))))
        (action
         ("help" . (lambda (package-name)
                     (ess-execute (concat "help(package=" package-name ")") nil (concat "R help: " package-name))))
         ("require" . (lambda (package-name)
                        (ess-execute (concat "require(" package-name ")") 'buffer (concat "R require: " package-name)))))
        (volatile)))

;; (defun my-ess-anything ()
;;   (interactive)
;;   (anything-other-buffer
;;    (append my-global-anything-sources '(anything-c-source-R-local
;; 					anything-c-source-R-help))
;;    "*anything[ess]*"))

(defun my-ess-anything ()
  "Anything for searching math menus"
  (interactive)
  (anything '(anything-c-source-R-local
              anything-c-source-R-help
              anything-c-source-R-packages)
            (thing-at-point 'symbol) "Symbol: "
            nil nil
            "*anything [R]*"))

(eval-after-load "ess-custom"
  '(progn
     (define-key ess-mode-map (kbd "C-`") 'my-ess-anything)
     (define-key inferior-ess-mode-map (kbd "C-`") 'my-ess-anything)))

;; (defun my-ess-keybindings ()
;;   (local-set-key (kbd "C-x C-a") 'my-ess-anything))
;; (add-to-list 'ess-mode-hook 'my-ess-keybindings)

;;; ---

(let ((fl (lambda ()
            (font-lock-add-keywords nil '(("\\(%[^[:space:]%]+%\\)" .
                                           font-lock-keyword-face))))))
  (add-hook 'inferior-ess-mode-hook fl)
  (add-hook 'ess-mode-hook fl))


(require 'pretty-symbols)
(defun peRtty-R ()
  (interactive)
  (substitute-patterns-with-unicode
   (list (cons "\\(<<-\\)" 'left-double-arrow)
         (cons "\\(->>\\)" 'right-double-arrow)
         (cons "[^<]\\(<-\\)" 'left-arrow)
         (cons "\\(->\\)[^>]" 'right-arrow)
         (cons "\\(\\.\\.\\.\\)" 'horizontal-ellipsis)

         (cons "\\(function\\)[[:blank:]]*(" 'lambda)
         ;; (cons "\\(\\$\\)" 'superset-of)

         (cons "\\(>\\)\\[^=\\]" 'greater-than)
         (cons "\\(<\\)\\[^=\\]" 'less-than)

         (cons "\\(>=\\)" 'greater-than-or-equal-to)
         (cons "\\(<=\\)" 'less-than-or-equal-to)

         (cons "\\(?:^\\|[^=]\\)\\(==\\)[^=]" 'identical) ;; 'equal is problematic
         (cons "\\(!=\\)" 'not-equal)

         (cons "\\(&&\\)" 'n-ary-logical-and)
         (cons "\\(||\\)" 'n-ary-logical-or)

         (cons "[^&]\\(&\\)[^&]" 'logical-and)
;         (cons "[^|]\\(|\\)[^|]" 'logical-or) ;; confusing

         (cons "[^#]\\(!\\)[^=]" 'logical-neg)

         (cons "\\(%\\*%\\)" 'bullet)
         ;; (cons "\\(%x%\\)" 'n-ary-circled-times)

         (cons "\\(%in%\\)" 'element-of)

         (cons "\\(%\\)[^[:space:]%]+%" 'middle-dot)
         (cons "%[^[:space:]%]+\\(%\\)" 'middle-dot)

         ;; (cons "\\[^=\\]\\(=\\)\\[^=\\]" 'equal)
         )))

(add-hook 'ess-mode-hook 'peRtty-R)
(add-hook 'inferior-ess-mode-hook 'peRtty-R)

;; (define-key ess-help-mode-map (vector '<return>) '(scroll-up 1))
(add-hook 'ess-help-mode-hook '(lambda ()
                                 (local-set-key (kbd "<return>")
                                                (lambda ()
                                                  (interactive)
                                                  (scroll-up 1)))))

;; fontifies function names (?), not needed anymore ?
;(eval-after-load "ess-common"
;  (setq ess-R-mode-font-lock-keywords
;        (append
;         (list '("\\(\\sw\\|\\s_\\)+\\s-*\\(=\\|<-\\)\\s-*function"
;                 1 font-lock-function-name-face t)
;               '("\\s\"\\(\\S\"+\\)\\s\"\\s-*\\(=\\|<-\\)\\s-*function"
;                 1 font-lock-function-name-face t))
;         ess-R-mode-font-lock-keywords)))

;;; ------------------------------------------------------------------ [the end]
