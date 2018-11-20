;;; m-templates.el --- Simple new file templates

;; Author: Mario Garcia
;; Keywords: lisp
;; Version: 0.0.1
;; URL: https://github.com/mariogarcia/m-templates

;;; Commentary:

;; When a file is not found is triggered a new file is created with
;; information derived from name, extension, and path.
;;

;;; Code:

(defvar m-templates-version "0.0.1")

(defgroup m-templates nil
  "Support to set the TEMPLATES dir"
  :group 'languages
  :prefix "m-templates-")

(defcustom m-templates-dir
  (concat "~/.emacs.d/elpa/m-templates-" m-templates-version "/tmpl/")
  "Default template dir."
  :type 'string
  :group 'm-templates)

(defvar template-replacements-alist
  '(("%filename%" . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%classname%" . (lambda () (file-name-nondirectory (file-name-sans-extension (buffer-file-name)))))
    ("%package%" . (lambda () (template-insert-package (buffer-file-name))))
    ("%author%" . user-full-name))
  "A list which specifies what substitutions to perform.")

(defun template-insert-package (file-name)
  "Insert package from FILE-NAME."
  (let ((pwd (file-name-directory file-name))
        (ext (file-name-extension file-name))
        result)
    (cond ((member ext '("groovy" "java"))
           (resolve-jvm-package ext pwd))
          (t
           ""))))

(defun resolve-jvm-package (lang path)
  "Resolve LANG file package from PATH."
  (let ((convention (concat "src/main/" lang "/")))
    (if (string-match convention path)
        (let*
            ((result (substring path (match-end 0)))
             (list (ce-filter-empty-or-nil-string (split-string result "/")))
             (pkg (ce-string-join list ".")))
             (concat "package " pkg))
      "")))

(defun ce-filter-empty-or-nil-string (list)
  "Filter nil and empty strings from LIST."
  (seq-filter (lambda (x)
                (not (or
                      (equal "" x)
                      (not x)
                      )))
              list))

(defun ce-string-join (list sep)
  "Join LIST with SEP."
  (mapconcat 'identity list sep))

(defun template-file-not-found-hook ()
  "Call this when a 'find-file' command has not been able to find the specified file."
  (condition-case nil
      (if (and (find-template-file)
               (y-or-n-p "Use template file? "))
          (progn (buffer-disable-undo)
                 (insert-file-contents (find-template-file))
                 (goto-char (point-min))

                 (let ((the-list template-replacements-alist))
                   (while the-list
                     (goto-char (point-min))
                     (replace-string (car (car the-list))
                                     (funcall (cdr (car the-list)))
                                     nil)
                     (setq the-list (cdr the-list))))
                 (goto-char (point-min))
                 (buffer-enable-undo)
                 (set-buffer-modified-p nil)))
    ('quit (kill-buffer (current-buffer))
           (signal 'quit "Quit"))))

(defun find-template-file ()
  "Check whether any of TMPL-FILES match the end of the full FILE-NAME."
  (let
      ((file-name (buffer-file-name))
       (tmpl-files (sort-list-by-length-desc
                    (directory-files m-templates-dir)))
       (tmpl))
    (while tmpl-files
      (if (string-suffix-p (car tmpl-files) file-name)
          (progn
            (setq tmpl (concat m-templates-dir (car tmpl-files)))
            (setq tmpl-files (list)))
        (setq tmpl-files (cdr tmpl-files))))
    tmpl))

(defun sort-list-by-length-desc (p-list)
  "Sort P-LIST by descending length order."
  (sort p-list
        (lambda (a b)
          (> (length a) (length b)))))

(or (memq 'template-file-not-found-hook find-file-not-found-functions)
    (setq find-file-not-found-functions
          (append find-file-not-found-functions '(template-file-not-found-hook))))

(provide 'm-templates)

;;; m-templates.el ends here
