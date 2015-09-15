(add-to-list 'load-path "~/src/org-mode/lisp")

;; Using Cask for Package Management
(require 'cask "~/.cask/cask.el")

(autoload 'whitespace-mode           "whitespace" "Toggle whitespace visualization."        t)
(autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)

(cask-initialize)

(keyboard-translate ?\C-j ?\C-x)
(keyboard-translate ?\C-x ?\C-j)
(keyboard-translate ?\C-l ?\C-c)
(keyboard-translate ?\C-c ?\C-l)

;; ==================================================
;;                 Basic Settings
;; ==================================================

(push "/usr/local/bin" exec-path)
(set-frame-font "Source Code Pro-11")
(global-visual-line-mode t)
(delete-selection-mode t)
(blink-cursor-mode t)
(show-paren-mode t)
(menu-bar-mode -99)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-default nil)
(setq inhibit-startup-message t)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq-default fill-column 80)
(fset 'yes-or-no-p 'y-or-n-p)
(electric-indent-mode t)
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
(when (window-system)
  (tooltip-mode -1)
  (set-fringe-style -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1))

(global-auto-revert-mode 1)
(setq ring-bell-function 'ignore)

;; ==================================================
;;               AUTO MODES
;; ==================================================

;; Ruby
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("config.ru\\'" . ruby-mode))

;; Web-mode
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.handlebars\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

;; Emmet
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

;;Flucheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; ORG mode
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

;; Ruby refactor
(add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)
(setq ruby-refactor-add-parens 1)


;; ==================================================
;;             REMCHI MODE MAPPINGS
;; ==================================================

;; Define my own keymap
(defvar remchi-mode-map (make-keymap) "my keys")

;; Cursor keys on home row
(define-key remchi-mode-map (kbd "M-k") 'next-line)
(define-key remchi-mode-map (kbd "M-i") 'previous-line)
(define-key remchi-mode-map (kbd "M-j") 'backward-char)
(define-key remchi-mode-map (kbd "M-l") 'forward-char)

;; EXPAND REGION
(define-key remchi-mode-map (kbd "C-;") 'er/expand-region)

;; ACE JUMP MODE
(define-key remchi-mode-map (kbd "C-c SPC") 'ace-jump-mode)

;; CUSTOM FUNCTIONS
;;(define-key remchi-mode-map (kbd "M-l") 'select-current-line)
(define-key remchi-mode-map (kbd "M-RET") 'line-above)
(define-key remchi-mode-map (kbd "C-S-y") 'duplicate-current-line-or-region)
(define-key remchi-mode-map (kbd "M-'") 'create-snippet)
(define-key remchi-mode-map (kbd "C-c r") 'rename-this-buffer-and-file)

;; PROJECTILE and HELM
(global-set-key (kbd "C-c h") 'helm-projectile)

;; MULTIPLE CURSORS
;;(define-key remchi-mode-map (kbd "C-M-'")  'mc/mark-next-like-this)
;;(define-key remchi-mode-map (kbd "C-M-\"")  'mc/mark-previous-like-t his)
;; MAGIT status
(define-key remchi-mode-map (kbd "C-c C-t")  'magit-status)
(windmove-default-keybindings)

;; ==================================================
;;             GLOBAL MAPPINGS
;; ==================================================

;; CUSTOM FUNCTIONS
(global-set-key [remap kill-region] 'cut-line-or-region)
(global-set-key [remap kill-ring-save] 'copy-line-or-region)


;; ==================================================
;;              PLUGINS and PACKAGES
;; ==================================================

;; DIRED SETTINGS
(require 'dired)
(setq dired-recursive-deletes (quote top))
(define-key dired-mode-map (kbd "f") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "^") (lambda ()
                                       (interactive)
                                       (find-alternate-file "..")))

;; YASNIPPET
(yas-global-mode t)

;; PROJECTILE
(projectile-global-mode)

;; IDO MODE
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)
(ido-vertical-mode 1)

;; SAVEPLACE
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "saveplace.el"))
(setq-default save-place t)

;; AUTO-COMPLETE
(require 'auto-complete-config)
(ac-config-default)

;; SCSS MODE
(setq scss-compile-at-save nil)
(setq css-indent-offset 2)


;; JS MODE
(setq js-indent-level 2)


;; ==================================================
;;              CUSTOM FUNCTIONS
;; ==================================================

(defun select-current-line ()
  "Selects the current line"
  (interactive)
  (end-of-line)
  (push-mark (line-beginning-position) nil t))

(defun line-above()
  "Inserts line above current one"
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun cut-line-or-region()
  "Kill current line if no region is active, otherwise kills region."
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (kill-region (line-beginning-position) (line-beginning-position 2))))

(defun copy-line-or-region()
  "Copy current line if no region is active, otherwise copies region."
  (interactive)
  (if (region-active-p)
      (kill-ring-save (region-beginning) (region-end))
    (kill-ring-save (line-beginning-position) (line-beginning-position 2))))

(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        ;;(beginning-of-visual-line)
        (insert region)
        (indent-according-to-mode)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(defun create-snippet (filename)
  "Creates snippet file in ~/.emacs.d/snippets/<mode-name> folder"
  (interactive "s")
  (let ((mode (symbol-name major-mode)))
    (find-file (format "~/.emacs.d/snippets/%s/%s" mode filename))
    (snippet-mode)))

(defun rename-this-buffer-and-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (cond ((get-buffer new-name)
               (error "A buffer named '%s' already exists!" new-name))
              (t
               (rename-file filename new-name 1)
               (rename-buffer new-name)
               (set-visited-file-name new-name)
               (set-buffer-modified-p nil)
               (message "File '%s' successfully renamed to '%s'" name (file-name-nondirectory new-name))))))))

;; ==================================================

;; Define my own minor mode and activate it
(define-minor-mode remchi-mode
  "A minor mode for my custom keys and functions"
  t " remchi" 'remchi-mode-map)
(remchi-mode t)

;; ==================================================
;;                  ORG MODE
;; ==================================================

(add-hook 'org-mode-hook
          (lambda()
            (set (make-local-variable 'electric-indent-functions)
                 (list (lambda(arg) 'no-indent)))))
;; (add-hook 'org-mode
;;           (lambda ()
;;             (set (remchi-mode -1))))
;;(add-hook 'org-mode-hook 'remchi-mode)
(add-hook 'org-mode-hook (lambda () (remchi-mode -1)))
(setq org-src-fontify-natively t)
(define-key global-map "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "DOING(i)" "|" "DONE(d)" "ARCHIVED")))
(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
        ("DOING" . "yellow")
        ("NEXT" . "orange")
        ("DONE" . "green")
        ("ARCHIVED" . "blue")))
(setq org-agenda-custom-commands
      '(("d" todo "DOING")))
(setq org-log-done 'time)
(setq org-startup-folded 'showeverything
      )

;; ==================================================
;;               APPEARENCE
;; ==================================================

(global-hl-line-mode -1)

(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))

(defadvice split-window-below (after restore-balanace-below activate)
  (balance-windows))

(defadvice split-window-right (after restore-balance-right activate)
  (balance-windows))

(defadvice delete-window (after restore-balance activate)
  (balance-windows))

(set-face-background 'hl-line "#B5B6DA")

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n))) (global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

(highlight-indentation-mode 1)
(highlight-indentation-current-column-mode 1)

(set-face-background 'highlight-indentation-face "#e3e3d3")
(set-face-background 'highlight-indentation-current-column-face "#c3b3b3")

(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(crosshairs 1)

(find-file "~/todo.org")
(desktop-save-mode 1)
(global-set-key [f8] 'neotree-toggle)
(setq projectile-switch-project-action 'neotree-projectile-action)
(multiple-cursors-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#26292c" "#ff4a52" "#40b83e" "#f6f080" "#afc4db" "#dc8cc3" "#93e0e3" "#f8f8f8"])
 '(custom-safe-themes
   (quote
    ("e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "0c29db826418061b40564e3351194A3D4A125D182C6EE5178C237A7364F0FF12" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "8f4898805186ae0419125c5fd8cddcd3bd2946c9b1c8e96167f84f762c422f80" "a2e7b508533d46b701ad3b055e7c708323fb110b6676a8be458a758dd8f24e27" "d7088a7105aa09cc68e3d058f89917e07e0505e0f4ab522a6045ec8092d67c44" "86f4407f65d848ccdbbbf7384de75ba320d26ccecd719d50239f2c36bec18628" "4ea594ee0eb3e5741ab7c4b3eeb36066f795c61aeebad843d74f0a28a81a0352" "a3d519ee30c0aa4b45a277ae41c4fa1ae80e52f04098a2654979b1ab859ab0bf" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(fci-rule-color "#202325")
 '(ido-ignore-directories
   (quote
    ("\\`CVS/" "\\`\\.\\./" "\\`\\./" "\\'node_modules/")))
 '(vc-annotate-background "#1f2124")
 '(vc-annotate-color-map
   (quote
    ((20 . "#ff0000")
     (40 . "#ff4a52")
     (60 . "#f6aa11")
     (80 . "#f1e94b")
     (100 . "#f5f080")
     (120 . "#f6f080")
     (140 . "#41a83e")
     (160 . "#40b83e")
     (180 . "#b6d877")
     (200 . "#b7d877")
     (220 . "#b8d977")
     (240 . "#b9d977")
     (260 . "#93e0e3")
     (280 . "#72aaca")
     (300 . "#8996a8")
     (320 . "#afc4db")
     (340 . "#cfe2f2")
     (360 . "#dc8cc3"))))
 '(vc-annotate-very-old-color "#dc8cc3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
