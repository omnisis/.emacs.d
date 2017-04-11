;;;;;
;; Suport for Clojure Programming
;;;;;

(defun myemacs/clojure-mode-hook-fn ()
  (setq inferior-lisp-program "lein repl")
  (font-lock-add-keywords
   nil
   '(("(\\(facts?\\)"
      (1 font-lock-keyword-face))
     ("(\\(background?\\)"
      (1 font-lock-keyword-face))))
  (define-clojure-indent (fact 1))
  (define-clojure-indent (facts 1)))

;; key bingdings + colorizations for Clojure
(use-package clojure-mode
  :config 
  (add-hook 'clojure-mode-hook   #'myemacs/clojure-mode-hook-fn)
  ;; enable paredit in clojure buffers
  (add-hook 'clojure-mode-hook   #'enable-paredit-mode)
  ;; this is useful for working with camel-case tokens, like Java classnames
  (add-hook 'clojure-mode-hook   #'subword-mode))

;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))

;; extra syntax highlighting for Clojure
(use-package clojure-mode-extra-font-locking)


;; a little more syntax highlighting
(require 'clojure-mode-extra-font-locking)

;; syntax highlighting for midje
(add-hook 'clojure-mode-hook #'myemacs/clojure-mode-hook-fn)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CIDER :: integration with Clojure REPL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun cider-start-http-server ()
  (interactive)
  (cider-load-current-buffer)
  (let ((ns (cider-current-ns)))
    (cider-repl-set-ns ns)
    (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
    (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))

(defun cider-refresh ()
  (interactive)
  (cider-interactive-eval (format "(user/reset)")))

(defun cider-user-ns ()
  (interactive)
  (cider-repl-set-ns "user"))

(use-package cider
  :config

  ;; go right to the REPL buffer when it's finished connecting
  (setq cider-repl-pop-to-buffer-on-connect t)

  ;; When there's a CIDER error, show its buffer and switch to it
  (setq cider-show-error-buffer t)
  (setq cider-auto-select-error-buffer t)
  
  ;; Where to store the cider history.
  (setq cider-repl-history-file "~/.emacs.d/cider-history")

  ;; Wrap when navigating history.
  (setq cider-repl-wrap-history t)

  ;; enable paredit in your REPL
  (add-hook 'cider-repl-mode-hook 'paredit-mode)

  ;; key bindings: these help me out with the way I usually develop web apps
  (define-key clojure-mode-map (kbd "C-c C-v") #'cider-start-http-server)
  (define-key clojure-mode-map (kbd "C-M-r")   #'cider-refresh)
  (define-key clojure-mode-map (kbd "C-c u")   #'cider-user-ns)
  (define-key cider-mode-map   (kbd "C-c u")   #'cider-user-ns))


(message "Loaded awesome Clojure customizations")
(provide 'clojure-support)
