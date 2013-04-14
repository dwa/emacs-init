;;; my-nethack.el - 
;;; 
;;;
;;; Time-stamp: <2012-08-21 12:43:02 dwa>
;;;
;;; copyright (c) 2007. all rights reserved.
;;; David Wallin <dwa@havanaclub.org>

;;; Code:

(add-to-list 'load-path "~/.emacs.d/elisp/nethack-el/")
(autoload 'nethack "nethack" "Play Nethack." t)
(setq nethack-program "/usr/games/nethack")

;; (defface nethack-map-tile-face 
;;   `((((type tty)) 
;;      nil)
;;     (t (:background "black"))
;; ;;     (t (:font "6x10"))
;;     )
;;   "Map face with height less than the tile size (16 pixels)."
;;   :group 'nethack-faces)

(setq nethack-prompt-style t)
;; (setq nethack-prompt-style :map)
(setq nethack-status-style :header-line
      nethack-status-header-line-format "s d c i W C h p a e A f")
(setq nethack-message-style :map)

;;
;; some bells and whistles:

(require 'nethack-example)
(add-hook 'nethack-add-menu-hook 'nethack-x-highlight-option)
(add-hook 'nethack-status-attribute-change-functions 'nethack-x-warn-low-hp)
(add-hook 'nethack-before-print-message-hook 'nethack-x-timestamp-message)



(eval-after-load "nethack"
  '(progn
     (define-key nh-map-mode-map (kbd "<kp-1>") 'nethack-command-southwest)
     (define-key nh-map-mode-map (kbd "<kp-2>") 'nethack-command-south)
     (define-key nh-map-mode-map (kbd "<kp-3>") 'nethack-command-southeast)
     (define-key nh-map-mode-map (kbd "<kp-4>") 'nethack-command-west)
     (define-key nh-map-mode-map (kbd "<kp-5>") 'nethack-command-rest-one-move)
     (define-key nh-map-mode-map (kbd "<kp-6>") 'nethack-command-east)
     (define-key nh-map-mode-map (kbd "<kp-7>") 'nethack-command-northwest)
     (define-key nh-map-mode-map (kbd "<kp-8>") 'nethack-command-north)
     (define-key nh-map-mode-map (kbd "<kp-9>") 'nethack-command-northeast)     
     (define-key nh-map-mode-map (kbd "C-<kp-1>")
       'nethack-command-southwest-until-near)
     (define-key nh-map-mode-map (kbd "C-<kp-2>")
       'nethack-command-south-until-near)
     (define-key nh-map-mode-map (kbd "C-<kp-3>")
       'nethack-command-southeast-until-near)
     (define-key nh-map-mode-map (kbd "C-<kp-4>")
       'nethack-command-west-until-near)
     (define-key nh-map-mode-map (kbd "C-<kp-6>")
       'nethack-command-east-until-near)
     (define-key nh-map-mode-map (kbd "C-<kp-7>")
       'nethack-command-northwest-until-near)
     (define-key nh-map-mode-map (kbd "C-<kp-8>")
       'nethack-command-north-until-near)
     (define-key nh-map-mode-map (kbd "C-<kp-9>")
       'nethack-command-northeast-until-near)))

;; (add-hook 'nethack-map-mode-hook
;; 	  (lambda ()
;; 	    (hi-lock-mode 1)
;; 	    (highlight-phrase "--more--" 'nethack-red-face)))


;;  (eval-after-load "nethack-compat"
;;    '(progn
;;       (defun my-nh-translate-numpad-ksv (ks)
;; 	(if (= (length ks) 1)
;; 	    (case (aref ks 0)
;; 	      (49 (vector ?b))	    ;; 1
;; 	      (50 (vector ?j))	    ;; 2
;; 	      (51 (vector ?n))	    ;; 3
;; 	      (52 (vector ?h))	    ;; 4
;; 	      (53 (vector ?.))	    ;; 5
;; 	      (54 (vector ?l))	    ;; 6
;; 	      (55 (vector ?y))	    ;; 7
;; 	      (56 (vector ?k))	    ;; 8
;; 	      (57 (vector ?u))	    ;; 9
;; 	      (t ks))
;; 	  ks))

;;       (defun my-nh-read-key-sequence-vector (prompt)
;; 	(case nethack-prompt-style
;; 	  (:map
;; 	   (nh-display-message-in-map prompt nil t)
;; 	   (prog1
;; 	       (my-nh-translate-numpad-ksv (read-key-sequence-vector ""))
;; 	     (nhapi-clear-message)))
;; 	  (t
;; 	   (let ((cursor-in-echo-area t))
;; 	     (my-nh-translate-numpad-ksv (read-key-sequence-vector prompt))))))
      
;;       (defalias 'nh-read-key-sequence-vector
;; 	'my-nh-read-key-sequence-vector)))

;; (defun my-nethack-keybindings ()
;;   (local-set-key (kbd "<kp-1>") 'nethack-command-southwest)
;;   (local-set-key (kbd "<kp-2>") 'nethack-command-south)
;;   (local-set-key (kbd "<kp-3>") 'nethack-command-southeast)
;;   (local-set-key (kbd "<kp-4>") 'nethack-command-west)
;;   (local-set-key (kbd "<kp-5>") 'nethack-command-rest-one-move)
;;   (local-set-key (kbd "<kp-6>") 'nethack-command-east)
;;   (local-set-key (kbd "<kp-7>") 'nethack-command-northwest)
;;   (local-set-key (kbd "<kp-8>") 'nethack-command-north)
;;   (local-set-key (kbd "<kp-9>") 'nethack-command-northeast)
  
;;   (local-set-key (kbd "C-<kp-1>") 'nethack-command-southwest-until-near)
;;   (local-set-key (kbd "C-<kp-2>") 'nethack-command-south-until-near)
;;   (local-set-key (kbd "C-<kp-3>") 'nethack-command-southeast-until-near)
;;   (local-set-key (kbd "C-<kp-4>") 'nethack-command-west-until-near)
  
;;   (local-set-key (kbd "C-<kp-6>") 'nethack-command-east-until-near)
;;   (local-set-key (kbd "C-<kp-7>") 'nethack-command-northwest-until-near)
;;   (local-set-key (kbd "C-<kp-8>") 'nethack-command-north-until-near)
;;   (local-set-key (kbd "C-<kp-9>") 'nethack-command-northeast-until-near))


;;; ----------------------------------------------------------------- [the end]
