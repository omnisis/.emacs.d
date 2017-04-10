;; make sure org is latest available
(use-package org 
  :ensure t)

;; Backend for org-mode that exports to github-flavored Markdown
(use-package ox-gfm
  :ensure t
  :demand
  :config
  (require 'ox-gfm nil t))


(provide 'orgmode-support)
