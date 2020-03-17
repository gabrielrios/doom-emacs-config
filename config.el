;;; .doom.d/config.el -*- lexical-binding: t; -*-

;;; UI

(setq doom-font (font-spec :family "Fira Code" :size 15)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 13))

(setq indent-tabs-mode nil
      js-indent-level 2)

;; (projectile-rails-global-mode)

(when IS-LINUX
  (font-put doom-font :weight 'semi-light))
(when IS-MAC
  (exec-path-from-shell-initialize)
  (setq ns-use-thin-smoothing t))

;;; Frames/Windows
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(when IS-MAC
  (add-hook 'window-setup-hook #'toggle-frame-maximized))

(setq display-line-numbers-type 'relative)
;;; Custom modeline
;; (load! "lisp/modeline")
;;
(customize-set-variable 'org-journal-dir "~/OneDrive/org/")
(customize-set-variable 'org-journal-file-format "%Y%m%d.org")

;; (setq inf-ruby-console-environment "development")

;;
;;; Keybinds

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


;;
;;; Modules

;;; :ui pretty-code
(setq +pretty-code-enabled-modes '(emacs-lisp-mode))

;;; :tools magit
(setq magit-repository-directories '(("~/code" . 2))
      magit-save-repository-buffers nil
      transient-values '((magit-rebase "--autosquash")
                         (magit-pull "--rebase")))

;;; :lang org
(setq org-directory "~/OneDrive/org/"
      org-ellipsis " ▼ ")
(after! org
  (add-to-list 'org-modules 'org-habit t))

(defun web-mode-indent-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'web-mode-indent-hook)


;;
;;; Frameworks

;; (def-project-mode! +javascript-screeps-mode
;;   :match "/screeps\\(?:-ai\\)?/.+$"
;;   :modes (+javascript-npm-mode)
;;   :add-hooks (+javascript|init-screeps-mode)
;;  :on-load (load! "lisp/screeps"))
