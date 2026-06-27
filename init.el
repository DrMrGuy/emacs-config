(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless (and package-archive-contents (package-installed-p 'use-package))
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setq default-directory "~/Dev/")

(server-start)

(require 'ui-settings)
(require 'editor-settings)
(require 'ide-settings)
(require 'language-settings)
(require 'custom-functions)
(require 'playground)
(require 'keybindings)
