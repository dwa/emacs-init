;;;###autoload
(defun bbdb-complete-name (&optional start-pos)
  "Complete the user full-name or net-address before point (up to the
preceeding newline, colon, or comma, or the value of START-POS).  If
what has been typed is unique, insert an entry of the form \"User Name
<net-addr>\" (although see documentation for
bbdb-dwim-net-address-allow-redundancy).  If it is a valid completion
but not unique, a list of completions is displayed.

If the completion is done and `bbdb-complete-name-allow-cycling' is
true then cycle through the nets for the matching record.

When called with a prefix arg then display a list of all nets.

Completion behaviour can be controlled with `bbdb-completion-type'."
  (interactive)

  (let* ((end (point))
         (beg (or start-pos
                  (save-excursion
                    (re-search-backward "\\(\\`\\|[\n:,]\\)[ \t]*")
                    (goto-char (match-end 0))
                    (point))))
         (orig (buffer-substring beg end))
         (typed (downcase orig))
         (pattern (bbdb-string-trim typed))
         (ht (bbdb-hashtable))
         ;; make a list of possible completion strings
         ;; (all-the-completions), and a flag to indicate if there's a
         ;; single matching record or not (only-one-p)
         (only-one-p t)
         (all-the-completions nil)
         (pred
          (lambda (sym)
            (when (bbdb-completion-predicate sym)
              (if (and only-one-p
                       all-the-completions
                       (or
                        ;; not sure about this. more than one record
                        ;; attached to the symbol? does that happen?
                        (> (length (symbol-value sym)) 1)
                        ;; this is the doozy, though. multiple syms
                        ;; which all match the same record
                        (delete t (mapcar (lambda(x)
                                            (equal (symbol-value x)
                                                   (symbol-value sym)))
                                          all-the-completions))))
                  (setq only-one-p nil))
              (if (not (memq sym all-the-completions))
                  (setq all-the-completions (cons sym all-the-completions))))))
         (completion (progn (all-completions pattern ht pred) (try-completion pattern ht)))
         (exact-match (eq completion t)))

    (cond
     ;; No matches found OR you're trying completion on an
     ;; already-completed record. In the latter case, we might have to
     ;; cycle through the nets for that record.
     ((or (null completion)
          (and bbdb-complete-name-allow-cycling
               exact-match ;; which is a net of the record
               (member orig
                       (bbdb-record-net
                        (car (symbol-value (intern-soft pattern ht)))))))
      ;; Clean up the completion buffer, if it exists
      (bbdb-complete-name-cleanup)
      ;; Check for cycling
      (or (catch 'bbdb-cycling-exit
            ;; jump straight out if we're not cycling
            (or bbdb-complete-name-allow-cycling
                (throw 'bbdb-cycling-exit nil))

            ;; find the record we're working on.
            (let* ((addr (funcall bbdb-extract-address-components-func orig))
                   (rec
                    (if (listp addr)
                        ;; for now, we're ignoring the case where this
                        ;; returns more than one record. Ideally, the
                        ;; last expansion would be stored in a
                        ;; buffer-local variable, perhaps.
                        (car (bbdb-search-intertwingle (caar addr)
                                                       (cadar addr)))
                      nil)))
              (or rec
                  (throw 'bbdb-cycling-exit nil))

              (if current-prefix-arg
                  ;; use completion buffer
                  (let ((standard-output (get-buffer-create "*Completions*")))
                    ;; a previously existing buffer has to be cleaned first
                    (save-excursion (set-buffer standard-output)
                                    (setq buffer-read-only nil)
                                    (erase-buffer))
                    (display-completion-list
                     (mapcar (lambda (n) (bbdb-dwim-net-address rec n))
                             (bbdb-record-net rec)))
                    (delete-region beg end)
                    (switch-to-buffer standard-output))
                ;; use next address
                (let* ((addrs (bbdb-record-net rec))
                       (this-addr (or (cadr (member (car (cdar addr)) addrs))
                                      (nth 0 addrs))))
                  (if (= (length addrs) 1)
                      ;; no alternatives. don't signal an error.
                      (throw 'bbdb-cycling-exit t)
                    ;; replace with new mail address
                    (delete-region beg end)
                    (insert (bbdb-dwim-net-address rec this-addr))
                    (run-hooks 'bbdb-complete-name-hooks)
                    (throw 'bbdb-cycling-exit t))))))

          ;; FALL THROUGH
          ;; Check mail aliases
;          (if (and bbdb-expand-mail-aliases (expand-abbrev))
;	  ()
          (if (and bbdb-expand-mail-aliases (mail-abbrev-complete-alias))
              (progn (delete-region beg end) 
		     (mail-abbrev-insert-alias pattern))
            (when bbdb-complete-name-hooks
              (message "completion for \"%s\" unfound." pattern)
              (ding)))));; no matches, sorry!

     ;; Match for a single record. If cycling is enabled then we don't
     ;; care too much about the exact-match part.
     ((and only-one-p (or exact-match bbdb-complete-name-allow-cycling))
      (let* ((sym (if exact-match (intern-soft pattern ht) (car all-the-completions)))
             (recs (symbol-value sym))
             the-net match-recs lst primary matched)

        (while recs
          (when (bbdb-record-net (car recs))

            ;; Did we match on name?
            (let ((b-r-name (or (bbdb-record-name (car recs)) "")))
              (if (string= pattern
                           (substring (downcase b-r-name) 0
                                      (min (length b-r-name)
                                           (length pattern))))
                  (setq match-recs (cons (car recs) match-recs)
                        matched t)))

            ;; Did we match on aka?
            (when (not matched)
              (setq lst (bbdb-record-aka (car recs)))
              (while lst
                (if (string= pattern (substring (downcase (car lst)) 0
                                                (min (length (downcase
                                                              (car
                                                               lst)))
                                                     (length pattern))))
                    (setq match-recs (append match-recs (list (car recs)))
                          matched t
                          lst '())
                  (setq lst (cdr lst)))))

            ;; Name didn't match name so check net matching
            (when (not matched)
              (setq lst (bbdb-record-net (car recs)))
              (setq primary t) ;; primary wins over secondary...
              (while lst
                (if (string= pattern (substring (downcase (car lst))
                                                0 (min (length
                                                        (downcase (car
                                                                   lst)))
                                                       (length pattern))))
                    (setq the-net (car lst)
                          lst     nil
                          match-recs
                          (if primary (cons (car recs) match-recs)
                            (append match-recs (list (car recs))))))
                (setq lst     (cdr lst)
                      primary nil))))

          ;; loop to next rec
          (setq recs    (cdr recs)
                matched nil))

        (unless match-recs
          (error "only exact matching record unhas net field"))

        ;; now replace the text with the expansion
        (delete-region beg end)
        (insert (bbdb-dwim-net-address (car match-recs) the-net))

        ;; if we're past fill-column, wrap at the previous comma.
        (if (and
             (bbdb-auto-fill-function)
             (>= (current-column) fill-column))
            (let ((p (point))
                  bol)
              (save-excursion
                (beginning-of-line)
                (setq bol (point))
                (goto-char p)
                (if (search-backward "," bol t)
                    (progn
                      (forward-char 1)
                      (insert "\n   "))))))

        ;; Update the *BBDB* buffer if desired.
        (if bbdb-completion-display-record
            (let ((bbdb-gag-messages t))
              (bbdb-pop-up-bbdb-buffer)
              (bbdb-display-records-1 match-recs t)))
        (bbdb-complete-name-cleanup)

        ;; call the exact-completion hook
        (run-hooks 'bbdb-complete-name-hooks)))

     ;; Partial match
     ;; note, we can't use the trimmed version of the pattern here or
     ;; we'll recurse infinitely on e.g. common first names
     ((and (stringp completion) (not (string= typed completion)))
      (delete-region beg end)
      (insert completion)
      (setq end (point))
      (let ((last "")
            (bbdb-complete-name-allow-cycling nil))
        (while (and (stringp completion)
                    (not (string= completion last))
                    (setq last completion
                          pattern (downcase orig)
                          completion (progn (all-completions pattern ht pred) (try-completion pattern ht))))
          (if (stringp completion)
              (progn (delete-region beg end)
                     (insert completion))))
        (bbdb-complete-name beg)))

     ;; Exact match, but more than one record
     (t
      (or (eq (selected-window) (minibuffer-window))
          (message "Making completion list..."))

      (let (dwim-completions
            uniq nets net name akas)
        ;; Now collect all the dwim-addresses for each completion, but only
        ;; once for each record!  Add it if the net is part of the completions
        (bbdb-mapc
         (lambda (sym)
           (bbdb-mapc
            (lambda (rec)
              (when (not (member rec uniq))
                (setq uniq (cons rec uniq)
                      nets (bbdb-record-net rec)
                      name (downcase (or (bbdb-record-name rec) ""))
                      akas (mapcar 'downcase (bbdb-record-aka rec)))
                (while nets
                  (setq net (car nets))
                  (when (cond
                         ;; primary
                         ((and (member bbdb-completion-type
                                       '(primary primary-or-name))
                               (member (intern-soft (downcase net) ht)
                                       all-the-completions))
                          (setq nets nil)
                          t)
                         ;; name
                         ((and name (member bbdb-completion-type
                                            '(nil name primary-or-name))
                               (let ((cname (symbol-name sym)))
                                 (or (string= cname name)
                                     (member cname akas))))
                          (setq name nil)
                          t)
                         ;; net
                         ((and (member bbdb-completion-type
                                       '(nil net))
                               (member (intern-soft (downcase net) ht)
                                       all-the-completions)))
                         ;; (name-or-)primary
                         ((and (member bbdb-completion-type
                                       '(name-or-primary))
                               (let ((cname (symbol-name sym)))
                                 (or (string= cname name)
                                     (member cname akas))))
                          (setq nets nil)
                          t)
                         )
                    (setq dwim-completions
                          (cons (bbdb-dwim-net-address rec net)
                                dwim-completions))
                    (if exact-match (setq nets nil)))
                  (setq nets (cdr nets)))))
            (symbol-value sym)))
         all-the-completions)

        ;; if, after all that, we've only got one matching record...
        (if (and dwim-completions (null (cdr dwim-completions)))
            (progn
              (delete-region beg end)
              (insert (car dwim-completions))
              (message ""))
          ;; otherwise, pop up a completions window
          (if (not (get-buffer-window "*Completions*"))
              (setq bbdb-complete-name-saved-window-config
                    (current-window-configuration)))
          (let ((arg (list (current-buffer)
                           (set-marker (make-marker) beg)
                           (set-marker (make-marker) end))))
            (with-output-to-temp-buffer "*Completions*"
              (bbdb-display-completion-list
               dwim-completions
               'bbdb-complete-clicked-name
               arg)))
          (or (eq (selected-window) (minibuffer-window))
              (message "Making completion list...done"))))))))
