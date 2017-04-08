;; emacs execution path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (cons "/usr/local/bin" exec-path))
;;(setq exec-path-from-shell-check-startup-files nil)

;; Sets up exec-path-from shell
;; https://github.com/purcell/exec-path-from-shell
;;(when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize)
;;  (exec-path-from-shell-copy-envs
;;   '("PATH")))


