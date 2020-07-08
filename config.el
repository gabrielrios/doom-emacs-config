;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Gabriel Rios"
      user-mail-address "gabrielfalcaorios@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Fira Code" :size 15 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/OneDrive/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


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
(setq-hook! js2-mode js2-indent-level 2)

;; Indent all html pages code with 2 spaces
(setq-hook! web-mode web-mode-markup-indent-offset 2)
(setq-hook! web-mode web-mode-css-indent-offset 2)
(setq-hook! web-mode web-mode-code-indent-offset 2)

;; Start code blocks on HTML with two space
(setq web-mode-style-padding 2)
(setq web-mode-script-padding 2)
(setq web-mode-block-padding 0)

(setq web-mode-engines-alist
      '(("ruby"    . "\\.rhtml\\'"))
)

(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . web-mode))

(when IS-LINUX
  (font-put doom-font :weight 'semi-light))
(when IS-MAC
  (exec-path-from-shell-initialize)
  (setq ns-use-thin-smoothing t))

;;; Frames/Windows
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(when IS-MAC
  (add-hook 'window-setup-hook #'toggle-frame-maximized))


(projectile-rails-global-mode)

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
      :leader "n j" #'org-journal-new-entry
      (:prefix "f"
        "t" #'find-in-dotfiles
        "T" #'browse-dotfiles))

;;; :tools magit
(setq magit-repository-directories '(("~/Code" . 2))
      magit-save-repository-buffers nil
      transient-values '((magit-rebase "--autosquash")
                         (magit-pull "--rebase")))

;;; :lang org
(setq org-directory "~/OneDrive/org/"
      org-ellipsis " ▼ ")
(setq org-journal-dir "~/OneDrive/journal")

(after! org
  (add-to-list 'org-modules 'org-habit t))



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
