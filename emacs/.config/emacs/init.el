(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(undecorated . t))

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(setq scroll-conservatively 101)
(setq scroll-margin 8)

(set-face-attribute 'default nil :font "Iosevka Term")
(set-face-attribute 'default nil :height 160)

(require 'package)
(require 'use-package)

(package-initialize)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/"))

(use-package ef-themes :ensure t)
(use-package evil :ensure t :config (evil-mode 1))
(use-package magit :ensure t)
(use-package modus-themes :ensure t)
(use-package org :ensure t)
(use-package which-key :ensure t
  :config
    (setq which-key-idle-delay 0.3)
    (which-key-mode)
  )

(load-theme 'ef-bio :no-confirm)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
