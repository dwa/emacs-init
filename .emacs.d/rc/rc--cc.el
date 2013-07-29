;;; Time-stamp: <2013-07-30 01:02:01 dwa>


;;; Code:

;; from EmacsWiki: http://www.emacswiki.org/cgi-bin/wiki/ModeCompile

(setq compilation-finish-functions 'compile-autoclose)
(defun compile-autoclose (buffer string)
  (cond ((string-match "finished" string)
	 (message "Build maybe successful: closing window.")
	 (bury-buffer buffer)
	 (replace-buffer-in-windows "*compilation*"))
	(t
	 (message "Compilation exited abnormally: %s" string))))


(add-to-list 'auto-mode-alist '("\\.cxxtest$" . c++-mode))

;;; ----------------------------------------------------------------- [the end]
