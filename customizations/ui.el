;; These customizations change the way Emacs looks and disable/enable
;; some user interface elements.

;; Turn off menubar at top of frame
(menu-bar-mode 0)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode 0))

;; show line numbers
(global-linum-mode)

;; don't show native OS scrollbars for buffers bc they're redundant
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode 0))

;; load our preferred theme
(load-theme 'darcula t)

;; increate font size for better readability
(set-face-attribute 'default nil :height 140)

;; default startup window dimensions
(setq initial-frame-alist '((top . 0) (left . 0) (width . 150) (height . 50)))

;; these settings relate to how emacs interacts with your OS
(setq

 ;; makes killing/yanking interact with system clipboard
 x-select-enable-clipboard t

 ;; recommended?
 x-select-enable-primary t

 ;; save clipboard strings into kill ring b4 replacing them.
 ;; when you select something in another prog and paste into Emacs,
 ;; but kills something in Emacs b4 actually pasting it,
 ;; this selection is gone unless this is set to non-nil
 save-interprogram-paste-before-kill t


 ;; mouse yank commands yank at point instead of click
 mouse-yank-at-point t)

;; No blinking curose, it's distracting
(blink-cursor-mode 0)

;; full path in titlebar
(setq-default frame-title-format "%b (%f)")

;; don't pop-up font menu
(global-set-key (kbd "s-t") '(lambda () (interactive)))

;; no bell !!!!!!!!
(setq ring-bell-function 'ignore)

;; smart modeline
(setq sml/theme 'dark)
(sml/setup)


;; global hotkey to grab pkg listings
(global-set-key (kbd "C-c C-p") 'package-list-packages-no-fetch)
(global-set-key (kbd "<f10>") 'toggle-frame-fullscreen)
(global-set-key (kbd "C-<f10>") 'toggle-frame-maximized)
