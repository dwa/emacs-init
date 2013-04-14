;;; Time-stamp: <2013-04-14 12:03:56 dwa>
;;;
;;; Code:

;;
;; use swedish keyboard layout
(setq default-input-method "swedish-keyboard")
                                        ;(set-input-method "swedish-keyboard")

;;
;; leave it off for now:
(inactivate-input-method)

(defun my-toggle-im ()
  (interactive)


  (if (string= "english" ispell-local-dictionary)
      (ispell-change-dictionary "svenska")
    (ispell-change-dictionary "english"))
  (toggle-input-method)
  (toggle-bracket-keymapping))


;;
;; toggle swedish keyboard
(global-set-key [f7] 'my-toggle-im)
