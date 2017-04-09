
(setq myemacs-theme-pkgs '(monokai darcula))
(setq myemacs-theme-pkgnames (mapcar (lambda (x) (intern (format "%s-theme" x))) myemacs-theme-pkgs))

(setq myemacs-default-theme 'darcula)

;; install themes if not installed
(dolist (p myemacs-theme-pkgnames)
  (when (not (package-installed-p p))
    (package-install p)))


(defun myemacs/-set-default-theme (a-theme)
  (setq myemacs-theme-pkgs a-theme))

(defun myemacs/random-theme ()
  (interactive)
  (let ((new-theme 
         (nth (random (length myemacs-theme-pkgs)) myemacs-theme-pkgs)))
    (load-theme new-theme)))


(global-set-key (kbd "C-c t") 'myemacs/random-theme)

(message "Loaded Config Layer :: THEMES")
(provide 'themes)


