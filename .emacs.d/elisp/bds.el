;;; bds minor mode - for the task reports
;;;
;;; Time-stamp: <2013-04-13 23:01:05 dwa>
;;;
;;; david wallin <dwa@havanaclub.org>
;;;
;;;
;;; add this file in the load-path (in your .emacs). something like:
;;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/"))
;;;
;;; add to your .emacs (you might want to edit the second line):
;;;
;;; (require 'bds)
;;; (setq bds-password-file (expand-file-name "~/bds/.bds-password"))
;;;
;;; where the passwordfile is a file containing "username password" to the bds
;;; website.
;;;
;;; Add something similar to this to the end of your task report:
;;;
;;;   
;;;   %%% Local Variables:
;;;   %%% mode : bds
;;;   %%% bds-task: "BDS-WPT-GE-02.05"
;;;   %%% bds-task-revision:    0
;;;   %%% TeX-master: "BDS-WPT-GE.tex"
;;;   %%% End:

;;;
;;; TODO:
;;; - add variable `upload-taskrep-program'
;;; - In `update-task-revision-p' : show current revision in question
;;; - write `append-history' (search for \end{itemize} and replace ?)
;;;   probably search for \begin{itemize} and add \item after it.
;;;   (make it possible to move back to where you were M-. ?)

(defvar bds-task "foo" "The task report number. Usually on the form \"BDS-WPT-GE-xx.yy\".")
(defvar bds-task-revision 0 "The task report revision.")

(make-variable-buffer-local 'bds-task)
(make-variable-buffer-local 'bds-task-revision)

(put 'bds-task 'safe-local-variable 'stringp)
(put 'bds-task-revision 'safe-local-variable 'integerp)

;; ;;;###autoload(put 'bds-task 'safe-local-variable 'stringp)
;; ;;;###autoload(put 'bds-task-revision 'safe-local-variable 'integerp)

;; FIXME: These don't really belong here (but are convenient) :
(put 'ispell-dictionary 'safe-local-variable 'stringp)
(put 'ispell-personal-dictionary 'safe-local-variable 'stringp)
(put 'TeX-master 'safe-local-variable 'stringp)
(put 'TeX-PDF-mode 'safe-local-variable 'null)


;;
;; update-buffer-local-var-on-file

(defun update-buffer-local-var-on-file (var)
  (let ((regexp (concat "^\\("
			comment-start
			comment-start
			comment-start
			"\\W*"
			(symbol-name var)
			"\\W*"
			":"
			"\\W*"
			"\\)"
			".*$")))

    (save-excursion
      (replace-regexp regexp (concat "\\1"
				     (format "%s" (symbol-value var))
				     "\\2")
		      nil
		      (point-min-marker)
		      (point-max-marker)))))


;;
;; task-report-title

(defun task-report-title ()
  (let ((regexp (concat "^\\(\\\\title{\\).*\\(\\W*\\\\\\\\.*}\\)$")))
    (save-excursion
      (replace-regexp regexp (concat "\\1"
				     bds-task
				     (format ".%s" bds-task-revision)
				     "\\2")
		      nil
		      (point-min-marker)
		      (point-max-marker)))))


;;
;; update-task-revision-p

(defun update-task-revision-p ()
  (interactive)
  (when (y-or-n-p "Incf task revision ?")
    (with-current-buffer (if (and (boundp 'TeX-master) TeX-master)
			     (find-file TeX-master)
			   (current-buffer))
      (incf bds-task-revision)
      (update-buffer-local-var-on-file 'bds-task-revision)
      (task-report-title))))


;;
;; first stab at verx abbrev:

;; (define-abbrev 'TeX-mode-abbrev-table ";verx"
;;       "" 'bds-task-report-verx)

(define-skeleton bds-task-report-verx
  "Insert a version environment (at the right place)" nil
  > "\\subsubsection*{Ver \\#" (format "%s" bds-task-revision) "}" \n
  > "{\\bf Author : " (user-full-name) "}" \n
  > "\\begin{itemize}" \n
  > "\\item " _ \n
  > "\\end{itemize}" \n \n)

;; (setq skeleton-end-hook nil)

;;
;; update-revision-history

(defun update-revision-history ()
  (interactive)
  ;;
  ;; FIXME: set mark at (point) so we can jump back when we want to ??

  (with-current-buffer (if (and (boundp 'TeX-master) TeX-master)
			     (find-file TeX-master)
			   (current-buffer))
    ;; move to Revision History section
    (goto-char (point-min))
    (search-forward "\\subsection{Revision History}")
    (next-line)
    (newline 2)
    (bds-task-report-verx)))


(defvar bds-password-file "foo")

;;
;; bds-mode

(defvar bds-mode-map (make-keymap))

(define-key bds-mode-map (kbd "C-c b r") 'update-task-revision-p)
(define-key bds-mode-map (kbd "C-c b h") 'update-revision-history)
;(define-key bds-mode-map (kbd "C-c b u") 'upload-task-report)


(define-minor-mode bds-mode
  "\\<bds-mode-map>\
Minor mode for editing task reports. Add the following local
variables to the tas report file: `bds-task', `bds-task-revision'
and, if you want to be asked to if you want the revision number
increased when opening the document, the special `eval' should be
set to '(update-task-revision-p)'.  \\{bds-mode-map}"
  nil
  " bds"
  bds-mode-map

(eval-after-load 'tex
    '(progn (add-to-list 'TeX-expand-list
		  (list "%(report)" (lambda ()
				      (if (and (boundp 'TeX-master) TeX-master)
					  (find-file TeX-master))
				      (format "%s.%s.ps"
						       bds-task
						       bds-task-revision))))
	   (add-to-list 'TeX-expand-list
			(list "%(bdspwd)" (lambda () bds-password-file)))

	   (add-to-list 'TeX-command-list
			(list "UploadReport"
			      "xargs -a \"%(bdspwd)\" upload-taskrep %(report)"
			      'TeX-run-command t t :help "Upload Task Report"))

	   (add-to-list 'TeX-command-list
			(list "GenerateReport"
			      "latex %t && dvips %d -o %(report)"
			      'TeX-run-command t t
			      :help "Generate a postscript file with task number and revision appended.")))))


(provide 'bds)

;;; the end
