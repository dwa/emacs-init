;;; Time-stamp: <2013-04-14 00:25:05 dwa>


;;; Code:

(defun-maybe characterp (form)
  (numberp form))

(eval-after-load "mime-edit"
  (quote (setq mime-file-types
               (append '(
                         ("\\.pdf$" "application" "pdf"
                          nil "base64" "attachment"
                          (("filename" . file)))
                         ("\\.sxw$" "application" "vnd.sun.xml.writer"
                          nil "base64" "attachment"
                          (("filename" . file)))
                         ("\\.sxc$" "application" "vnd.sun.xml.calc"
                          nil "base64" "attachment"
                          (("filename" . file)))
                         ("\\.xls$" "application" "vnd.ms-excel"
                          nil "base64" "attachment"
                          (("filename" . file)))

			 ("\\.lisp$" "application" "octet-stream"
			  (("type" . "common-lisp")))

			  ("\\.cl$" "application" "octet-stream"
			   (("type" . "common-lisp")))

			 ("\\.java$" "application" "octet-stream"
			  (("type" . "java"))
			  "7bit" "attachment"
			  (("filename" . file)))
                         )
                       mime-file-types))
         ))


;; NOTE: If I'm going back to WL, enable this:
;; (autoload 'wl-user-agent-compose "wl-draft" nil t)
;; (if (boundp 'mail-user-agent)
;;     (setq mail-user-agent 'wl-user-agent))
;; (if (fboundp 'define-mail-user-agent)
;;     (define-mail-user-agent
;;       'wl-user-agent
;;       'wl-user-agent-compose
;;       'wl-draft-send
;;       'wl-draft-kill
;;       'mail-send-hook))

;;(setq wl-folders-file "~/.emacs.d/wl/wl.folders")
(setq wl-init-file "~/.emacs.d/wl/wl-init.el")

(setq wl-folders-file "~/.emacs.d/wl/wyvern.folders")
;(setq wl-draft-folder "+draft")

(autoload 'elmo-split "elmo-split" "Split messages on the folder." t)


(add-hook 'wl-draft-mode-hook 'turn-on-flyspell)
;(add-hook 'wl-draft-mode-hook 'turn-on-auto-fill)
(add-hook 'wl-draft-mode-hook 'visual-line-mode)


(defun mail-to-address-at-point ()
;; Based on a defun by Kevin Rodgers <kevinr@ihs.com>
  "*Edit a new mail message to the address at point."
  (interactive)
  (let ((url-at-point (substring (thing-at-point 'url) 7)))
    (if (string-match email-regexp url-at-point)
        (compose-mail url-at-point nil nil nil 'switch-to-buffer-other-frame)
      (message "Bad email address"))))

(global-set-key (kbd "<f12>") 'mail-to-address-at-point)

;;; ----------------------------------------------------------------- [the end]
