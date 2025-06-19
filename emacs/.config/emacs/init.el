(setq custom-file (make-temp-file "emacs-custom-"))

(setq create-lockfiles nil make-backup-files nil)

(when (native-comp-available-p)
  (setq native-comp-async-report-warnings-errors 'silent
        native-compile-prune-cache t))

(column-number-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(setq scroll-conservatively 101 scroll-margin 8)

(defun term-scroll ()
  (setq-local scroll-conservatively 0 scroll-margin 0)
)
(add-hook 'term-mode-hook #'term-scroll)

(if (eq system-type 'darwin)
  (progn (set-face-attribute 'default nil :font "PragmataPro Mono")
         (set-face-attribute 'default nil :height 160))
  (progn (set-face-attribute 'default nil :font "PragmataPro Mono")
         (set-face-attribute 'default nil :height 120))
)

(setq which-key-idle-delay 0.3)
(which-key-mode 1)

;; Support opening new minibuffers from inside existing minibuffers.
(setq enable-recursive-minibuffers t)

;; Hide commands in M-x which do not work in the current mode.
(setq read-extended-command-predicate #'command-completion-default-include-p)

;; Do not allow the cursor in the minibuffer prompt
(setq minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

(require 'package)
(require 'use-package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq use-package-always-ensure t)
(use-package ef-themes)
(use-package magit)
(use-package savehist :init (savehist-mode))
(use-package vterm)

(use-package evil
  :init
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (evil-set-leader 'normal (kbd "<SPC>"))
  (define-key evil-normal-state-map (kbd "<leader>-") 'evil-window-split)
  (define-key evil-normal-state-map (kbd "<leader>\\") 'evil-window-vsplit)
)

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  :bind
  (:map corfu-map
    ("TAB" . corfu-next)
    ([tab] . corfu-next)
    ("S-TAB" . corfu-previous)
    ([backtab] . corfu-previous))
  :init
  (setq tab-always-indent 'complete)
  (global-corfu-mode 1)
)

(use-package org
  :init
  (setq org-babel-load-languages '((emacs-lisp . t) (python . t) (shell . t)))
)

(use-package vertico
  :custom
  (vertico-count 20)
  (vertico-resize t)
  (vertico-cycle t)
  :init
  (vertico-mode)
)

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion))))
)

(load-theme 'ef-tritanopia-dark :no-confirm)
