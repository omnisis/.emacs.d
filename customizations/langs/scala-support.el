;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Scala Language Support
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun myemacs/ensime-edit-definition-with-fallback ()
  "Variant of `ensime-edit-definition' with ctags if ENSIME is not available."
  (interactive)
  (unless (and (ensime-connection-or-nil)
               (ensime-edit-definition))
    (projectile-find-tag)))

(defun myemacs/scala-mode-newline-comments ()
  "Custom newline appropriate for `scala-mode'."
  ;; shouldn't this be in a post-insert hook?
  (interactive)
  (newline-and-indent)
  (scala-indent:insert-asterisk-on-multiline-comment))


(use-package scala-mode 
  :ensure t 
  :pin melpa-stable
  :config
  (guide-key/add-local-guide-key-sequence "C-c C-v")
  (guide-key/add-local-guide-key-sequence "C-c C-c")
  (guide-key/add-local-guide-key-sequence "C-c C-t")
  (guide-key/add-local-guide-key-sequence "C-c C-r")
  (guide-key/add-local-guide-key-sequence "C-c C-b")
  (guide-key/add-local-guide-key-sequence "C-c C-d")
  (guide-key/add-local-guide-key-sequence "C-c C-e")
  :bind 
  (:map scala-mode-map
        ;; quickly launch ensime from a scala buffer
        ("C-c C-e" . ensime)
        ("RET"     . myemacs/scala-mode-newline-comments)))

;; integration with SBT
(use-package sbt-mode 
  :ensure t 
  :pin melpa-stable
  :bind 
  (:map sbt-mode-map
        ;; allows us to get back to scala buffer after switching
        ("<f9>" . switch-to-prev-buffer)))

;; ENSIME: Scale compilation and typchecking support
(use-package ensime 
  :ensure t 
    :pin melpa-stable
    :config 
    (setq ensime-startup-notification nil)
    :bind (:map ensime-mode-map
                ("<f6>"  . ensime-sbt-do-compile)
                ("<f8>"  . ensime-sbt-do-run)
                ("<f9>"  . ensime-sbt-switch)
                ("M-."   . myemacs/ensime-edit-definition-with-fallback)
                ("C-c C-t" . ensime-sbt-do-test-dwim)))


(message "Loading awesome Scala customizations ...")
(provide 'scala-support)
