;; better tags support
(use-package etags-select
  :commands etags-select-find-tag
  :demand
  :ensure t)

;; undo tree == comprehensible undo history
(use-package undo-tree
  :ensure t
    :demand
    :diminish undo-tree-mode
    :config (global-undo-tree-mode)
    :bind ("s-/" . undo-tree-visualize))

;; git integration
(use-package magit
  :demand
  :ensure t)

(message "Loaded Config Layer :: MISC")
(provide 'misc)

