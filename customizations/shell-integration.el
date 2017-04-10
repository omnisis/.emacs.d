;; emacs execution path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (cons "/usr/local/bin" exec-path))
;;(setq exec-path-from-shell-check-startup-files nil)

;; Sets up exec-path-from shell
;; https://github.com/purcell/exec-path-from-shell
;;(when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize)
;;  (exec-path-from-shell-copy-envs
;;   '("PATH")))

;; Required to handle ANSI color sequences properly
;;(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
;;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(global-set-key [f2] 'shell)
(global-set-key (kbd "C-<f2>") 'ansi-term)

(setq shell-file-name "/bin/bash")
(defun myemacs/shell-mode-hook ()
  ;; native shell is ZSH, this is a workaround
  (setenv "SHELL" "/bin/bash")
  ;; don't allow me to edit the prompt string on accident
  (setq comint-prompt-read-only t) 
  (setq comint-scroll-to-bottom-on-input t)
  (setq comint-scroll-to-bottom-on-output t)
  (setq comint-move-point-for-output t)
)

(add-hook 'shell-mode-hook 'myemacs/shell-mode-hook)

(message "Loaded Config Layer :: SHELL-INTEGRATION")
(provide 'shell-integration)
