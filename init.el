;;; init.el - emacs configuration
;;;==============================

;;; updated 7/19/2011

;;; make sure init.el is compiled asap
;;;-----------------------------------------------
(require 'bytecomp)
(defconst dot-emacs (concat (getenv "HOME") "/" ".emacs.d" "/" "init.el") "My dot emacs file")
(setq compiled-dot-emacs (byte-compile-dest-file dot-emacs))
(if (file-newer-than-file-p dot-emacs compiled-dot-emacs)
    (message-box (concat "Please byte compile " dot-emacs)))

;;; backups and auto-saves (files~ and #files#)
;;;-----------------------------------------------
;;; disable backups and autosaves
;(setq make-backup-files nil)   ;;; files~
;(setq auto-save-default nil)   ;;; #files#
;;; put backups and autosaves in temp dir
(defvar backup-dir (expand-file-name "~/.emacstmp/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacstmp/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

;;; start the server for emacsclient use
; (server-start)

;;; local environment
;;;-----------------------------------------------

;; pathes
(setq home-emacs-dir (concat (getenv "HOME") "/.emacs.d/"))
(setq my-load-path (list home-emacs-dir))
(setq load-path (append my-load-path load-path))

;(add-to-list 'load-path "/dev/emacs-23.2/lisp/")
;(load-library "lpr")
;(load-library "ps-print")
;(load-library "printing")

;; suppress startup messages
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-screen t)

;; cool frame title with currently edited buffer name
(setq frame-title-format (concat "%b - " invocation-name "@" system-name))

;; show line and column number the cursor is on, in status bar (the mode line)
(line-number-mode 1)         
(column-number-mode 1)

;; display line numbers in margin (fringe). Emacs 23 only.
;; (require 'linum)
;; (global-linum-mode 1)   
;; (linum-mode 1)

;; highlight current line
;(add-hook 'text-mode-hook (lambda () (hl-line-mode 1))) 
(defface hl-line '((t (:background "grey30")))
  "Face to use for `hl-line-face'." :group 'hl-line)
(setq hl-line-face 'hl-line)
(global-hl-line-mode t)

;; turn on syntax coloring
(global-font-lock-mode 1)

;; highlight text selection (many DWIM commands work only in this mode)
(transient-mark-mode 1)      

;; delete seleted text when typing
(delete-selection-mode 1)

;; turn on paren match highlighting
(show-paren-mode 1)          

;; enable recent file tracking and menu
(recentf-mode 1)

;; use spaces for indent
(setq indent-tabs-mode nil)

;; show menu bar
(setq menu-bar-mode t)

;; ;; autocomplete
;; (add-to-list 'load-path "~/.emacs.d")
;; (require 'auto-complete-config)
;; (setq completion-ignore-case t)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (ac-config-default)

;; try to improve slow performance on windows.
;; (setq w32-get-true-file-attributes nil)

;;; SQL
;;;-----------------------------------------------
;(eval-after-load "sql"
;  `(progn
;     (sql-set-product 'mysql)
;     (setq sql-mysql-program "c:/Program Files/MySQL/MySQL Server 5.0/bin/mysql.exe")
;     (setq sql-user "root")
;     (setq sql-database "tsademo")
;     (setq sql-server "localhost")
;     (setq sql-mysql-options '("--defaults-file=c:/Program Files/MySQL/MySQL Server 5.0/my_tsa.ini" "-C" "-t" "-f" "-n"))
;))

;;; IDO mode settings
;;;-----------------------------------------------
;; don't use ido-imenu unless turn on ido-mode
(ido-mode t)

;; ielm autocomplete support!
(defun ielm-auto-complete ()
  "Enables `auto-complete' support in \\[ielm]."
  (setq ac-sources '(ac-source-functions
                     ac-source-variables
                     ac-source-features
                     ac-source-symbols
                     ac-source-words-in-same-mode-buffers))
  (add-to-list 'ac-modes 'inferior-emacs-lisp-mode)
  (auto-complete-mode 1))
(add-hook 'ielm-mode-hook 'ielm-auto-complete)

;;; org-mode
;;;-----------------------------------------------
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;;(global-font-lock-mode 1)                     ; for all buffers
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

;;; c++
(defun my-cpp-mode-hook ()
  (setq c-basic-offset 4))
(add-hook 'c-mode-hook 'my-cpp-mode-hook)
(add-hook 'cpp-mode-hook 'my-cpp-mode-hook)

;;; my personal customizations
;;;-----------------------------------------------
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-support-shift-select t)
 '(python-indent 2))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((default (:background "black" :foreground "lightblue" :height 105 :family "Monaco")) (nil nil)))
 '(cursor ((t (:background "limegreen"))))
 '(region ((t (:background "blue")))))
