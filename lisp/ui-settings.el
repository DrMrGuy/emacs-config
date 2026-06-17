
(add-to-list 'default-frame-alist '(font . "Iosevka-20"))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(winner-mode 1)

(load-theme 'gruber-darker t)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-grow-only t)

(setq sr-speedbar-width 40)

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

(provide 'ui-settings)
