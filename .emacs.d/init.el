;;; init.el --- Load the full configuration -*- lexical-binding: t  -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;;(setq debug-on-error t)

(let ((minver "27.1"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "28.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(defconst *spell-check-support-enable* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;; 将自定义设置保存到单独的文件
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; 如果文件不存在则创建它
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
;; 加载自定义文件
(load custom-file)

;; Package Management
(eval-when-compile
 (require 'use-package))


;; Adjust garbage collection threshold for early startup (see use of gcmh below)
(setq gc-cons-threshold (* 128 1024 1024))

;; Process performance tuning

(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)

;; options:
(setq confirm-kill-emacs #'yes-or-no-p)
(electric-pair-mode t)
(add-hook 'prog-mode-hook #'show-paren-mode)
(column-number-mode t)
(global-auto-revert-mode t)
(delete-selection-mode t)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-display-line-numbers-mode 1)
(tool-bar-mode -1)
(when (display-graphic-p) (toggle-scroll-bar -1))
(savehist-mode 1)
(setq display-line-numbers-type 'relative)

(set-face-attribute 'default nil
                    :family "Hack Nerd Font Mono"
                    :height 150
                    :weight 'normal
                    :width 'normal)




;;; Key bindings:
; (global-set-key (kbd "RET") 'newline-and-indent)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


(which-key-mode 1)
;; Plugins:

(use-package counsel
  :ensure t)
(use-package ivy
 :ensure t
 :init
 (ivy-mode 1)
 (counsel-mode 1)
 :config
 (setq ivy-use-virtual-buffers t)
 (setq search-default-mode #'char-fold-to-regexp)
 (setq ivy-count-format "(%d/%d) ")
 :bind
 (("C-s" . 'swiper)
  ("C-x b" . 'ivy-switch-buffer)
  ("C-c v" . 'ivy-push-view)
  ("C-c s" . 'ivy-switch-view)
  ("C-c V" . 'ivy-pop-view)
  ("C-x C-@" . 'counsel-mark-ring)
  ("C-x C-SPC" . 'counsel-mark-ring)
  :map minibuffer-local-map
  ("C-r" . counsel-minibuffer-history)))

(use-package hydra
 :ensure t)

(use-package use-package-hydra
 :ensure t
 :after hydra)


(use-package amx
 :ensure t
 :init (amx-mode))

(use-package ace-window
 :ensure t
 :bind (("C-x o" . 'ace-window)))

(use-package mwim
 :ensure t
 :bind
 ("C-a" . mwim-beginning-of-code-or-line)
 ("C-e" . mwim-end-of-code-or-line))

(use-package undo-tree
 :ensure t
 :init (global-undo-tree-mode)
 :custom
 (undo-tree-auto-save-history nil)
 :after hydra
 :bind ("C-x C-h u" . hydra-undo-tree/body)
 :hydra (hydra-undo-tree (:hint nil)
 "
 _p_: undo _n_: redo _s_: save _l_: load  "
 ("p"  undo-tree-undo)
 ("n"  undo-tree-redo)
 ("s"  undo-tree-save-history)
 ("l"  undo-tree-load-history)
 ("u"  undo-tree-visualize "visualize" :color blue)
 ("q"  nil "quit" :color blue)))			 

(use-package catppuccin-theme
  :ensure t
  :init
  (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'mocha)
  (catppuccin-reload))

(global-set-key (kbd "C-j") nil) 
(use-package avy
 :ensure t
 :bind
 (("C-j C-SPC" . avy-goto-char-timer)))

(use-package marginalia
 :ensure t
 :init (marginalia-mode)
 :bind (:map minibuffer-local-map
     ("M-A" . marginalia-cycle)))

(use-package multiple-cursors
 :ensure t
 :after hydra
 :bind
 (("C-x C-h m" . hydra-multiple-cursors/body)
  ("C-S-<mouse-1>" . mc/toggle-cursor-on-click))
 :hydra
 (hydra-multiple-cursors
  (:hint nil)
  "
Up^^       Down^^      Miscellaneous      % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
------------------------------------------------------------------
 [_p_]  Prev   [_n_]  Next   [_l_] Edit lines [_0_] Insert numbers
 [_P_]  Skip   [_N_]  Skip   [_a_] Mark all  [_A_] Insert letters
 [_M-p_] Unmark  [_M-n_] Unmark  [_s_] Search   [_q_] Quit
 [_|_] Align with input CHAR    [Click] Cursor at point"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("|" mc/vertical-align)
  ("s" mc/mark-all-in-region-regexp :exit t)
  ("0" mc/insert-numbers :exit t)
  ("A" mc/insert-letters :exit t)
  ("<mouse-1>" mc/add-cursor-on-click)
  ;; Help with click recognition in this hydra
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore)
  ("q" nil)))

(use-package dashboard
 :ensure t
 :config
 (setq dashboard-banner-logo-title "Welcome to Emacs!") ;; 个性签名，随读者喜好设置
 ;; (setq dashboard-projects-backend 'projectile) ;; 读者可以暂时注释掉这一行，等安装了 projectile 后再使用
 (setq dashboard-startup-banner 'official) ;; 也可以自定义图片
 (setq dashboard-items '((recents . 5)  ;; 显示多少个最近文件
  (bookmarks . 5) ;; 显示多少个最近书签
  (projects . 10))) ;; 显示多少个最近项目
 (dashboard-setup-startup-hook))

(use-package tiny
 :ensure t
 ;; 可选绑定快捷键，笔者个人感觉不绑定快捷键也无妨
 :bind
 ("C-;" . tiny-expand))

(use-package wakatime-mode
  :ensure t
  :config
  (global-wakatime-mode))

(use-package highlight-symbol
 :ensure t
 :init (highlight-symbol-mode)
 :bind ("<f3>" . highlight-symbol)) ;; 按下 F3 键就可高亮当前符号

(use-package rainbow-delimiters
 :ensure t
 :hook (prog-mode . rainbow-delimiters-mode))


(provide 'init)
;;; init.el ends here
