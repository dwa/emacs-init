;;; Time-stamp: <2013-04-14 00:25:07 dwa>


;;; Code:

;; (require 'bbdb)
(require 'bbdb-snarf)
;; (bbdb-initialize)

(eval-after-load "gnus"
  '(bbdb-insinuate-gnus))

;; enable pop-ups
(setq bbdb-use-pop-up nil)

;; auto collection
(setq bbdb/mail-auto-create-p nil)

;; exceptional folders against auto collection
(setq bbdb-wl-ignore-folder-regexp "^@")
(setq signature-use-bbdb t)
(setq bbdb-north-american-phone-numbers-p nil)
;; automatically add mailing list fields
(add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)
(setq bbdb-auto-notes-alist '(("X-ML-Name" (".*$" ML 0))))

(setq bbdb-complete-name-allow-cycling t)
(setq bbdb-expand-mail-aliases t)
(setq bbdb-use-alternate-names nil)
(setq bbdb-quiet-about-name-mismatches t)
(setq bbdb-display-layout 'one-line)


(eval-after-load "bbdb-com"
  '(load "bbdb-patches"))

;;moy-bbdb notices outgoing adresses
(autoload 'bbdb/send-hook "moy-bbdb"
  "Function to be added to `message-send-hook' to notice records when sending messages" t)
;;(add-hook 'message-send-hook 'bbdb/send-hook) ; If you use Gnus

;;To have this automatically add outgoing addresses, use this.
;;(setq bbdb/send-auto-create-p t)
;;(setq bbdb/send-prompt-for-create-p nil)

;;To query whether to add outgoing messages, use this.
;; (setq bbdb/send-auto-create-p 'prompt)

;;; ----------------------------------------------------------------- [the end]
