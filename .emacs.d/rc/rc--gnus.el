;;; Time-stamp: <2012-09-26 23:22:40 dwa>
;;; David Wallin [dwa@havanaclub.org]

;;; Code:

;;source: http://www.emacswiki.org/emacs/GnusNetworkManager

(setq mail-user-agent 'gnus-user-agent)
(add-hook 'message-mode-hook 'turn-on-visual-line-mode)
(add-hook 'message-mode-hook 'turn-off-auto-fill)

(eval-after-load "gnus-art"
  '(setq article-time-units (butlast article-time-units)))

(eval-after-load "starttls"
  '(progn (defalias 'starttls-any-program-available 'starttls-available-p)
          (make-obsolete 'starttls-any-program-available 'starttls-available-p
                         "2011-08-02")))

(add-hook 'gnus-before-startup-hook 'offlineimap)

;; take a look here:
;; http://www.mail-archive.com/info-gnus-english@gnu.org/msg00368.html
;;(defalias 'message-functionp 'functionp)
(autoload 'gnus-alias-determine-identity "gnus-alias" "" t)
(add-hook 'message-setup-hook 'gnus-alias-determine-identity)

(require 'dbus)
(defun nm-is-connected()
  (equal 3 (dbus-get-property
            :system "org.freedesktop.NetworkManager" "/org/freedesktop/NetworkManager"
            "org.freedesktop.NetworkManager" "State")))
(defun switch-to-or-startup-gnus ()
  "Switch to Gnus group buffer if it exists, otherwise start Gnus in plugged or unplugged state,
depending on network status."
  (interactive)
  (if (or (not (fboundp 'gnus-alive-p))
          (not (gnus-alive-p)))
      (if (nm-is-connected)
          (gnus)
        (gnus-unplugged))
    (switch-to-buffer gnus-group-buffer)
    (delete-other-windows)))

(load "mailto-compose-mail")

(eval-after-load "timer"
  '(progn (defalias 'gnus-timer--function 'timer--function)))

;;; ----------------------------------------------------------------- [the end]
