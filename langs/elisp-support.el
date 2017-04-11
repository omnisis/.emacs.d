;; Automatically load paredit when editing a lisp file
;; More at http://www.emacswiki.org/emacs/ParEdit
(use-package paredit 
  :ensure t
  :demand t
  :diminish paredit-mode
  :config
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode)
  :bind (("C-c d" . paredit-forward-down)))

(use-package highlight-parentheses
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'highlight-parentheses-mode)
  (global-highlight-parentheses-mode))

(use-package rainbow-delimiters 
  :ensure t
  :demand t
  :config
  ;(add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)
  ;; rainbows for days!
  (setq global-rainbow-delimiters-mode t))

;; eldoc-mode shows documentation in the minibuffer when writing code
;; http://www.emacswiki.org/emacs/ElDoc
(add-hook 'emacs-lisp-mode-hook #'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook #'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook #'turn-on-eldoc-mode)

(global-set-key (kbd  "C-c C-e") 'eval-buffer)

(message "Loaded awesome ELISP customizations")
(provide 'elisp-support)
