;;; playground.el --- disposable code playgrounds -*- lexical-binding: t; -*-

(require 'subr-x)
(require 'seq)

(defgroup playground nil
  "Disposable code playground directories."
  :group 'tools)

(defcustom playground-root (expand-file-name "~/Dev/playground/")
  "Root directory for playgrounds."
  :type 'directory)

(defcustom playground-templates-dir (expand-file-name "~/.emacs.d/playground-templates/")
  "Directory containing template files."
  :type 'directory)

;; You can add more languages here later.
;; Each entry: (KEY DISPLAY-NAME SUBDIR TEMPLATE-FILE MAIN-FILENAME COMPILE-CMD)
(defcustom playground-languages
  '(("cpp" "C++" "cpp" "cpp-main.cpp" "main.cpp" "clang++ -std=c++23 -g -O0 -o main main.cpp && ./main")
    ("c++" "C++" "cpp" "cpp-main.cpp" "main.cpp" "clang++ -std=c++23 -g -O0 -o main main.cpp && ./main")
    ("py" "Python" "python" "python-main.py" "main.py" "python3 main.py")
    ("python" "Python" "python" "python-main.py" "main.py" "python3 main.py")
    ("bnf" "BNF" "bnf" "bnf.txt" "grammar.bnf" "echo 'BNF does not require compilation.'")
    ("org" "Org" "org" "org.org" "notes.org" "echo 'Org mode playground'"))
  "Languages supported by `playground-create`."
  :type '(repeat (list (string :tag "Key")
                       (string :tag "Display name")
                       (string :tag "Subdir")
                       (string :tag "Template file")
                       (string :tag "Main filename")
                       (string :tag "Compile command"))))

(defun playground--lang-keys ()
  (delete-dups (mapcar #'car playground-languages)))

(defun playground--lang-entry (key)
  (seq-find (lambda (e) (string= key (nth 0 e))) playground-languages))

(defun playground--next-dir (lang-subdir)
  "Return a new directory ~/Dev/playground/LANGSUBDIR/pN with lowest free N."
  (let* ((base (expand-file-name (file-name-as-directory lang-subdir) playground-root))
         (n 1)
         candidate)
    (make-directory base t)
    (while (progn
             (setq candidate (expand-file-name (format "p%d" n) base))
             (file-exists-p candidate))
      (setq n (1+ n)))
    candidate))

(defun playground--read-template (template-file)
  "Read TEMPLATE-FILE from `playground-templates-dir` and return its contents."
  (let ((path (expand-file-name template-file playground-templates-dir)))
    (unless (file-readable-p path)
      (user-error "Template not found/readable: %s" path))
    (with-temp-buffer
      (insert-file-contents path)
      (buffer-string))))

(defun playground--write-dir-locals (dir compile-cmd)
  "Write a minimal .dir-locals.el in DIR that sets `compile-command`."
  (let ((dl (expand-file-name ".dir-locals.el" dir)))
    (with-temp-file dl
      (insert ";;; Directory Local Variables\n")
      (insert ";;; For more information see (info \"(emacs) Directory Variables\")\n")
      (insert (format "((nil . ((compile-command . %S)))))\n" compile-cmd)))))

;;;###autoload
(defun playground-create (lang)
  "Create a disposable playground for LANG and visit its main file."
  (interactive
   (list (completing-read "Playground language: "
                          (playground--lang-keys)
                          nil t nil nil "cpp")))
  (let* ((entry (playground--lang-entry lang)))
    (unless entry
      (user-error "Unknown language: %s" lang))
    (pcase-let ((`(,_key ,_display ,subdir ,template ,mainfile ,compilecmd) entry))
      (let* ((dir (playground--next-dir subdir))
             (main-path (expand-file-name mainfile dir))
             (contents (playground--read-template template)))
        (make-directory dir t)
        (playground--write-dir-locals dir compilecmd)
        (with-temp-file main-path
          (insert contents))
        (find-file main-path)
        (message "Created playground: %s" dir)))))

;;;###autoload
(defun playground-setup-default-keybinding ()
  "Bind `playground-create` to C-c p."
  (interactive)
  (global-set-key (kbd "C-c p") #'playground-create))

(provide 'playground)
;;; playground.el ends here
