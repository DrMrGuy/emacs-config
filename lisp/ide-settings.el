

(use-package company
  :ensure t
  :init
  (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0
        company-tooltip-align-annotations t
        company-selection-wrap-around t
        company-dabbrev-downcase nil))

(use-package eglot
  :ensure nil
  :hook
  ((c-mode . eglot-ensure) (c++-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '((c++-mode c-mode) . ("clangd"
                                      "--header-insertion=never"
                                      "--fallback-style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never}")))
  (add-to-list 'eglot-server-programs
               '(php-mode . ("intelephense" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(glsl-mode . ("glsl-analyzer"))))

(setq-default eglot-semantic-tokens-config
              '((:type "keyword" :face font-lock-keyword-face)
                (:type "type" :face font-lock-type-face)
                (:type "function" :face font-lock-function-name-face)
                (:type "variable" :face font-lock-variable-name-face)))

(setq-default eglot-ignored-server-capabilities '(:inlayHintProvider :documentOnTypeFormattingProvider))

(use-package flymake
  :ensure nil)

(use-package flyspell
  :ensure t
  :diminish
  :hook ((LaTeX-mode . flyspell-mode)
         (org-mode . flyspell-mode))
  :config
  ;; Don't show messages in the minibuffer for every word
  (setq flyspell-issue-message-flag nil))

(use-package writegood-mode
  :ensure t
  :hook (LaTeX-mode . writegood-mode))

(use-package gdscript-mode
  :ensure t
  :mode "\\.gd\\'"
  :hook (gdscript-mode . eglot-ensure)
  :config
  ;; Add Godot LSP server configuration to Eglot
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(gdscript-mode . ("localhost" 6005)))))

(provide 'ide-settings)
