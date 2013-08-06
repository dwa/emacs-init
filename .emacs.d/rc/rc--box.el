
;; http://superuser.com/questions/11008/how-do-i-find-out-what-version-of-linux-im-running
;;
;; /etc/issue
;; /etc/lsb-release
;; /etc/gentoo-release

(defun linux-distribution-name ()
  (interactive)
  (let ((lsb-release "/etc/lsb-release"))
    (if (file-exists-p lsb-release)
        (intern (remove (string-to-char "\n")
                        (shell-command-to-string (concat "gawk 'BEGIN { FS=\"=\" } $1 ~ /DISTRIB_ID/ { print $2; }' "
                                                         lsb-release))))
      'gnu/linux)))

(require 'cl)

(case (linux-distribution-name)
  ((Debian Ubuntu) (load "/etc/emacs/site-start.el"))
  (Gentoo (load "/usr/share/emacs/site-lisp/site-gentoo"))
  (t (message "No idea which site file to load")))

(defun tmux-update-env ()
  (interactive)
  (let (keyval)
    (dolist (i (split-string (shell-command-to-string
                              "tmux show-environment|egrep -v '^-'")
                             "[\n]"))
      (setf keyval (split-string i "[=]"))
      (setenv (first keyval) (second keyval)))))





;;; the end
