;;; Time-stamp: <2013-04-14 00:25:07 dwa>


;;; Code:

;; from EmacsWiki: http://www.emacswiki.org/cgi-bin/wiki/ModeCompile

(setq compilation-finish-functions 'compile-autoclose)
(defun compile-autoclose (buffer string)
  (cond ((string-match "finished" string)
	 (message "Build maybe successful: closing window.")
	 (bury-buffer buffer)
	 (replace-buffer-in-windows "*compilation*"))
	(t
	 (message "Compilation exited abnormally: %s" string))))


;;
;; c-mode-common-hook

(add-hook 'c-mode-common-hook 'my-flymake-keybindings)

;; FIXME: this doesn't look correct; it doesn't solve the actual problem with
;; the .h files (also, no reason why the 'add-to-list's cant be done at the
;; toplevel):
;; (add-hook 'c-mode-hook
;;           (lambda () (when buffer-file-name
;;                        (add-to-list 'flymake-allowed-file-name-masks
;;                                     '("\\.c\\'" flymake-clang-c-init))
;;                        (add-to-list 'flymake-allowed-file-name-masks
;;                                     '("\\.h\\'" flymake-clang-c-init)))))
;; (add-hook 'c++-mode-hook
;;           (lambda () (when buffer-file-name
;;                        (add-to-list 'flymake-allowed-file-name-masks
;;                                     '("\\.cpp\\'" flymake-clang-c++-init))
;;                        (add-to-list 'flymake-allowed-file-name-masks
;;                                     '("\\.cc\\'" flymake-clang-c++-init))
;;                        (add-to-list 'flymake-allowed-file-name-masks
;;                                     '("\\.h\\'" flymake-clang-c++-init)))))


(add-to-list 'flymake-allowed-file-name-masks '("\\.c\\'" flymake-clang-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.cpp\\'" flymake-clang-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.cc\\'" flymake-clang-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.h\\'" flymake-clang-init))

;; from
;; https://github.com/dmacvicar/duncan-emacs-setup :
;;
;; try c-buffer-is-cc-mode : ??

(defun flymake-clang-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name)))
         (clang-cmd (case c-buffer-is-cc-mode
                      (c-mode "clang")
                      (c++-mode "clang++"))))
    (list clang-cmd (list "-fsyntax-only" "-fno-color-diagnostics" local-file))))


;; (defun flymake-clang-c-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "clang" (list "-fsyntax-only" "-fno-color-diagnostics" local-file))))


;; (defun flymake-clang-c++-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "clang++" (list "-fsyntax-only" "-fno-color-diagnostics" local-file))))
;;

(add-to-list 'auto-mode-alist '("\\.cxxtest$" . c++-mode))

;;; ----------------------------------------------------------------- [the end]
