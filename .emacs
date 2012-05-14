(setq load-path
      (append
       (list
       (expand-file-name "~/.elisp/")
       )
       load-path))

;C言語のインデントを4桁に
(setq-default c-basic-offset 4)

;Javascript向け設定
;https://github.com/mooz/js2-mode を使用
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


;;Ruby向け設定
(autoload 'ruby-mode "ruby-mode"
  "Ruby editing mode")
(add-to-list 'auto-mode-alist '("\\.rb" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(autoload 'run-ruby "inf-ruby" "")
(autoload 'inf-ruby-keys "inf-ruby" "")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
             ))

;; Lua向け設定
;; http://immerrr.github.com/lua-mode/ をインストール
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))


;; markdown記法向け設定
;; http://jblevins.org/projects/markdown-mode/ をインストール
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))


;; タブ, 全角スペース、改行直前の半角スペースを表示する
;;(defface my-face-r-1 '((t (:background "gray15"))) nil)
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;;(defvar my-face-r-1 'my-face-r-1)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-u-1 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-b-1 append)
     ;;("[\r]*\n" 0 my-face-r-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

; インデントにタブを使用しない
(setq-default indent-tabs-mode nil)

(add-hook 'c-mode-hook
          (lambda () (c-set-style "cc-mode")))
(add-hook 'c++-mode-hook
          (lambda () (c-set-style "cc-mode")))


; termの設定
(require 'term)

(global-set-key "\C-t" '(lambda ()(interactive)(ansi-term "/bin/bash")))

(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
(function
(lambda ()
(define-key term-raw-map "\C-t" '(lambda ()(interactive)(ansi-term "/bin/bash"))))))

(defadvice ansi-term (after ansi-term-after-advice (arg))
"run hook as after advice"
(run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)
