;;; Time-stamp: <2015-07-21 12:49:47 davidwallin>
;;; Code:

(use-package epa
  :init
  (add-to-list 'special-display-buffer-names '("*Keys*" (same-frame . t)))
  (setq epa-file-cache-passphrase-for-symmetric-encryption t))

(use-package epg
  :init
  (setq epg-user-id "dwa@havanaclub.org"))

;;; ----------------------------------------------------------------- [the end]
