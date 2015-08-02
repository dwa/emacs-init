;;; Time-stamp: <2015-08-02 02:32:27 davidwallin>
;;; Code:

;;
;; disable the tool-bar
(if (featurep 'tool-bar)
    (tool-bar-mode -1))

(cond ((eq system-type 'darwin)
       ;; (add-to-list 'default-frame-alist
       ;;              ;; '(font . "-apple-monaco-medium-r-normal--10-100-72-72-m-100-mac-roman"))
       ;;              '(font . "-*-Source Code Pro-normal-normal-normal-*-12-*-*-*-*-*-*"))
       (setq mac-allow-anti-aliasing t)
       (setenv "DISPLAY" ":0.0"))
      ((eq system-type 'gnu/linux)
       ;; (if (< emacs-major-version 23)
       ;;     (add-to-list 'default-frame-alist '(font . "fixed"))
       ;;   (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-9"))
       (add-to-list 'default-frame-alist '(height . 60))))
                                        ; )

;;  (add-to-list 'default-frame-alist '(font . "Source Code Pro-9"))
(add-to-list 'default-frame-alist '(font . "Source Code Pro-12"))
(add-to-list 'default-frame-alist '(height . 50))
(setq font-use-system-font t)

(add-to-list 'default-frame-alist '(width . 90))
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))

(set-scroll-bar-mode nil)

(setq initial-frame-alist default-frame-alist)

(use-package color-theme-solarized
  :init
  (use-package color-theme)
  :config
  (if (daemonp)
      (add-hook 'after-make-frame-functions
                (lambda (frame)
                  (load-theme 'solarized t)
                  (if (display-graphic-p frame)
                      (enable-theme 'solarized)
                                        ;                  (disable-theme 'solarized)
                    )))
    (load-theme 'solarized t))
  :ensure t)

(setq view-remove-frame-by-deleting t)

;; font lock
(cond ((fboundp 'global-font-lock-mode)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)))

;;; ----------------------------------------------------------------- [the end]
