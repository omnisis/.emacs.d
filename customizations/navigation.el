;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer

;; when several buffers visit identically-named files,
;; Emacs must give the buffers distinct names.  The usual method
;; for making buffer names unique adds '<2>', '<3>', etc. to the end
;; of the buffer names (all but one of the them).
;; The forward naming method includes part of the file's directory
;; name at the beginning of the buffer name
;; https://www.gnu.org/software/emacs/manual/html_mode/emacs/Uniquify.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; ido is awesome but when you have long filenames it gets harder to read
;; i've tried ido-vertical but grid-mode is more flexible and let's you
;; code in fallbacks if desired
(require 'use-package)
(use-package ido-grid-mode
  :ensure t
  :demand
  :config
  (ido-grid-mode 1))

;; Turn on recent file mode so that you can more easily switch to recently
;; edited files when you first start emacs
(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 40)

;; ido-mode allows you to more easily navigate choices.  For example,
;; when you want to switch buffers, ido presents you with a list
;; of buffers in the mini-buffer.  As you start to type a buffer's
;; name, ido will narrow down the list of buffers to match the text
;; you've typed in
;; http://www.emacswiki.org/emacs/InteractivelyDoThings
(ido-mode t)

; some ido configurations ...
(setq ido-enable-flex-matching t  ; This allows partial matches, e.g. "tl" will match "Tyrion Lannister"
      ido-user-filename-at-point nil ; Turn this behavior off because it's annoying
      ido-auto-merge-work-directories-length -1 ; Don't try to match file across all "work" directories
      ido-use-virtual-buffers t ; Includes buffer names of recently open files, even if they're not open now
      )


;; shows a list of buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Enchances M-x to allow easier execution of cmds.  Provides
;; a filterable list of possible cmds in the minibuffer
;; http://www.emacswiki.org/emacs/Smex
(require 'smex)
(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)

(defun myemacs/meta-x ()
  "A meta-X wrapper so we can change the default behavior of execute-extended-command"
  (interactive)
  (call-interactively 'smex))

;; Based on Steve Yegge's suggestion of re-mapping the META
;; key to a chord on CTRL so we can just forget about it
(global-set-key (kbd  "C-x C-x") 'myemacs/meta-x)
(global-set-key (kbd  "C-c C-x") 'myemacs/meta-x)
(global-set-key (kbd "M-x") 'myemacs/meta-x)

;; projectile all the things!
(projectile-global-mode)

(defun myemacs/projectile-guidekeys ()
  (guide-key/add-local-guide-key-sequence "C-c p"))

(add-hook 'projectile-mode-hook 'myemacs/projectile-guidekeys)
