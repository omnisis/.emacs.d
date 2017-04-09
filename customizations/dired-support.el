(require 'use-package)
(require 'guide-key)

;; dired-related pkgs and hacks ...
(use-package dired+
  :ensure t
  :demand)

(use-package dired-sort 
  :ensure t
  :demand)



;; local mode guide-key setup for dired mode ...
(defun myemacs/conf-dired-guidekey ()
  (guide-key/add-local-guide-key-sequence "%"))
(add-hook 'dired-mode-hook 'myemacs/conf-dired-guidekey)

;; dired one time config ...  
(eval-after-load 'dired 
  '(progn
     (when (fboundp 'global-dired-hide-details-mode)
       (global-dired-hide-details-mode -1))
     
     ;; when issuing a recursive delete only ask about top-leve but assume 'Y' for subdirs
     (setq dired-recursive-deletes 'top)))

(provide 'dired-support)
