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
;; TODO: Move to themes ??
(load-theme 'darcula t)


;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)

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

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

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

;; makes re-builder avoid need for double backslash escaping
(require 're-builder)
(setq reb-re-syntax 'string)

;; provides a popup style imenu context menu (similar to IDEs)
(use-package popup-imenu :ensure t
  :config
  (setq popup-imenu-position 'point)
  (setq popup-menu-style 'indent)
  :bind 
  (("s-i" .  popup-imenu)
   (:map popup-isearch-keymap 
         ("s-i" . popup-isearch-cancel))))


;; emacs autocompletion that doesn't suck
  (use-package company
    :diminish company-mode
    :commands company-mode
    :ensure t
    :demand
    :init
    (setq
     company-dabbrev-ignore-case nil
     company-dabbrev-downcase nil
     company-idle-delay 0
     compay-minimum-prefix-length 3)
    :config
    ;; disables tab in compay mode freeing it for yasnippet
    (define-key company-active-map [tab] nil)
    (define-key company-active-map (kbd "TAB") nil))

;; makes your modeline great again!
(use-package smart-mode-line
  :ensure t
  :demand)
  
;; This is a lifesaver on my MBPro: an ergo keybinding for 
;; keyboard scrolling that is very intuitive 
(global-set-key (kbd "s-<up>") 'scroll-down)
(global-set-key (kbd "s-<down>") 'scroll-up)
(global-set-key (kbd "C-s-<down>") 'end-of-buffer)
(global-set-key (kbd "C-s-<up>") 'beginning-of-buffer)

;; No Code below this line
(message "Loaded Config Layer :: UI")
(provide 'ui)


