
(defun kill-line-to-start ()
  (interactive)
  (kill-line 0))

(defun delete-whole-line-up ()
  (interactive)
  (let ((start (line-beginning-position))
        (end (min (point-max) (1+ (line-end-position)))))
    (delete-region start end)
    (when (not (bobp))
      (forward-line -1)
      (end-of-line))))

(defun duplicate-line-or-region ()
  (interactive)
  (let (beg end (origin (point)))
    (if (use-region-p)
        (setq beg (save-excursion
                    (goto-char (region-beginning))
                    (line-beginning-position))
              end (save-excursion
                    (goto-char (region-end))
                    (line-end-position)))
      (setq beg (line-beginning-position)
            end (line-end-position)))
    (let ((text (buffer-substring beg end)))
      (goto-char end)
      (newline)
      (insert text))
    (goto-char origin)))

(defun my-comment-at-indentation ()
  "Comment or uncomment the current line or region at the indentation point."
  (interactive)
  (let ((comment-style 'extra-line))
    (if (use-region-p)
        (comment-or-uncomment-region (region-beginning) (region-end))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position)))))

(defun my/open-konsole-here ()
  (interactive)
  (start-process "konsole" nil
                 "konsole"
                 "--workdir" default-directory))

(defun my/open-dolphin-here ()
  (interactive)
  (start-process "dolphin" nil
                 "dolphin"
                 default-directory))

(defun my/tab-bar-close-other-tabs-confirm ()
  "Ask for confirmation before closing all other tabs."
  (interactive)
  (if (yes-or-no-p "Close all other tabs? ")
      (tab-bar-close-other-tabs)
    (message "Aborted.")))

(provide 'custom-functions)
