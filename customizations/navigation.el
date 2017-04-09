;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; when several buffers visit identically-named files,
;; Emacs must give the buffers distinct names.  The usual method
;; for making buffer names unique adds '<2>', '<3>', etc. to the end
;; of the buffer names (all but one of the them).
;; The forward naming method includes part of the file's directory
;; name at the beginning of the buffer name
;; https://www.gnu.org/software/emacs/manual/html_mode/emacs/Uniquify.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

 
;; Turn on recent file mode so that you can more easily switch to recently
;; edited files when you first start emacs
(defun myemacs/ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(require 'recentf)
(setq 
 recentf-auto-cleanup (number-to-string (* 60 15)) ;; cleanup files ever 15 mins
 recentf-max-menu-items 150
 recentf-save-file (concat user-emacs-directory ".recentf"))  
(global-set-key (kbd "C-x C-r") 'myemacs/ido-recentf-open)
(recentf-mode t)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEGIN IDO Config 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ido-mode allows you to more easily navigate choices.  For example,
;; when you want to switch buffers, ido presents you with a list
;; of buffers in the mini-buffer.  As you start to type a buffer's
;; name, ido will narrow down the list of buffers to match the text
;; you've typed in
;; http://www.emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)
;; allows partial matching, e.d. "tl" will match "Tyrion Lannister"
(setq ido-enable-flex-matching t)
;; turn this off, it's annoying
(setq ido-user-filename-at-point nil)
;; don't try to match across all "work directories"
(setq ido-auto-merge-work-directories-length -1) 
;; include buffer names of recently open files even if not open now
(setq ido-use-virtual-buffers t) 
(ido-mode t)

;; shows a list of buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; allows ido usage in as many contexts as possible
(use-package ido-ubiquitous 
  :ensure t
  :demand)

;; ido is awesome but when you have long filenames it gets harder to read
;; i've tried ido-vertical but grid-mode is more flexible and let's you
;; code in fallbacks if desired
(use-package ido-grid-mode
  :ensure t
  :demand
  :config
  (ido-grid-mode 1))

;; makes ido work a little bit more like sublime text
(use-package flx-ido
  :demand
  :ensure t
  :init
  (setq
   ido-enable-flex-matching t
   ;; C-d to open directories
   ;; C-f to revert to find-file
   ido-show-dot-for-dired nil
   ido-enable-dot-prefix t)
  :config
  (ido-mode t)
  (ido-everywhere 1)
  (flx-ido-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END IDO Config 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Enchances M-x to allow easier execution of cmds.  Provides
;; a filterable list of possible cmds in the minibuffer
;; http://www.emacswiki.org/emacs/Smex
(use-package smex
  :ensure t
  :demand
  :config
  (setq smex-save-file (concat user-emacs-directory ".smex-items"))
  (smex-initialize))


(defun myemacs/meta-x ()
  "A meta-X wrapper so we can change the default behavior of execute-extended-command"
  (interactive)
  (call-interactively 'smex))

;; Based on Steve Yegge's suggestion of re-mapping the META
;; key to a chord on CTRL so we can just forget about it
(global-set-key (kbd  "C-x C-x") 'myemacs/meta-x)
(global-set-key (kbd  "C-c C-x") 'myemacs/meta-x)
(global-set-key (kbd "M-x") 'myemacs/meta-x)


;; projectile is an efficient way to navigate "projects" based
;; on common version control and build system files. 
(use-package projectile
  :demand
  
  :init 
  (setq projectile-use-git-grep t)
  
  :config 
  (projectile-global-mode)
  
  :bind (("s-f" . projectile-find-file)
         ("s-F" . projectile-grep)))



;; guide-key helps you to understand what keys are bound in a given context
;; because many packages will use guide-key in a local mode hook
;; to help learn their bindings we put this fairly early in the init
;; sequence
;; TODO: Allow switching between guide-key and ivy + which-key

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


(message "Loaded Config Layer :: NAVIGATION")
(provide 'navigation)

