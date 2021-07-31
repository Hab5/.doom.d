;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Projects Path
(projectile-add-known-project "~/Desktop/programming/c++/bitcoin")
(projectile-add-known-project "~/Desktop/programming/c++/chess-engine")
(projectile-add-known-project "~/Desktop/programming/c++/chip8")
(projectile-add-known-project "~/Desktop/programming/c++/misc")

;; Doom Related
(setq user-full-name "hab5")

(setq doom-theme 'doom-one)
;; (custom-theme-set-faces! 'doom-one
;;   '(default :background "#1e222a"))


(setq doom-font                 (font-spec :family "JetBrains Mono Nerd Font" :size 14)
      doom-big-font             (font-spec :family "JetBrains Mono Nerd Font" :size 18)
      doom-variable-pitch-font  (font-spec :family "JetBrains Mono Nerd Font" :size 14)
      doom-unicode-font         (font-spec :family "JetBrains Mono Nerd Font"))

;; General Settings
(setq-default delete-by-moving-to-trash t   ; Delete files to trash
              window-combination-resize t   ; Better resize when splitting
              x-stretch-cursor          t)  ; Stretch cursor to the glyph width

(setq undo-limit                  80000000         ; Raise undo-limit to 80Mb
      evil-want-fine-undo         t                ; Granular undo, thank god
      auto-save-default           t                ; Auto-save files
      display-line-numbers-type   'relative        ; Line number display style
      which-key-idle-delay        0.4              ; Which-key popup delay
      all-the-icons-scale-factor  1.1              ; Fix clipping on modeline (default 1.2)
      +ivy-buffer-preview         t)               ; Buffer preview

(setq doom-fallback-buffer-name "Doom"             ; Rename Dashboard buffer name
      +doom-dashboard-name "Doom")

(global-subword-mode 1) ; Iterate through CamelCase words

;; LSP Mode
(setq lsp-idle-delay              0.5  ; Delay highlights/lenses/link/etc
      company-idle-delay          0.1  ; Delay completion pop-up
      lsp-enable-indentation      nil  ; Let cc-mode deal with that
      lsp-ui-doc-show-with-cursor nil  ; Disable automatic pop-up documentation
      lsp-signature-auto-activate nil  ; Disable automatic pop-up signature
      lsp-log-io                  nil) ; For debugging?

(setq read-process-output-max     (* 1024 1024)) ; How much Emacs can read from the process
                                        ;

;; C/C++ Related
(defun c++-configuration()
  (c-set-style "stroustrup")
  (setq c-basic-offset 4))
(add-hook! 'c++-mode-hook 'c++-configuration)

;; Org Related
(setq org-directory "~/org/") ; Org Path
(defun no-line-number()
  (display-line-numbers-mode 0))
(add-hook! 'org-mode-hook 'no-line-number) ; Disable line numbers for org mode

;; Evil Related
(evil-ex-define-cmd "W" #'save-buffer) ; fatfinger acceptance

;; Leetcode
(setq leetcode-set-prefer-language "cpp")
(setq leetcode-save-solutions t)
(setq leetcode-directory "~/Desktop/programming/c++/leetcode")

;; Key Mapping
(map! :g "C-s"                #'save-buffer)                ; good ol' C-s
(map! :after evil :gnvi "C-f" #'swiper)                     ; swiper godlike
(map! :n "SPC o c"            #'compiler-explorer)          ; godbolt
(map! :n "SPC o l"            #'leetcode)                   ; leetcode
(map! :n "g h"                #'lsp-clangd-find-other-file) ; Switch between .cpp and .hpp

(map! :map evil-window-map
      "SPC"        #'rotate-layout
      ;; Navigation
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right
      ;; Swapping windows
      "C-<left>"   #'+evil/window-move-left
      "C-<down>"   #'+evil/window-move-down
      "C-<up>"     #'+evil/window-move-up
      "C-<right>"  #'+evil/window-move-right)

;; Package Configuration
(require 'dap-gdb-lldb) ; Debugger


(use-package shrface ; Extends shr/eww with org features
  :defer t
  :config
  (shrface-basic)
  (shrface-trial)
  (shrface-default-keybindings)
  (setq shrface-href-versatile t))

(use-package eww ; Render HTML as ORG files in eww
  :defer t
  :init
  (add-hook 'eww-after-render-hook #'shrface-mode)
  :config
  (require 'shrface))

(use-package shr-tag-pre-highlight ; Syntax highlighting in HTML files
  :after shr
  :config
  (add-to-list 'shr-external-rendering-functions
               '(pre . shr-tag-pre-highlight)))


(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist ; Modify which-key suggestions name
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1")) ; Replace "evil-" prefix with : ◂
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1")) ; Replace "evil-motion" prefix with : ◃
   ))


(add-hook 'Info-selection-hook 'info-colors-fontify-node) ; Pretty info pages
(add-hook 'Info-mode-hook #'mixed-pitch-mode) ;


























;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
