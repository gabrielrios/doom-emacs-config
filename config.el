;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Gabriel Rios"
      user-mail-address "gabrielfalcaorios@gmail.com")


;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "MesloLGS NF" :size 15 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "MesloLGS NF" :size 15 :weight 'regular))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


(setq-hook! 'ruby-mode-hook +format-with-lsp nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
;;
(setq-hook! python-mode python-indent-offset 2)
(setq-hook! js-mode js-indent-level 2)
(setq-hook! ruby-mode ruby-indent-level 2)
(setq-hook! css-mode css-indent-offset 2)

(after! js2-mode
  (setq js-indent-level 2)
  (setq indent-tabs-mode nil))

;; Indent all html pages code with 2 spaces
(after! web-mode
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-script-padding 2)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)
  )

(setq-hook! web-mode web-mode-enable-auto-expanding t)
(setq-hook! web-mode web-mode-enable-auto-pairing t)
(setq-hook! web-mode web-mode-enable-current-element-highlight t)

;; (add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)
;;
;;
(after! lsp-mode
  (setq lsp-auto-guess-root t)
  (setq lsp-solargraph-symbols nil)
  (setq lsp-solargraph-folding nil))

(after! lsp-mode
  (setq lsp-ui-sideline-show-code-actions t))

;; Start code blocks on HTML with two space
(setq web-mode-style-padding 2)
(setq web-mode-script-padding 2)
(setq web-mode-block-padding 0)

(when IS-LINUX
  (font-put doom-font :weight 'regular))
(when IS-MAC
  (exec-path-from-shell-initialize)
  (setq ns-use-thin-smoothing t))

;;; Frames/Windows
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . web-mode))
(when IS-MAC
  (add-hook 'window-setup-hook #'toggle-frame-maximized))


(projectile-rails-global-mode)
;;
;
(after! projectile
  (map! :leader "r" #'projectile-rails-command-map)

  (defun load-projectile-rails ()
    (require 'projectile-rails))

  (run-at-time 2 nil 'load-projectile-rails))

(after! which-key
  (push '((nil . "projectile-rails-\\(.+\\)") . (nil . "\\1"))
        which-key-replacement-alist))

(map! :m "M-j" #'multi-next-line
      :m "M-k" #'multi-previous-line

      ;; Easier window movement
      :ni "C-h" #'evil-window-left
      :ni "C-j" #'evil-window-down
      :ni "C-k" #'evil-window-up
      :ni "C-l" #'evil-window-right

      (:map evil-treemacs-state-map
        "C-h" #'evil-window-left
        "C-l" #'evil-window-right
        "M-j" #'multi-next-line
        "M-k" #'multi-previous-line)

      :leader "h L" #'global-keycast-mode
      (:prefix "f"
        "i" #'imenu-list))

;;; copied from https://github.com/otavioschwanck/doom-emacs-on-rails/blob/master/doom-settings.el
(after! ruby-mode
        (map! :mode ruby-mode :localleader "J" 'ruby-json-to-hash-parse-json) ;; Parse the json, SPC m J
        (map! :mode ruby-mode :localleader "j" 'ruby-json-to-hash-toggle-let)) ;; Create a let or send the let back to parent. SPC m j

(after! web-mode
  (define-key web-mode-map (kbd "C-c o") #'rails-routes-insert)
  (define-key web-mode-map (kbd "C-c C-o") #'rails-routes-insert-no-cache))

(after! ruby-mode
  (map! :mode ruby-mode "C-c o" #'rails-routes-insert)
  (map! :mode ruby-mode "C-c C-o" #'rails-routes-insert-no-cache))

(after! evil
  (define-key evil-normal-state-map (kbd "g a") #'rails-routes-jump)
  (define-key evil-visual-state-map (kbd "g a") #'rails-routes-jump))

;;; end copy

;;; :tools magit
(setq magit-repository-directories '(("~/Code" . 2))
      magit-save-repository-buffers nil
      transient-values '((magit-rebase "--autosquash")
                         (magit-pull "--rebase")))

;;; :lang org
(setq org-directory "~/org/")
(setq org-agenda-category-icon-alist
          `(
            ("@inbox" ,(list (all-the-icons-faicon "inbox" :face 'all-the-icons-orange)) nil nil :ascent center)
            ("@home" ,(list (all-the-icons-faicon "home" :face 'all-the-icons-green)) nil nil :ascent center)
            ("@work" ,(list (all-the-icons-faicon "briefcase" :face 'all-the-icons-blue)) nil nil :ascent center)
            ))

(setq org-refile-targets
      '((nil :maxlevel . 1)
        (org-agenda-files :maxlevel . 1)))

(setq org-log-into-drawer "LOGBOOK")

;; (setq org-journal-dir "~/journal")

;; (setq org-roam-directory "~/org-roam/")

;; (after! org
;;   (add-to-list 'org-modules 'org-habit t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Vterm stuff

(map! :after vterm :map vterm-mode-map :ni "C-l" #'vterm-clear)

(defun better-vterm-paste ()
  (interactive)
  (+vterm-send-string (substring-no-properties (current-kill 0)) nil))

(defun better-vterm-clean ()
  (interactive)
  (vterm-send-C-c)
  (evil-insert 1))

(map! :after vterm :map vterm-mode-map :n "P" #'better-vterm-paste-before)
(map! :after vterm :map vterm-mode-map :n "p" #'better-vterm-paste)
(map! :after vterm :map vterm-mode-map :ni "M-p" #'vterm-send-up)
(map! :after vterm :map vterm-mode-map :ni "M-n" #'vterm-send-down)
(map! :after vterm :map vterm-mode-map :i "C-v" #'better-vterm-paste)
(map! :after vterm :map vterm-mode-map :i "M-v" #'better-vterm-paste)
(map! :after vterm :mode vterm-mode :n "C-c" #'better-vterm-clean)

(map! :leader "v" #'+vterm/toggle)

(defun +vterm-toggle--create-terms ()
  (+vterm/here nil)
  (+workspaces-add-current-buffer-h)
  (evil-insert 1)
  (evil-window-vsplit)
  (+vterm/here nil)
  (+workspaces-add-current-buffer-h)
  (evil-insert 1)
  (message "Terminals created.  Go back to your code with SPC TAB [ or M-1 to M-9. Switch between terminals with M-h and M-l"))

(defvar +vterm-layouts '() "Command to be executed on terminal 1")
(defvar +vterm-commands '() "Command to execute with SPC o t")

(defun +add-layout-to-term-list (command)
  "Add a layout to vterm"
  (push command +vterm-layouts))

(defun +add-command-to-term-list (command)
  "Execute the command with +vterm."
  (push command +vterm-commands))

(defun +vterm-execute-command-term ()
  (interactive)
  (let ((item (completing-read "Select command: " +vterm-commands)))
    (when (not (string= item ""))
      (let* ((item-to-run (assoc item +vterm-commands))
             (command (eval (cdr item-to-run))))
        (+vterm--create-term-with-command command item)))))

(defun +vterm--create-term-with-command (command buffer)
  "Create a vterm with specified command"
  (interactive)
  (if (member buffer (mapcar (lambda (x) (format "%s" x)) (buffer-list)))
      (switch-to-buffer buffer)
    (progn
      (+vterm/here nil)
      (+workspaces-add-current-buffer-h)
      (rename-buffer buffer t)
      (+vterm-send-string command t))))

(defun +vterm-switch-to-terminal ()
  "Go to vterm terminals."
  (interactive)
  (let* ((terminals
          (remove nil (mapcar
                       (lambda (buf)
                         (with-current-buffer buf (and (not (string-match-p ".*vterm-popup.*" (format "%s" buf))) (when (eq major-mode 'vterm-mode) buf))))
                       (buffer-list (current-buffer)))))
         (terminal-to-go (completing-read "Select the terminal: " (mapcar (lambda (x) (format "%s" x)) terminals))))
    (when (not (string= terminal-to-go ""))
      (switch-to-buffer terminal-to-go))))

(defun +vterm-send-selected-text-to-terminal ()
  (interactive)
  (call-interactively 'evil-yank)
  (let* ((terminals
          (remove nil (mapcar
                       (lambda (buf)
                         (with-current-buffer buf (when (eq major-mode 'vterm-mode) buf)))
                       (buffer-list (current-buffer)))))
         (terminal-to-go (completing-read "Select the terminal to send region: " (mapcar (lambda (x) (format "%s" x)) terminals))))

    (when (not (string= terminal-to-go ""))
      (switch-to-buffer terminal-to-go)
      (better-vterm-paste)
      (evil-insert 1))))

(map! :desc "Switch to Terminal" :n "SPC l" #'+vterm-switch-to-terminal)
(map! :desc "Send Text to Terminal" :v "SPC l" #'+vterm-send-selected-text-to-terminal)

(map! :leader "o t" #'+vterm-execute-command-term)

(defun +vterm-with-command-splitted (command-name commands)
  (interactive)
  (if (projectile-project-name)
      (+workspace-new (concat (projectile-project-name)" - " command-name " - C Terms"))
    (+workspace-new "Custom Terminals"))
  (+workspace/switch-to-final)
  (mapc (lambda (command)
          (+vterm/here nil)
          (+workspaces-add-current-buffer-h)
          (rename-buffer (concat command-name " - term") t)
          (when command
            (+vterm-send-string command t))
          (evil-insert 1)
          (unless (-contains? (last commands) command)
            (evil-window-vsplit))
          ) commands))

(defun +vterm-create-layout ()
  (interactive)
  (let* ((item (completing-read "Select a layout: " +vterm-layouts)))
    (when (not (string= item ""))
      (+vterm-with-command-splitted item (car (cdr (cdr (assoc item +vterm-layouts))))))))

(defun +vterm-send-string (string send-return)
  (mapc (lambda (c)
          (if (string= c "\n") (vterm-send-return)
            (pcase c
              (" " (vterm-send-space))
              (_ (vterm-send c)))))
        (s-split "" string t))
  (when send-return (vterm-send-return)))

(map! :leader "T" '+vterm-create-layout)

(after! vterm
  (set-popup-rule! "^\\*\\(vterm\\)?" :ttl nil :size 0.4))

(setq vterm-always-compile-module t)

;; make flycheck use bundle instead of rubocop latest version
(defun project-has-rubocop ()
  (let ((found nil))
    (cl-block find-rubocop
      (mapc (lambda (line) (when (string-match "rubocop" line) (setq found t) (cl-return-from find-rubocop)))
            (with-temp-buffer
              (insert-file-contents (concat (projectile-project-root) "Gemfile.lock"))
              (split-string (buffer-string) "\n" t))))
    found))

(defvar rubocop-append-command '("bundle" "exec")
  "Commands to run before rubocop")

(defvar disabled-checkers '("bundle" "exec")
  "Commands to run before rubocop")

(add-hook 'server-switch-hook (lambda () (select-frame-set-input-focus (selected-frame))))

(add-hook 'ruby-mode-hook
          (lambda ()
            (if (and (not (eq (projectile-project-root) nil)) (file-exists-p (concat (projectile-project-root) "Gemfile.lock")) (project-has-rubocop))
                (progn
                  (setq-local flycheck-checker 'ruby-rubocop)
                  (setq-local flycheck-command-wrapper-function
                              (lambda (command) (append rubocop-append-command command))))

              (setq-local flycheck-disabled-checkers '(ruby-reek ruby-rubylint ruby-rubocop)))))

(defvar ruby-disabled-checkers '(ruby-reek lsp ruby-rubylint) "Checkers to automatically disable on ruby files.")

(add-hook! 'ruby-mode-hook (setq-local flycheck-disabled-checkers ruby-disabled-checkers))
