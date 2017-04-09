

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

(defun myemacs/guidekeys-for-scala-mode()
  "Sets up guidekey support for scala-mode buffers"
  (guide-key/add-local-guide-key-sequence "C-c C-v")
  (guide-key/add-local-guide-key-sequence "C-c C-c")
  (guide-key/add-local-guide-key-sequence "C-c C-t")
  (guide-key/add-local-guide-key-sequence "C-c C-r")
  (guide-key/add-local-guide-key-sequence "C-c C-b")
  (guide-key/add-local-guide-key-sequence "C-c C-d")
  (guide-key/add-local-guide-key-sequence "C-c C-e"))

(defun myemacs/sbt-mode-hook ()
  (local-set-key [f9] 'switch-to-prev-buffer))


(bind-key "RET" 'scala-mode-newline-comments scala-mode-map)
;; binding to quickly launch ENSIME from scala mode ..
(bind-key "C-c C-e" 'ensime scala-mode-map)

(bind-key "M-." 'ensime-edit-definition-with-fallback ensime-mode-map)
(bind-key [f6] 'ensime-sbt-do-compile ensime-mode-map)

;; bind key in both scala/ensime to switch between code/REPL
(bind-key [f8] 'ensime-sbt-switch ensime-mode-map)
(bind-key [f9] 'ensime-sbt-do-run ensime-mode-map)
(bind-key (kbd "C-c C-t") 'ensime-sbt-do-test-dwim ensime-mode-map)
(add-hook 'sbt-mode-hook 'myemacs/sbt-mode-hook)

(add-hook 'scala-mode-hook 'myemacs/guidekeys-for-scala-mode)

(message "Loading awesome Scala customizations ...")
(provide 'scala-support)
