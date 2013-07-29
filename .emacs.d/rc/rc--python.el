;;; Time-stamp: <2013-07-30 01:08:03 dwa>


;;; Code:

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-hook 'python-mode-hook 'turn-on-eldoc-mode)
(add-hook 'python-mode-hook 'jedi:setup)
;; (add-hook 'python-mode-hook
;;           #'(lambda ()
;;               (define-key py-mode-map (kbd "M-<tab>") 'auto-complete)
;;               (add-to-list 'ac-sources 'ac-source-ropemacs)))

;; needed for >python-mode-6.0.3-r1
;; this will be fixed in later versions of python-mode (>6.0.5 ?)
(eval-after-load "python-mode"
 '(defvar py-mode-map python-mode-map))

(setq ipython-command "/usr/bin/ipython")
;; problematic with nxml/nxhtml
;;(require 'ipython)
(setq py-python-command-args '( "--colors" "Linux"))

(setq py-shell-switch-buffers-on-execute nil)


;; FIXME: remove since it's not actually used anymore:
(eval-after-load "flymake";; when (load "flymake" t)
  '(progn
     (defun flymake-pylint-init ()
       (let* ((temp-file (flymake-init-create-temp-buffer-copy
                          'flymake-create-temp-inplace))
              (local-file (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
         (list "epylint" (list local-file))))

     ;; disable this for now:
     ;; (add-to-list 'flymake-allowed-file-name-masks
     ;;              '("\\.py\\'" flymake-pylint-init))

     ;; http://stackoverflow.com/questions/1259873/how-can-i-use-emacs-flymake-mode-for-python-with-pyflakes-and-pylint-checking-co
     (defun flymake-pycheckers-init ()
       (let* ((temp-file (flymake-init-create-temp-buffer-copy
                          'flymake-create-temp-inplace))
              (local-file (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
         (list "pycheckers2"  (list local-file))))


     (add-to-list 'flymake-allowed-file-name-masks
                  '("\\.py\\'" flymake-pycheckers-init))))


(defun peRtty-python ()
  (interactive)
  (substitute-patterns-with-unicode
   (list (cons "\\(lambda\\)[[:blank:]]*[^:]+:" 'lambda))))

(add-hook 'python-mode-hook 'peRtty-python)

;; http://pedrokroger.net/2010/07/configuring-emacs-as-a-python-ide-2/
;; make autopair work with single and triple quotes:
(add-hook 'python-mode-hook
          #'(lambda () (push '(?' . ?')
                             (getf autopair-extra-pairs :code))
              (setq autopair-handle-action-fns
                    (list #'autopair-default-handle-action
                          #'autopair-python-triple-quote-action))))

;;; ----------------------------------------------------------------- [the end]
