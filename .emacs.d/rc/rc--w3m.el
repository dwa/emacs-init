;;; Time-stamp: <2013-04-14 00:25:06 dwa>


;;
;; this is a hack to get w3m working under emacs 23 :
;; (when (= 23 emacs-major-version)
;;   (require 'w3m-e21)
;;   (provide 'w3m-e23))

(setq w3m-use-title-buffer-name t)

(setq w3m-goto-article-function 'browse-url)

(setq w3m-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-input-coding-system 'utf-8
      w3m-output-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)


;;; ------------------------------------------------------------------ [the end]
