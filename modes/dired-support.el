(require 'use-package)

;; dired-related pkgs and hacks ...
(use-package dired+
  :ensure t
  :demand)

(use-package dired-sort 
  :ensure t
  :demand)

;; dired one time config ...  
(eval-after-load 'dired 
  '(progn
     (when (fboundp 'global-dired-hide-details-mode)
       (global-dired-hide-details-mode -1))
     
     ;; if using guide-key install a guide-key sequence
     (if (eq 'guide-key myemacs-keyhelp-backend)
         (add-hook 'dired-mode-hook 
                   (lambda () (guide-key/add-local-guide-key-sequence "%"))))


     ;; when issuing a recursive delete only ask about top-leve but assume 'Y' for subdirs
     (setq dired-recursive-deletes 'top)))

(provide 'dired-support)

(eq 'which-key myemacs-keyhelp-backend)


