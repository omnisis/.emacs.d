(require 'package)

;; Add elisp folders for auto-loading
;; /lib             : is for custom support scripts, not config stuff
;; /customizations  : are for pure customizations like ui,editing and navigation concerns
;; /customizations/langs   : language-specific settings implemented as emacs autoload modules
;; /vendor          : is a place to drop non-pkg emacs-lisp code (hopefully there's not too much of that these days)

(add-to-list 'load-path "~/.emacs.d/lib")
(add-to-list 'load-path "~/.emacs.d/customizations")
(add-to-list 'load-path "~/.emacs.d/customizations/langs")
(add-to-list 'load-path "~/.emacs.d/vendor")

(load "myemacs-utils.el")


;; Define pkg repos
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ;; Is Marmalade even worth it anymore when I can find everything on MELPA?
                         ;; ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa-unstable" . "http://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")))
 
(setq  package-archive-priorities '(("melpa-stable" . 5)))

(defun configure-packages ()
  "Installs and Configures all requested packages"
  (print "Configuring available EMACS packages ...")

  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package)
  

  ;; makes handling lisp expressions much, much easier
  (use-package paredit)


  ;; helps you to understand what keys are bound in a given context
  ;; because many packages will use guide-key in a local mode hook
  ;; to help learn their bindings we put this fairly early in the init
  ;; sequence
  (use-package guide-key 
    :ensure t
    :demand
    :config 
    (require 'guide-key)
    (setq guide-key/guide-key-sequence '("C-x r" "C-x 4"))
    (setq guide-key/idle-delay 0.1)
    (guide-key-mode 1))

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

  ;; key bingdings + colorizations for Clojure
  (use-package clojure-mode
    :config (require 'clojure-support)
    )

  ;; extra syntax highlighting for Clojure
  (use-package clojure-mode-extra-font-locking)

  ;; integration with Clojure REPL
  (use-package cider)

  ;; allows ido usage in as many contexts as possible
  (use-package ido-ubiquitous)

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
    (ido-mode 1)
    (ido-everywhere 1)
    (flx-ido-mode 1))

  ;; enhances M-x to allow easier execution of commands. Provides
  ;; a filterable list of possible commands in the minibuffer
  (use-package smex)

  ;; project navigation
  (use-package projectile
    :demand
    :init (setq projectile-use-git-grep t)
    :config (projectile-global-mode)
    :bind (("s-f" . projectile-find-file)
           ("s-F" . projectile-grep)))

    ;; colorful paren matching

  (use-package rainbow-delimiters)

  ;; edit html tags like sexps
  (use-package tagedit)

  ;; git integration
  (use-package magit)

  ;; makes your modeline great again!
  (use-package smart-mode-line)
  
  (use-package sbt-mode :ensure t :pin melpa-stable)
  (use-package scala-mode 
    :ensure t 
    :pin melpa-stable)
  
  ;; provides a popup style imenu context menu (similar to IDEs)
  (use-package popup-imenu :ensure t
    :config
    (setq popup-imenu-position 'point)
    (setq popup-menu-style 'indent)
    :bind 
    (("s-i" .  popup-imenu)
     (:map popup-isearch-keymap 
           ("s-i" . popup-isearch-cancel))))

  ;; scala support
  (use-package ensime 
    :ensure t 
    :pin melpa-stable
    :config 
    (setq ensime-startup-notification nil)
    (require 'scala-support))

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


  ;; Backend for org-mode that exports to github-flavored Markdown
  (use-package ox-gfm
    :ensure t
    :config
    (require 'ox-gfm nil t))

  
)


;; intialize and configure pkg system
(configure-packages)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("f5b591870422cd28da334552aae915cdcae3edfcfedb6653a9f42ed84bbec69f" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "cb4cb09f1736cfb2a80ef371c33a9868cbf6707ec5af51d61162483d6c3fbb7c" default)))
 '(ensime-auto-generate-config t)
 '(ensime-save-before-compile t)
 '(package-selected-packages
   (quote
    (dired-sort dired+ guide-key ox-gfm etags-select undo-tree ensime use-package smart-mode-line monokai-theme magit tagedit rainbow-delimiters projectile smex ido-ubiquitous clojure-mode-extra-font-locking paredit ac-cider darcula-theme cider)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;;;;
;; Customizations
;;;;

;; Customizations to how emacs communicates with OS shells
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make the editing experience a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

(require 'dired-support)

;; Langauage-specific
(require 'elisp-support)
(require 'javascript-support)
;; below are now handled by use-package :config hooks
;;(load "setup-scala.el")   
;;(require "clojure-support")

;; extensions for loading/managing emacs themes
(load "themes.el")




