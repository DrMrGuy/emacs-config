

(setq-default c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-basic-offset 4)
            (c-toggle-comment-style -1)))

(use-package web-mode
  :ensure t
  :mode "\\.php\\'"
  :config
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-css-indent-offset 4))

(use-package glsl-mode
  :ensure t
  :mode ("\\.glsl\\'" "\\.vert\\'" "\\.frag\\'" "\\.geom\\'" "\\.comp\\'")
  :config
  (add-hook 'glsl-mode-hook
            (lambda ()
              (setq c-basic-offset 4)
              (setq tab-width 4))))

(add-hook 'glsl-mode-hook 'eglot-ensure)

(add-hook 'org-mode-hook 'turn-on-auto-fill)

(use-package tex
  :ensure auctex
  :config
  ;; Force standard pdflatex and PDF mode
  (setq-default TeX-engine 'default)
  (setq-default TeX-PDF-mode t)
  
  (setq TeX-bibtex-command "Biber")

  ;; PDF-Tools integration
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-view-program-list '(("PDF Tools" "TeX-pdfview-sync-view"))
        TeX-source-correlate-mode t
        TeX-source-correlate-start-server t)

  ;; Refresh PDF after compilation
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer)

  (setq TeX-save-query nil)

  ;; Hooks for prose and citations
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)

  (add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq-local company-minimum-prefix-length 3)
            (setq-local company-idle-delay 0.5)))

  ;; AUCTeX behavior
  (setq reftex-plug-into-AUCTeX t
        TeX-parse-self t
        TeX-auto-save t)

  ;; Ensure .tex files open in LaTeX mode, not Plain TeX
  (add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
  (setq-default major-mode 'latex-mode))

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (add-hook 'pdf-view-mode-hook (lambda () (display-line-numbers-mode -1)))
  (add-hook 'pdf-view-mode-hook 'auto-revert-mode))

(provide 'language-settings)
