(setq inhibit-startup-screen t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(column-number-mode)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(setq scroll-conservatively 101)
(setq scroll-margin 8)

(set-face-attribute 'default nil :font "Iosevka Term Light")
(set-face-attribute 'default nil :height 160)

(setq tab-always-indent 'complete)

(require 'package)
(require 'use-package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq use-package-always-ensure t)
(use-package ef-themes)
(use-package magit)
(use-package org)

(use-package evil
  :init
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode)
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
  (global-corfu-mode)
)

(use-package which-key
  :config
  (setq which-key-idle-delay 0.3)
  (which-key-mode)
)

(load-theme 'ef-tritanopia-dark :no-confirm)

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)
