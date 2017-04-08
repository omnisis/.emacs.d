

(defun ensime-edit-definition-with-fallback ()
  "Variant of `ensime-edit-definition' with ctags if ENSIME is not available."
  (interactive)
  (unless (and (ensime-connection-or-nil)
               (ensime-edit-definition))
    (projectile-find-tag)))

(defun scala-mode-newline-comments ()
  "Custom newline appropriate for `scala-mode'."
  ;; shouldn't this be in a post-insert hook?
  (interactive)
  (newline-and-indent)
  (scala-indent:insert-asterisk-on-multiline-comment))


(bind-key "RET" 'scala-mode-newline-comments scala-mode-map)
;; binding to quickly launch ENSIME from scala mode ..
(bind-key "C-c C-e" 'ensime scala-mode-map)

(bind-key "M-." 'ensime-edit-definition-with-fallback ensime-mode-map)
(bind-key [f8] 'ensime-sbt-do-compile ensime-mode-map)

;; bind key in both scala/ensime to switch between code/REPL
(bind-key [f9] 'ensime-sbt-switch ensime-mode-map)
(add-hook 'sbt-mode-hook (lambda ()
                           (local-set-key [f9] 'switch-to-prev-buffer)))

(message "Loading awesome Scala customizations ...")
(provide 'scala-support)
