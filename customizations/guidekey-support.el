(defun myemacs/projectile-mode-hook-fn ()
  (guide-key/add-local-guide-key-sequence "C-c p"))

(use-package guide-key 
  :ensure t
  :demand
  :config 
  (require 'guide-key)
  (setq guide-key/guide-key-sequence '("C-x r" "C-x 4"))
  (setq guide-key/idle-delay 0.1)
  (setq guide-key/popup-window-position 'bottom)
  (setq guide-key/text-scale-amount 1.5)
  (add-hook 'projectile-mode-hook #'myemacs/projectile-mode-hook-fn)
  (guide-key-mode 1))

(provide 'guidekey-support)
