(defun myemacs/flatten (mylist)
  "Flattens a list recusively for example: 
  '(foo (bar (bat baz) cool) boo)) -> '(foo bar bat baz cool boo)"
  (cond
   ((null mylist) nil)
   ((atom mylist) (list mylist))
   (t
    (eappend (flatten (car mylist)) (flatten (cdr mylist))))))


(defun myemacs/rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "New name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "Buffer '%s' is not visiting a file!" name))
    (progn
      (when (file-exists-p filename)
        (rename-file filename new-name 1))
      (set-visited-file-name new-name)
      (rename-buffer new-name))))

(defun myemacs/browse-current-file ()
  "Open the current file as a URL using `browse-url'."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (and (fboundp 'tramp-tramp-file-p)
             (tramp-tramp-file-p file-name))
        (error "Cannot open tramp file")
      (browse-url (concat "file://" file-name)))))


(defun myemacs/empty-file-if-not-exists (path)
  (when (not (file-exists-p path))
    (with-temp-buffer (write-file path))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Groups / Vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; These settings allow for un-intrusive tweaks to the base configuration.

(defgroup myemacs nil
  "Settings for configuring how myemacs functions")


(defcustom myemacs-keyhelp-backend 'which-key
  "The keyhelp backend to use or nil to disable this feature (not recommended)."
  :type '(choice (const :tag "off" nil)
                 (const :tag "guide-key" 'guide-key)
                 (const :tag "which-key" 'which-key))
  :group 'myemacs)


(provide 'myemacs-utils)




