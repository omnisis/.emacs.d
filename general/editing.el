;; Customizations relating to editing a buffer.

;; key binding to use "hippie example" for text autocompletion
(global-set-key (kbd "M-/") 'hippie-expand)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol
        try-complete-file-name-partially
        try-complete-file-name
))

;; highlight matching parens
(show-paren-mode 1)

;; turn on company mode completion everywhere
(add-hook 'after-init-hook 'global-company-mode)

;; highlight current line
(global-hl-line-mode 1)

;; interactive search key bindings.  By default, C-s runs
;; isearch-forward, so this swaps the bindings.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)


;; Don't use hard tabs !!!
(setq-default indent-tabs-mode nil)

;; when you visit a file, point goes to the last place where it
;; was when you previously visited the same file.
(require 'saveplace)
(setq-default save-place t)
;; keep track of saved places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places"))

;; Emacs can automatically create backup files.  This tells Emacs
;; to put all backups in ~/.emacs.d/backups.
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
					       "backups"))))

(setq auto-save-default nil)

;; comments
(defun toggle-comment-on-line()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position)(line-end-position)))

(global-set-key (kbd "C-;") 'toggle-comment-on-line)
		


;; use 2 spaces for tabs
(defun die-tabs()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))


;; shell scripts indentation level
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; fix weird os x kill error
;;(defun ns-get-pasteboard()
;;  "Returns the value of the pasteboard, or nil for unsupported formats."
;; (condition-case nil
;;      (ns-get-selection-internal 'CLIPBOARD)
;;    (quit nil)))


(setq electric-indent-mode nil)

;;  "join lines" like in Vim/SublimeText
(defun join-lines ()
  (interactive)
  (end-of-line)
  (delete-char 1) 
  (delete-horizontal-space)
  (insert " "))

;; Some keybindings
(global-set-key (kbd "C-c j") 'join-lines)

;; edit html tags like sexps
(use-package tagedit :demand :ensure t)

(message "Loaded Config Layer :: EDITING")
(provide 'editing)

