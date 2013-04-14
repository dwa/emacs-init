;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;; Code:

(autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))


(defun lisp-enable-paredit-hook () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'lisp-enable-paredit-hook)

;;      (autoload 'clojure-test-mode "clojure-test-mode" "Clojure test mode" t)
;;      (autoload 'clojure-test-maybe-enable "clojure-test-mode" "" t)
;;      (add-hook 'clojure-mode-hook 'clojure-test-maybe-enable)


;;
;; slime integration:

(require 'clojure-mode)
(require 'swank-clojure)

(eval-after-load "slime"
  '(progn
     (require 'swank-clojure)
     (when (or swank-clojure-binary swank-clojure-classpath)
       (add-to-list 'slime-lisp-implementations
                    `(clojure ,(swank-clojure-cmd) :init swank-clojure-init) t))
     (add-hook 'slime-indentation-update-hooks 'swank-clojure-update-indentation)
     (add-hook 'slime-repl-mode-hook 'swank-clojure-slime-repl-modify-syntax t)
     (add-hook 'clojure-mode-hook 'swank-clojure-slime-mode-hook t)))

;; (defmacro swank-clojure-config (&rest body)
;;   `(eval-after-load "swank-clojure"
;;      '(progn
;;         ,@body)))

(slime-setup '(slime-fancy))

;; I don't have trouble connecting from Emacs. I just added
;; (setq swank-clojure-extra-vm-args (list "-
;; Dcom.sun.management.jmxremote=true" )
;;       to my clojure swank configuration.

;;;

;; (defun populate-extra-cp (dir)
;;   (setq swank-clojure-extra-classpaths
;; 	(append swank-clojure-extra-classpaths
;; 		(split-string (shell-command-to-string
;; 			       (format "ack -u -g 'jar$' %s" dir))))))
;; (populate-extra-cp "/home/dwa/.jars/")

(defslime clojure)

;;; ----------------------------------------------------------------- [the end]
