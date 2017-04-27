(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;; packages
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))
(package-initialize) ;; You might already have this line
(setq inferior-lisp-program "/opt/sbcl/bin/sbcl")
(global-linum-mode t)
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e)) 
(setq mouse-sel-mode t)
(global-linum-mode t)
(setq scroll-step 1)
(column-number-mode 1)
;; For theme engine.
(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

;; Paren depth with color
(require 'highlight-parentheses)

(define-globalized-minor-mode global-highlight-parentheses-mode highlight-parentheses-mode
  (lambda nil (highlight-parentheses-mode t)))

;; Activate paren mode
(show-paren-mode 1)

;; For C autocomplete
(require 'company)
(add-hook 'global-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-c-headers)

;; For clang format/autocomplete
(require 'clang-format)
(global-set-key [C-M-tab] 'clang-format-region)

;; For Neotree which is project sidebar
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
  )

;; rebind the meta key
(setq mac-option-modifier 'meta) ; set alt-key to meta
(setq mac-escape-modifier nil) ; set esc-key to nil

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "a6a8c2f747511ef4e2dbbff193c1779219fc09103ada6de731f33c528fdb19ad" "87060cd4dbb2a9cae756d0e9876ff11abf4aad85c93ed6885bd44b2b5978845d" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" default)))
 '(package-selected-packages
   (quote
    (better-defaults clang-format find-file-in-project neotree highlight-parentheses auto-complete-clang flycheck git-gutter company-c-headers auto-package-update auto-highlight-symbol auto-complete-chunk auto-compile color-theme-sanityinc-tomorrow autofit-frame auto-complete slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
