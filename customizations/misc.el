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
  :ensure t
  :bind 
  ("C-x g"  . magit-status))

(defalias 'qrr 'query-replace-regexp-eval)

;; memory is cheap nowadays
;; GC every 20MB that is allocated
(setq gc-cons-threshold 20000000)


(message "Loaded Config Layer :: MISC")
(provide 'misc)

