(global-unset-key (kbd "C-x f"))
(global-unset-key (kbd "C-x C-c"))

(global-set-key (kbd "C-x g") #'magit-status)
(global-set-key (kbd "M-o") #'ace-window)

(global-set-key (kbd "C-x t 1") #'my/tab-bar-close-other-tabs-confirm)

(define-prefix-command 'my/launch-map)
(global-set-key (kbd "C-c l") #'my/launch-map)
(define-key my/launch-map (kbd "k") #'my/open-konsole-here)
(define-key my/launch-map (kbd "d") #'my/open-dolphin-here)

(global-set-key (kbd "C-c k") #'kill-line-to-start)
(global-set-key (kbd "C-c d") #'delete-whole-line-up)
(global-set-key (kbd "C-c b") #'duplicate-line-or-region)
(global-set-key (kbd "C-c ;") #'my-comment-at-indentation)

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c r") #'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c a") #'eglot-code-actions))

(with-eval-after-load 'multiple-cursors
   (global-set-key (kbd "C-S-c C-S-c") #'mc/edit-lines)
   (global-set-key (kbd "C->") #'mc/mark-next-like-this)
   (global-set-key (kbd "C-<") #'mc/mark-prev-like-this)
   (global-set-key (kbd "C-c C-<") #'mc/mark-all-like-this)
   (global-set-key (kbd "C-S-<mouse-1>") #'mc/add-cursor-on-click))

(with-eval-after-load 'flyspell
  (define-key flyspell-mode-map (kbd "C-;") #'flyspell-correct-word-before-point))

(with-eval-after-load 'latex
  (define-key LaTeX-mode-map (kbd "C-c C-a") #'TeX-command-run-all))

(playground-setup-default-keybinding)

(provide 'keybindings)
