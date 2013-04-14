;;; Time-stamp: <2013-04-14 11:59:09 dwa>


;;; Code:

(when t ;window-system
  ;;
  ;; disable the tool-bar (we don't want to load it just to disable it):
  (if (featurep 'tool-bar)
      (tool-bar-mode -1))

  (cond ((eq system-type 'darwin)
	 (add-to-list 'default-frame-alist
                      ;; '(font . "-apple-monaco-medium-r-normal--10-100-72-72-m-100-mac-roman"))
		      '(font . "-apple-bitstream vera sans mono-medium-r-normal-*-12-*-*-*-*-*-mac-roman"))
	 (setq mac-allow-anti-aliasing nil)
	 (setenv "DISPLAY" ":0.0"))
	((eq system-type 'gnu/linux)
	 (if (< emacs-major-version 23)
	     (add-to-list 'default-frame-alist '(font . "fixed"))
           (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-9"))
           (add-to-list 'default-frame-alist '(height . 60)))))

  (add-to-list 'default-frame-alist '(font . "Source Code Pro-9"))
  (add-to-list 'default-frame-alist '(height . 52))
  (setq font-use-system-font t)

  (add-to-list 'default-frame-alist '(width . 90))
  (add-to-list 'default-frame-alist '(tool-bar-lines . 0))

  (set-scroll-bar-mode 'left)

  (setq initial-frame-alist default-frame-alist))


(setq view-remove-frame-by-deleting t)


;;; -------------------------------------------------------------- [color-theme]

;; (when t ;window-system
;   (require 'wyvern)
;   (wyvern)
;;)

;; (add-to-list 'load-path "~/sw/emacs/emacs-color-theme-solarized")
;; (require 'color-theme-solarized)
;; (color-theme-solarized-light)

;; font lock
(cond ((fboundp 'global-font-lock-mode)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)))

;;; ----------------------------------------------------------------- [the end]
