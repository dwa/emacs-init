;;; Time-stamp: <2015-09-14 21:16:12 davidwallin>
;;; Code:

(use-package epa
  :init
  (setq epa-file-cache-passphrase-for-symmetric-encryption t))

(use-package epg
  :init
  (setq epg-user-id "dwa@havanaclub.org"))

;;; ----------------------------------------------------------------- [the end]
