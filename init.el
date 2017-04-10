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

;; I don't like cluttering my init file with customization settings
;; I also prefer to prompt the user if unsaved customizations are not resolved on quit
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

;; Customizations to how emacs communicates with OS shells
(require 'shell-integration)

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(require 'navigation)

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(require 'ui)

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




