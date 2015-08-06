;;; Time-stamp: <2015-08-06 02:13:47 davidwallin>


;;; Code:

;; (add-hook 'java-mode-hook 'flymake-mode-on)
;; (defun my-java-flymake-init ()
;;   (list "javac" (list (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-with-folder-structure))))

;; (add-to-list 'flymake-allowed-file-name-masks
;;              '("\.java$" my-java-flymake-init flymake-simple-cleanup))


;; emacs-eclim <HERE>

;(setq-mode-local java-mode ac-sources (append '(ac-source-semantic) ac-sources))

;; (unless (getenv "JAVA_HOME")
;;   (setenv "JAVA_HOME" "/usr/lib/jvm/java-7-openjdk-amd64"))

;; (setq ;cedet-java-jdk-root (getenv "JAVA_HOME")
;;       semanticdb-javap-classpath (concat (getenv "JAVA_HOME") "/jre/lib/rt.jar"))

;; (semantic-add-system-include (getenv "JAVA_HOME") 'java-mode)

;; cedet/semantic
(add-hook 'java-mode-hook '(lambda ()
                             ;; use semantic with auto-complete:
                             (add-to-list 'ac-sources 'ac-source-semantic)
                             ))

(add-to-list 'auto-mode-alist '( "\\.params$" . conf-mode)) ;; ECJ param files
