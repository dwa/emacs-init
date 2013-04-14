;;; Time-stamp: <2013-04-14 11:53:46 dwa>


;;; Code:

;; these lines enable the use of gnuplot mode
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
(setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))

;; This line binds the function-9 key so that it opens a buffer into
;; gnuplot mode
;  (global-set-key [(f9)] 'gnuplot-make-buffer)

(add-to-list 'special-display-buffer-names '("*gnuplot*" (same-frame . t)))


;;; ----------------------------------------------------------------- [the end]
