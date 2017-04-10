(use-package which-key
  :ensure t
  :demand
  :config
  (which-key-mode)
  (which-key-setup-minibuffer)
  ;; how long to wait b4 displaying keyhelp
  (setq which-key-idle-delay 0.50))

(provide 'whichkey-support)
