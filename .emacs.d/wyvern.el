(eval-when-compile (require 'color-theme))

;; theme format
;;([FUNCTION] FRAME-PARAMETERS VARIABLE-SETTINGS FACE-DEFINITIONS)

(defun color-theme-wyvern ()
  "A color theme that tones down certain mad color defaults"
  (interactive)
  (color-theme-install
   '(color-theme-wyvern
     ;; frame-parameters
     ()
     ;; variable-settings
     ((hl-line-face . wyvern-edit-background)
      (highlight . wyvern-edit-background)
      (ibuffer-deletion-face . wyvern-warning)
;;      (font-lock-warning-face . wyvern-warning)
)

     ;; face-definitions
     (wyvern-edit-background ((t (:background "Grey95"))))
     (wyvern-warning ((t (:foreground "red" :weight normal))))

     (font-lock-warning-face ((t (:foreground "red" :weight normal))))
     ;;     (moccur-edit-face ((t (:inherit wyvern-edit-background))))
     (moccur-edit-face ((t (:background "Grey95" :weight normal))))

     (mode-line-inactive ((t (:background "gray84" :foreground "gray58"
					  :box (:color "gray84" :line-width 0)))))
     (mode-line ((t (:background "#88b090" :foreground "red38"
				 :box (:color "#88b090" :line-width 0))))))))

(defalias 'wyvern #'color-theme-wyvern)
(provide 'wyvern)

;; the end