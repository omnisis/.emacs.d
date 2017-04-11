;; Add elisp folders for auto-loading
(add-to-list 'load-path "~/.emacs.d/lib")
(add-to-list 'load-path "~/.emacs.d/general")
(add-to-list 'load-path "~/.emacs.d/langs")
(add-to-list 'load-path "~/.emacs.d/modes")
(add-to-list 'load-path "~/.emacs.d/hacks")
(add-to-list 'load-path "~/.emacs.d/vendor")

;; Pull in global utility fns
(require  'myemacs-utils)

;; I don't like cluttering my init file with customization settings
;; I also prefer to prompt the user if unsaved customizations are not resolved on quit
;; NOTE :: This file must be loaded *PRIOR* to any package loading or config...
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(myemacs/empty-file-if-not-exists custom-file)
(load custom-file)
(add-hook 'kill-emacs-query-functions
          'custom-prompt-customize-unsaved-options)


;; Define pkg repos where we will pull pkgs to install from
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ;; Is Marmalade even worth it anymore when I can find everything on MELPA?
                         ;; ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa-unstable" . "http://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")))
 
(setq  package-archive-priorities '(("melpa-stable" . 5)))

;; intialize and configure pkg system
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load Customization Stack 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(require 'ui)

;; Customizations to how emacs communicates with OS shells
(require 'shell-integration)

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(require 'navigation)

;; These customizations make the editing experience a bit nicer.
;; Note that most of these customizations are generic, see langs/<proglang-support.el>
;; for language specific tweaks
(require 'editing)

;; Hard-to-categorize customizations (called last in case of prior deps)
(require 'misc)

;; extensions for loading/managing emacs themes
(require 'themes)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode-specific
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'dired-support)
(require 'orgmode-support)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Langauage-specific
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'elisp-support)
(require 'javascript-support)
(require 'clojure-support)
(require 'scala-support)




