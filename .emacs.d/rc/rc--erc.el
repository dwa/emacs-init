;;; Time-stamp: <2014-04-15 17:59:27 dwa>

;;; Code:

(require 'tls)

(defun erc-no-socks ()
  (interactive)
  (setq erc-server-connect-function 'open-network-stream)
  (erc))

(defun erc-using-socks ()
  (interactive)
  (setq erc-server-connect-function 'socks-open-network-stream)
  (erc))


;(add-to-list 'erc-modules 'spelling)
;; (setq erc-spelling-dictionaries '(("irc.freenode.net" "english")
;; 				  ("irc.oftc.net" "english")))

(require 'erc-services)
(erc-services-mode 1)

(setq erc-prompt-for-nickserv-password nil)

;(setq erc-join-buffer 'frame)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT")
      erc-track-exclude-server-buffer t)

(require 'erc-match)
;'("\\[[[:digit:]][[:digit:]]:[[:digit:]][[:digit:]]:[[:digit:]][[:digit:]]\\]" . erc-timestamp-face)

;; on freenode:
;(setq erc-default-port 7000)


;(require 'erc-autojoin)
(erc-autojoin-mode 1)
(setq erc-autojoin-channels-alist
      '(("admin" "admin")
	("freenode.*"
	 "#emacs"
         "#python"
         "#ipython"
         "#fabric"
;         "#pypy"
	 "#R"
	 "##pentaho"
	 "##saiku"
         "#hy"
         "#apache-kafka"
         "##whoosh"
         "#kivy"
         "#databrewery"
         "#discoproject"
         "#rethinkdb"
         "#boto"
         "#juju"
         "#maas"
         )))

(setq erc-fill-column 79)
(erc-scrolltobottom-mode 1)

(add-to-list 'erc-frame-alist '(width . 80))
(add-to-list 'erc-frame-alist '(height . 37))

(require 'erc-list-old)

(eval-after-load 'erc-track
  '(progn
     (defun erc-bar-update-overlay ()
       "Update the overlay for current buffer, based on the content of
erc-modified-channels-alist. Should be executed on window change, "
       (interactive)
	 (let* ((info (assq (current-buffer) erc-modified-channels-alist))
		(count (cadr info)))
	   (if (and info (> count erc-bar-threshold))
	       (move-overlay erc-bar-overlay
			     (line-beginning-position (- count))
			     (line-end-position (- count))
			     (current-buffer))
	     (delete-overlay erc-bar-overlay))))

     (defvar erc-bar-threshold 1
       "Display bar when there are more than erc-bar-threshold unread messages")
     (defvar erc-bar-overlay nil
       "Overlay used to set bar")
     (setq erc-bar-overlay (make-overlay 0 0))
     (overlay-put erc-bar-overlay 'face '(:underline "gray15"))
     ;;put the hook before erc-modified-channels-update
     (defadvice erc-track-mode (after erc-bar-setup-hook
				      (&rest args) activate)
       ;;remove and add, so we know it's in the first place
       (remove-hook 'window-configuration-change-hook 'erc-bar-update-overlay)
       (add-hook 'window-configuration-change-hook 'erc-bar-update-overlay))
     (add-hook 'erc-send-completed-hook (lambda (str)
					  (erc-bar-update-overlay)))))
(require 'erc-track)

;(require 'erc-auto)


;; http://www.bestinclass.dk/index.php/2010/03/approaching-productivity/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+bestinclass-the-blog+%28Best+in+Class+-+The+Blog%29

;; Only track my nick(s)
(defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
  (if (erc-query-buffer-p)
      (setq ad-return-value (intern "erc-current-nick-face"))
    ad-do-it))

(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))

;; Use libnotify

(defun clean-message (s)
  (setq s (replace-regexp-in-string
           "'" "&apos;" (replace-regexp-in-string
                         "\"" "&quot;" (replace-regexp-in-string
                                        "&" "&" (replace-regexp-in-string
                                                 "<" "&lt;" (replace-regexp-in-string
                                                             ">" "&gt;" s)))))))

(defun call-libnotify (matched-type nick msg)
  (let* ((cmsg  (split-string (clean-message msg)))
	 (nick   (first (split-string nick "!")))
	 (msg    (mapconcat 'identity (rest cmsg) " ")))
    (shell-command-to-string
     (format "notify-send -u critical '%s says:' '%s'" nick msg))))

(add-hook 'erc-text-matched-hook 'call-libnotify)

(defun erc-freenode ()
  "Start ERC on the secure freenode server"
  (interactive)
  (require 'secrets  "~/.secrets.d/secrets.el.gpg")
  (setq erc-keywords (cons '("\\[[0-2][0-9]:[0-9][0-9]:[0-9][0-9]\\]" . erc-timestamp-face)
                           erc-nick))
  (erc-tls :server "irc.freenode.net" :port 7000 :nick (car erc-nick)))


(defadvice erc-nickserv-call-identify-function (around advice-erc-temp-authinfo activate)
  "load irc server data from `authinfo' for authentication only, then forget it."
  ;; (message "pws: %S" erc-nickserv-passwords)
  (let* ((nick (car (ad-get-args 0)))
         (auth-info (auth-source-search :host (symbol-name (erc-network))
                                        :type 'netrc :max 1
                                        :user nick
                                        :port "6667"))
         (erc-nickserv-passwords
          `((src ,(cons nick (funcall (car auth-info)))))))
    ad-do-it))

;;; ------------------------------------------------------------------ [the end]
