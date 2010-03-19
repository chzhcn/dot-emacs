;; 设置字体的函数
(defun my-default-font ()
  (interactive)
  (set-frame-font "Bitstream Vera Sans Mono-11")
  (set-fontset-font "fontset-default"
		    'han '("DejaVu Sans YuanTi" . "unicode-bmp"))
  )

(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(blink-cursor-mode t)
(my-default-font)
(mouse-avoidance-mode 'jump);光标靠近鼠标指针时，让鼠标指针自动让开
(setq mouse-yank-at-point t);支持中键粘贴
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
(setq frame-title-format "chzhcn@%b");在标题栏提示你目前在什么位置。
(setq scroll-margin 3 ;在靠近屏幕边沿3行时开始滚动，很好的看到上下文。
      scroll-conservatively 10000) 
(setq confirm-kill-emacs 'y-or-n-p)
(setq kill-ring-max 200)
(setq inhibit-startup-message t);关闭启动开机画面
(setq visible-bell t);关闭出错提示音
(setq default-major-mode 'text-mode);一打开就起用 text 模式。
(global-font-lock-mode t);语法高亮
(auto-image-file-mode t);打开图片显示功能
(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no
(show-paren-mode t);显示括号匹配
(transient-mark-mode t);允许临时设置标记
(setq default-fill-column 80);默认显示 80
;; (column-number-mode t);显示列号
;; (display-time-mode 1);显示时间，格式如下
;; (setq display-time-24hr-format t)
;; (setq display-time-day-and-date t)

(auto-compression-mode t);;Dired 自动解压

(setq outline-minor-mode-prefix [(control o)])
;; (outline-minor-mode t)

;; 显示buffer列表
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(require 'ibuf-ext)
(setq ibuffer-mode-hook
      (lambda ()
	(setq ibuffer-filter-groups
	      '(
		("elisp" (mode . emacs-lisp-mode))
		("java" (or (mode . jde-mode)
			    (mode . java-mode)))
		("dired" (mode . dired-mode))
		("tex" (name . ".*TeX.*"))
		("*util*" (name . "\*.*\*"))
		("shell" (mode . shell-script-mode))
		("text" (mode . text-mode))
		("C" (or (mode . c-mode)
			 (mode . c++-mode)))
		;; ("perl" (or (mode . cperl-mode)
		;; 			(mode . sepia-mode)
		;; 			(mode . perl-mode)))
		))))
(defun ywb-ibuffer-rename-buffer ()
  (interactive)
  (call-interactively 'ibuffer-update)
  (let* ((buf (ibuffer-current-buffer))
	 (name (generate-new-buffer-name
		(read-from-minibuffer "Rename buffer (to new name): "
				      (buffer-name buf)))))
    (with-current-buffer buf
      (rename-buffer name)))
  (call-interactively 'ibuffer-update))
(define-key ibuffer-mode-map "r" 'ywb-ibuffer-rename-buffer)

(require 'ido)
(ido-mode t)

(require 'linum)
(global-linum-mode t)

;; not fully configured. read the doc
;; (autoload 'ctypes "/home/chzhcn/Development/myEmacs/ctypes.el")

;; (load-file "/home/chzhcn/Development/myEmacs/ctypes.el")
;; (require 'ctypes)
;; (ctypes-auto-parse-mode 1)

(load "desktop")			
(desktop-save-mode 1)

(add-to-list 'load-path "/home/chzhcn/Development/myEmacs")
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode)) ;

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(add-hook 'espresso-mode-hook 'espresso-custom-setup)
(defun espresso-custom-setup ()
  (moz-minor-mode 1))

(require 'browse-kill-ring)
;; (global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(require 'pabbrev)
(global-pabbrev-mode t)
(setq pabbrev-idle-timer-verbose nil)

(add-to-list 'load-path "/home/chzhcn/Development/myEmacs/emacs-jabber-0.8.0")
(load "jabber-autoloads")
(setq special-display-regexps 
	  '(("jabber-chat" 
		 (width . 60)
		 ;; (scroll-bar-width . 16)
		 (height . 15)
		 (tool-bar-lines . 0)
		 (menu-bar-lines 0)
		 ;; (font . "-GURSoutline-Courier New-normal-r-normal-normal-11-82-96-96-c-70-iso8859-1")
		 (left . 80))))
(add-hook 'jabber-chat-mode-hook 'goto-address)
(setq jabber-chat-header-line-format
      '(" " (:eval (jabber-jid-displayname jabber-chatting-with))
    	" " (:eval (jabber-jid-resource jabber-chatting-with)) "\t";
    	(:eval (let ((buddy (jabber-jid-symbol jabber-chatting-with)))
		 (propertize
		  (or
		   (cdr (assoc (get buddy 'show) jabber-presence-strings))
		   (get buddy 'show))
		  'face
		  (or (cdr (assoc (get buddy 'show) jabber-presence-faces))
		      'jabber-roster-user-online))))
    	"\t" (:eval (get (jabber-jid-symbol jabber-chatting-with) 'status))
    	(:eval (unless (equal "" *jabber-current-show*)
		 (concat "\t You're " *jabber-current-show*
			 " (" *jabber-current-status* ")")))))

(require 'autosmiley)
(add-hook 'jabber-chat-mode-hook 'autosmiley-mode)

;; (require 'highlight-tail)
;; ;; (setq highlight-tail-colors '(("white" . 0)))
;; (setq highlight-tail-colors '(;; ("black" . 0)
;;                               ("#bc2525" . 0)
;;                               ("black" . 66)))
;; (highlight-tail-mode t)

(global-hl-line-mode t)

(add-to-list 'load-path "/usr/share/doc/git-core/contrib/emacs/")
;; (require 'git)

(add-to-list 'load-path "/home/chzhcn/Development/myEmacs/git-emacs")
;; (fmakunbound git-status)
(require 'git-emacs-autoloads)
;; (require 'git-status)
(require 'git-modeline)

(add-to-list 'load-path "/home/chzhcn/Development/myEmacs/egit")
(autoload 'egit "egit" "Emacs git history" t)
(autoload 'egit-file "egit" "Emacs git history file" t)
(autoload 'egit-dir "egit" "Emacs git history directory" t)



;; (require 'git-emacs)
;; (require 'git-modeline)

;; (add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
;; (add-to-list 'load-path "/usr/local/etc/emacs/site-start.d")
;; (require 'magit)

(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; (require 'tabbar)
;; (tabbar-mode 1)
;; (global-set-key (kbd "C-c C-9") 'tabbar-backward)      ;前翻
;; (global-set-key (kbd "C-c C-0") 'tabbar-forward)
;; (global-set-key (kbd "C-c C-7") 'tabbar-backward-group)
;; (global-set-key (kbd "C-c C-8") 'tabbar-forward-group)

;; nxhtml
(load "/home/chzhcn/Development/myEmacs/nxhtml/autostart.el")

;; (require 'color-theme)
;; ;; (load-file "/home/chzhcn/Development/myEmacs/color-theme.el")
;; (color-theme-euphoria);taming-mr-arneson可选，我暂选的这个
;; (add-to-list 'load-path "/home/chzhcn/Development/myEmacs/color-theme-6.6.0/color-theme.el")
;; (require 'color-theme)
;; (eval-after-load "color-theme"
;;   '(progn
;; 	 ;; (setq color-theme-is-global t)
;;      (setq color-theme-is-global t)
;;      (color-theme-initialize)
;;      (color-theme-euphoria)))


;; 有关界面和字体的配置
(add-hook 'after-make-frame-functions
          (lambda (new-frame)
            (select-frame new-frame)
            ;; (tool-bar-mode 0)
            ;; (scroll-bar-mode 0)
	    ;; (menu-bar-mode 0)
            (my-default-font)
	    ;; (mouse-avoidance-mode 'jump);光标靠近鼠标指针时，让鼠标指针自动让开
	    ;; (setq mouse-yank-at-point t);支持中键粘贴
	    ;; (setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
	    ;; (setq frame-title-format "chzhcn@%b");在标题栏提示你目前在什么位置。
	    ;; (setq scroll-margin 3 ;在靠近屏幕边沿3行时开始滚动，很好的看到上下文。
	    ;; 	  scroll-conservatively 10000) 
	    ))

(require 'w3m)
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m-load" "Ask a WWW browser to show a URL." t)
;; (global-set-key "\C-xv" 'w3m-browse-url)
(setq w3m-use-cookies t)

(defvar w3m-isearch-links-do-wrap nil
  "Used internally for fast search wrapping.")

(defun w3m-isearch-links (&optional regexp)
  (interactive "P")
  (let ((isearch-wrap-function
	 #'(lambda ()
	     (setq w3m-isearch-links-do-wrap nil)
	     (if isearch-forward
		 (goto-char (window-start))
	       (goto-char (window-end)))))
	(isearch-search-fun-function
	 #'(lambda () 'w3m-isearch-links-search-fun))
	post-command-hook		;inhibit link echoing
	do-follow-link
	(isearch-mode-end-hook
	 (list  #'(lambda nil
		    (when (and (not isearch-mode-end-hook-quit)
			       (w3m-anchor))
		      (setq do-follow-link t))))))
    (setq w3m-isearch-links-do-wrap t)
    (isearch-mode t
		  regexp
		  ;; fast wrap
		  #'(lambda nil
		      (if isearch-success
			  (setq w3m-isearch-links-do-wrap t)
			(when w3m-isearch-links-do-wrap
			  (setq w3m-isearch-links-do-wrap nil)
			  (setq isearch-forward
				(not isearch-forward))
			  (isearch-repeat isearch-forward))))
		  t)
    (when do-follow-link
      (w3m-view-this-url))))

(defun w3m-isearch-links-search-fun (string &optional bound no-error)
  (let* (isearch-search-fun-function
	 (search-fun  (isearch-search-fun))
	 error
	 (bound  (if isearch-forward
		     (max (or bound 0)
			  (window-end))
		   (min (or bound (window-start))
			(window-start)))))
    (condition-case err
	(while (and (apply search-fun (list string bound))
		    (not (w3m-anchor (point)))))
      (error (setq error err)))
    (if error
	(if (not no-error)
	    (signal (car error) (cadr error)))
      (point))))

(defun w3m-link-numbering (&rest args)
  "Make overlays that display link numbers."
  (when w3m-link-numbering-mode
    (save-excursion
      (goto-char (point-min))
      (let ((i 0)
            overlay num)
        (catch 'already-numbered
          (while (w3m-goto-next-anchor)
            (when (get-char-property (point) 'w3m-link-numbering-overlay)
              (throw 'already-numbered nil))
            (setq overlay (make-overlay (point) (1+ (point)))
                  num (format "[%d]" (incf i)))
            (w3m-static-if (featurep 'xemacs)
                (progn
                  (overlay-put overlay 'before-string num)
                  (set-glyph-face (extent-begin-glyph overlay)
                                  'w3m-link-numbering))
              (w3m-add-face-property 0 (length num) 'w3m-link-numbering num)
              (overlay-put overlay 'before-string num)
              (overlay-put overlay 'evaporate t))
            (overlay-put overlay 'w3m-link-numbering-overlay i)))))))

(define-key w3m-mode-map [?f] 'w3m-isearch-links)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cw" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(add-to-list 'load-path "/home/chzhcn/Development/myEmacs/cedet/common")
(require 'cedet)
(require 'semantic-lex-spp)
(require 'semantic-decorate-include)
(require 'semantic-ia)
(require 'semanticdb)
(require 'eassist)
(require 'semantic-java)
(require 'semantic-gcc)

(global-ede-mode t)
(semantic-load-enable-excessive-code-helpers)
(setq senator-minor-mode-name "SN")
(setq semantic-imenu-auto-rebuild-directory-indexes nil)
(global-srecode-minor-mode 1)
(global-semantic-mru-bookmark-mode 1)
(global-semanticdb-minor-mode 1)
(setq global-semantic-tag-folding-mode t)
(setq global-semantic-idle-summary-mode nil)
;; (semantic-add-system-include "~/Development/jdk1.6.0_12/lib/" 'jde-mode)

(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local erlang-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))

;; if you want to enable support for gnu global
;; (require 'semanticdb-global)
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)

;; enable ctags for some languages:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; (require 'semanticdb-ectag)
;; (semantic-load-enable-primary-exuberent-ctags-support)

;; (ede-cpp-root-project "k&r C Ex"
;;                 :name "k&r C Ex"
;;                 :file "~/workspace/C-Ex/TAGS"
;;                 ;; :include-path '("/"
;;                 ;;                 "/Common"
;;                 ;;                 "/Interfaces"
;;                 ;;                 "/Libs"
;;                 ;;                )
;;                 :system-include-path '("/usr/include"
;; 				       "/usr/local/include"
;; 				       )
;;                 :spp-table '(("isUnix" . "")
;;                              ("BOOST_TEST_DYN_LINK" . "")))

(defun my-cedet-hook ()
  ;; (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  ;; (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  ;; (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  ;; (local-set-key "\C-xt" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref))
(add-hook 'c-mode-common-hook 'my-cedet-hook)

(defun my-c-mode-cedet-hook ()
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert)
)
(add-hook 'c-mode-hook 'my-c-mode-cedet-hook)
(add-hook 'c++-mode-hook 'my-c-mode-cedet-hook)

					;CEDET
;; (add-hook 'texinfo-mode-hook (lambda () (require 'sb-texinfo)))
;; (load-file "/home/chzhcn/Development/myEmacs/cedet-1.0pre6/common/cedet.el")
;; (semantic-load-enable-code-helpers)
;; (autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
;; (autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
;; (define-key-after (lookup-key global-map [menu-bar tools])
;;   [speedbar]
;;   '("Speedbar" .
;;     speedbar-frame-mode)
;;   [calendar])

;; ;;;C/C++语言启动时自动加载semantic对/usr/include的索引数据库
;; (setq semanticdb-search-system-databases t)
;; (add-hook 'c-mode-common-hook
;; 	  (lambda ()
;;             (setq semanticdb-project-system-databases
;;                   (list (semanticdb-create-database
;; 			 semanticdb-new-database-class
;; 			 "/usr/include")))))

;; ;;ecb
(add-to-list 'load-path "/home/chzhcn/Development/myEmacs/ecb-2.40")
(require 'ecb-autoloads)

;; (autoload  'ecb-activate "ecb" "activate the ECB" t nil)
(setq ecb-auto-activate nil
      ecb-tip-of-the-day nil
      ecb-tree-indent 1
      ecb-windows-height 0.5
      ecb-windows-width 0.15
      ecb-auto-compatibility-check nil
      ecb-version-check nil)
;; ;;运行M-x ecb-byte-complie编译，可以加快运行速度
;; ;;M-x ecb-show-help看在线帮助

(load-library "hideshow")
;; (add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'nxhtml-mode-hook 'hs-minor-mode)
;; (add-hook 'c++-mode-hook 'hs-minor-mode)
;; (add-hook 'java-mode-hook 'hs-minor-mode)
;; (add-hook 'jde-mode-hook 'hs-minor-mode)
;; (add-hook 'perl-mode-hook 'hs-minor-mode)
;; (add-hook 'php-mode-hook 'hs-minor-mode)

(global-set-key (kbd "M-\[") 'hs-hide-block)              ; 隐藏块
(global-set-key (kbd "M-\]") 'hs-show-blOCK)              ; 显示块
(global-set-key (kbd "C-c C-h C-l") 'hs-hide-level)
(global-set-key (kbd "C-c C-h C-s") 'hs-show-all)
(global-set-key (kbd "C-c C-h C-h") 'hs-hide-all)
(global-set-key (kbd "C-c C-h C-t") 'hs-toggle-hiding)
;;能把一个代码块缩起来，需要的时候再展开

(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")
	    ;; Set dired-x global variables here.  For example:
	    ;; (setq dired-guess-shell-gnutar "gtar")
	    ;; (setq dired-x-hands-off-my-keys nil)
	    ))
(add-hook 'dired-mode-hook
	  (lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
	    ;; (dired-omit-mode 1)
	    ))

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'LaTeX-install-toolbar)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; (add-hook 'LaTeX-mode-hook 'outline-minor-mode)
(add-hook 'TeX-mode-hook (lambda ()
						   (TeX-fold-mode 1)))
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.

; JDEE 2.4.0
;; (add-to-list 'load-path "/home/chzhcn/Development/myEmacs/cedet/common")
(add-to-list 'load-path "/home/chzhcn/Development/myEmacs/elib-1.0")
(add-to-list 'load-path "/home/chzhcn/Development/myEmacs/jdee-2.4.0/lisp")

;; load autoloads file
(load "jde-autoload")
;; (setq jde-web-browser "google-chrome")
(setq jde-doc-dir "/home/chzhcn/Development/jdk1.6.0_12/docs")

;;设置自动补全
;;如果在单词中间就补齐，否则就是tab
;;这个方法不用了
;; (defun my-indent-or-complete ()
;;   (interactive)
;;   (if (looking-at "\\>")
;;       (hippie-expand nil)
;;     (indent-for-tab-command)))

(global-set-key (kbd "M-/") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(
		senator-try-expand-semantic
		semantic-ia-complete-symbol			;test!!!!
		senator-complete-symbol
		try-expand-dabbrev
		try-expand-dabbrev-visible
		try-expand-dabbrev-from-kill
		try-expand-dabbrev-all-buffers
		;; try-expand-list
		;; try-expand-list-all-buffers
		;; try-expand-line
		;; try-expand-line-all-buffers
		;; try-complete-file-name-partially
		;; try-complete-file-name
		;; try-expand-whole-kill
		)
      )

(defun ywb-clone-buffer (non-indirect)
  "If with prefix argument, clone buffer, other wise, clone indirect buffer"
  (interactive "P")
  (if non-indirect
      (call-interactively 'clone-buffer)
    (let ((indir-bufs (mapcar (lambda (buf) (cons buf (buffer-base-buffer buf)))
                              (remove-if-not 'buffer-base-buffer (buffer-list))))
          buf)
      (if (setq buf (assoc (current-buffer) indir-bufs))
          (select-window (display-buffer (cdr buf)))
        (if (setq buf (rassoc (current-buffer) indir-bufs))
            (select-window (display-buffer (car buf)))
          (setq current-prefix-arg nil)
          (call-interactively 'clone-indirect-buffer-other-window))))))
;; (global-set-key "\C-xc" 'ywb-clone-buffer)

(defun zc-go-to-char-forward (n char)
  "Move forward to Nth occurence of CHAR.
Typing `zc-go-to-char-key-forward' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char forward: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
					 char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
(define-key global-map (kbd "C-c s") 'zc-go-to-char-forward)

(defun zc-go-to-char-backward (n char)
  "Move backward to Nth occurence of CHAR.
Typing `zc-go-to-char-key-backward' again will move backward to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char backward: ")
  (search-backward (string char) nil nil n)
  (while (char-equal (read-char)
					 char)
    (search-backward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
(define-key global-map (kbd "C-c r") 'zc-go-to-char-backward)

(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line"
  (interactive "P")
  (let ((beg (line-beginning-position)) 
		(end (line-end-position arg)))
    (copy-region-as-kill beg end))
  )

(defun copy-word (&optional arg)
  "Copy words at point"
  (interactive "P")
  (let ((beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point))) 
		(end (progn (forward-word arg) (point))))
    (copy-region-as-kill beg end))
  )

;; function is not corrent when point is at the beginning of a paragraph
(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (let ((beg (progn (backward-paragraph 1) (point))) 
		(end (progn (forward-paragraph arg) (point))))
    (copy-region-as-kill beg end))
  )
;; (global-set-key (kbd "C-c w") 'copy-word)
(global-set-key (kbd "C-c l") 'copy-line)
;; (global-set-key (kbd "C-c p") 'copy-paragraph)

(add-hook 'write-file-hooks 'time-stamp)
;; (setq time-stamp-format "%:u %02m/%02d/%04y %02H:%02M:%02S")

;; c-mode设置
;; c-mode公共设置
(defun my-c-mode-common-hook ()
  (setq default-tab-width 4)
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (hs-minor-mode t)
  (hl-line-mode t)
  (c-toggle-auto-hungry-state)
  (semantic-idle-summary-mode nil))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; C语言设置
(defun my-c-mode-hook ()
  (c-set-style "k&r"))
(add-hook 'c-mode-hook 'my-c-mode-hook)

;; C++设置
(defun my-c++-mode-hook ()
  (c-set-style "stroustrup"))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(defun my-java-mode-hook ()
  ;; (hs-minor-mode t)
  (c-set-style "java")
  ;; (local-set-key "." 'jde-complete)
  (cond (window-system
	 (require 'andersl-java-font-lock)
	 (turn-on-font-lock))))
(add-hook 'jde-mode-hook 'my-java-mode-hook)
(setq font-lock-maximum-decoration t)

(defun my-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
			       ;; (?` ?` _ "''")
			       ;; (?\( ?  _ " )")
			       ;; (?\[ ?  _ " ]")
			       ;;(?` ?` _ "''")  去掉，不知道什么用途，测试
			       ;; (?\(?  _ ")");去掉一个空格，测试，前面也去掉一个
			       ;; (?\[?  _ "]");去掉一个空格，测试，前面也去掉一个
			       (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe);加的，测试
  (local-set-key (kbd "\'") 'skeleton-pair-insert-maybe);加的，测试    
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  ;;去掉，测试  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-common-hook 'my-c-mode-auto-pair)
;; (add-hook 'c++-mode-hook 'my-c-mode-auto-pair)
(add-hook 'java-mode-hook 'my-c-mode-auto-pair)
(add-hook 'espresso-mode-hook 'my-c-mode-auto-pair)
;;输入左边的括号，就会自动补全右边的部分.包括(), "", [] , {} , 等等。 

(defun my-LaTeX-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
			       ;; (?` ?` _ "''")
			       ;; (?\( ?  _ " )")
			       ;; (?\[ ?  _ " ]")
			       ;;(?` ?` _ "''")  去掉，不知道什么用途，测试
			       ;; (?\(?  _ ")");去掉一个空格，测试，前面也去掉一个
			       ;; (?\[?  _ "]");去掉一个空格，测试，前面也去掉一个
			       ;; (?{ \n > _ \n ?} >)
			       ))
  (setq skeleton-pair t)
  (local-set-key (kbd "$ ") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  ;; (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  ;; (local-set-key (kbd "\'") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  ;;去掉，测试  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
(add-hook 'LaTeX-mode-hook 'my-LaTeX-mode-auto-pair)

;; (server-start)

;;HOT KEY
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
;;保留F3、F4、F5、F6、F7、F8 for Xrefactory
(global-set-key [f1] 'shell)                              ; 进入shell
(global-set-key [f9] 'gdb)                              ; 调试
(setq compile-command "gcc -o")
(global-set-key [f7] 'compile)
(global-set-key [f8] 'recompile)
(global-set-key [f2] 'speedbar)                          ; 启动/关闭speedba
(global-set-key "\C-xk" 'kill-this-buffer)                ; 关闭当前buffer

;; (global-set-key [f11] 'comment-or-uncomment-region)     ; 注释 / 取消注释
;; (global-set-key [f12] 'c-indent-line-or-region)           ; 格式化代码
;; (global-set-key (kbd "C-x r") 'redo) 
;; (global-set-key [M-return] 'delete-other-windows)         ; 关闭其他窗口
;(global-set-key (kbd "s-SPC") 'set-mark-command)          ; 改变set mark键
;; 跳转到寄存器指定的位置
;(global-set-key "\C-xj" 'jump-to-register)
;; 跳转到全局定义
;(global-set-key "\C-xg" 'cscope-find-global-definition-no-prompting)
;(global-set-key [tab] 'my-indent-or-complete)     ;自动补全或缩进;暂时注释，不用了
;;(global-set-key [(control return)] 'senator-complete-symbol);


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-newline-function (quote reindent-then-newline-and-indent))
 '(ecb-options-version "2.40")
 '(git-state-modeline-decoration (quote git-state-decoration-colored-letter))
 '(global-semantic-decoration-mode t nil (semantic-decorate-mode))
 '(global-semantic-highlight-edits-mode nil nil (semantic-util-modes))
 '(global-semantic-highlight-func-mode t nil (semantic-util-modes))
 '(global-semantic-idle-scheduler-mode t nil (semantic-idle))
 '(global-semantic-mru-bookmark-mode t nil (semantic-util-modes))
 '(global-semantic-show-parser-state-mode nil nil (semantic-util-modes))
 '(global-semantic-show-unmatched-syntax-mode nil nil (semantic-util-modes))
 '(global-semantic-stickyfunc-mode nil nil (semantic-util-modes))
 '(global-semantic-tag-folding-mode t nil (semantic-util-modes))
 '(global-senator-minor-mode t nil (senator))
 '(jabber-account-list (quote (("chzhcn88@gmail.com"))))
 '(jabber-default-show "dnd")
 '(jde-ant-args "-emacs")
 '(jde-ant-buildfile "build.xml")
 '(jde-ant-enable-find t)
 '(jde-ant-program "ant")
 '(jde-ant-target-regexp "<\\s-*target\\s-[^...]*?name\\s-*=\\s-*\"\\s-*\\([^\"]+\\)")
 '(jde-build-function (quote (jde-ant-build)))
 '(jde-compile-option-hide-classpath t)
 '(jde-complete-function (quote jde-complete-minibuf))
 '(jde-electric-return-p nil)
 '(jde-enable-abbrev-mode t)
 '(jde-gen-ant-buildfile-buffer-template (quote ("\"<?xml version=\\\"1.0\\\" encoding=\\\"UTF-8\\\"?>\" 'n" "\"<project name=\\\"\" jde-project-name \"\\\" default=\\\"compile\\\" basedir=\\\".\\\">\" 'n" "\"\" 'n" "\"  <!-- If you want use ecj compiler, uncomment the next line  -->\" 'n" "\"  <!--   <property name=\\\"build.compiler\\\" value=\\\"org.eclipse.jdt.core.JDTCompilerAdapter\\\"/> -->\" 'n" "\"\" 'n" "\"  <!-- set global properties for this build -->\" 'n" "\"  <property name=\\\"src\\\"     location=\\\"src\\\"/>\" 'n" "\"  <property name=\\\"classes\\\" location=\\\"bin\\\"/>\" 'n" "\"  <property name=\\\"pkg\\\"     location=\\\"\" jde-project-name \".jar\\\"/>\" 'n" "\"  <property name=\\\"docs\\\"    location=\\\"docs\\\"/>\" 'n" "\"\" 'n" "\"  <property name=\\\"compile.debug\\\"       value=\\\"true\\\"/>\" 'n" "\"  <property name=\\\"compile.encoding\\\"    value=\\\"\" (if (not (string= jde-compile-option-encoding \"\")) jde-compile-option-encoding) \"\\\"/>\" 'n" "\"  <property name=\\\"compile.deprecation\\\" value=\\\"false\\\"/>\" 'n" "\"  <property name=\\\"compile.optimize\\\"    value=\\\"true\\\"/>\" 'n" "\"\" 'n" "\"  <path id=\\\"compile.classpath\\\">\" 'n" "\"    <pathelement path=\\\"\" (if (string= (jde-build-classpath jde-global-classpath) \"\") \".\" (jde-build-classpath jde-global-classpath)) \"\\\"/>\" 'n" "\"  </path>\" 'n" "\"\" 'n" "\"  <target name=\\\"init\\\">\" 'n" "\"    <mkdir dir=\\\"${classes}\\\"/>\" 'n" "\"    <mkdir dir=\\\"${docs}\\\"/>\" 'n" "\"  </target>\" 'n" "\"\" 'n" "\"  <target name=\\\"compile\\\" depends=\\\"init\\\" description=\\\"Compile the source\\\">\" 'n" "\"    <javac srcdir=\\\"${src}\\\"\" 'n" "\"           destdir=\\\"${classes}\\\"\" 'n" "(if (not (string= jde-compile-option-encoding \"\")) \"           encoding=\\\"${compile.encoding}\\\"\")" "(if (not (string= jde-compile-option-encoding \"\")) 'n)" "\"           debug=\\\"${compile.debug}\\\"\" 'n" "\"           deprecation=\\\"${compile.deprecation}\\\"\" 'n" "\"           optimize=\\\"${compile.optimize}\\\">\" 'n" "\"      <classpath refid=\\\"compile.classpath\\\"/>\" 'n" "\"      <!-- If you want use ecj compiler ant want setting compile options,\" 'n" "\"           you can uncomment the following and modify compile options\" 'n" "\"      -->\" 'n" "\"      <!--       <compilerarg  -->\" 'n" "\"      <!--           compiler=\\\"org.eclipse.jdt.core.JDTCompilerAdapter\\\"  -->\" 'n" "\"      <!--           line=\\\"-warn:+unused -Xemacs\\\"/> -->\" 'n" "\"    </javac>\" 'n" "\"  </target>\" 'n" "\"\" 'n" "\"  <target name=\\\"build\\\" depends=\\\"compile\\\"\" 'n" "\"          description=\\\"Generate the distribution\\\">\" 'n" "\"    <jar jarfile=\\\"${pkg}\\\" basedir=\\\"${classes}\\\"/>\" 'n" "\"  </target>\" 'n" "\"\" 'n" "\"  <target name=\\\"clean\\\" description=\\\"Clean up\\\" >\" 'n" "\"    <delete file=\\\"${build}/${pkg}\\\"/>\" 'n" "\"    <delete dir=\\\"${classes}\\\"/>\" 'n" "\"  </target>\" 'n" "\"\" 'n" "\"  <target name=\\\"rebuild\\\" depends=\\\"clean, build\\\" description=\\\"Rebuild\\\">\" 'n" "\"  </target>\" 'n" "\"\" 'n" "\"  <target name=\\\"javadoc\\\" depends=\\\"init\\\" description=\\\"Create java doc\\\">\" 'n" "\"    <javadoc destdir=\\\"${docs}\\\">\" 'n" "\"      <fileset dir=\\\"${src}\\\">\" 'n" "\"        <include name=\\\"**/*.java\\\"/>\" 'n" "\"        <!--         <exclude name=\\\"**/*Test*\\\"/> -->\" 'n" "\"      </fileset>\" 'n" "\"      <classpath refid=\\\"compile.classpath\\\"/>\" 'n" "\"    </javadoc>\" 'n" "\"  </target>\" 'n" "\"\" 'n" "\"</project>   \" 'n")))
 '(jde-help-browser-function "w3m-browse-url")
 '(jde-help-docsets (quote (("JDK API" "$JAVA_HOME/docs/api" ignore) ("JDK API" "$JUNIT_HOME/javadoc" ignore))))
 '(jde-imenu-include-modifiers t)
 '(jde-jdk-registry (quote (("1.6.0_12" . "/home/chzhcn/Development/jdk1.6.0_12"))))
 '(jde-quote-classpath nil)
 '(popcmp-completion-style (quote emacs-default))
 '(semantic-complete-inline-analyzer-displayor-class (quote semantic-displayor-traditional-with-focus-highlight))
 '(semantic-complete-inline-analyzer-idle-displayor-class (quote semantic-displayor-ghost))
 '(semantic-idle-scheduler-idle-time 0.2)
 '(semantic-idle-scheduler-work-idle-time 600)
 '(semantic-idle-work-update-headers-flag nil)
 '(semantic-java-dependency-system-include-path (quote ("~/Development/jdk1.6.0_12/lib")))
 '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol (point))))
 '(semantic-tag-folding-fringe-image-style (quote triangles))
 '(semantic-tag-folding-show-tooltips t)
 '(semantic-tag-folding-tag-higlight-time 2)
 '(tempo-interactive nil)
 '(which-function-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'set-goal-column 'disabled nil)

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)

(put 'scroll-left 'disabled nil)