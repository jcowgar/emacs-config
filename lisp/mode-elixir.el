;;; mode-elixir.el --- Configure Elixir Mode      -*- lexical-binding: t; -*-

;; Copyright (C) 2023-2025  Jeremy Cowgar

;; Author: Jeremy Cowgar <jeremy@cowgar.com>
;; Keywords: local

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(defun jc/elixir-alternate ()
  "Goto the test file associated with this file.

This is a naive implementation. It simply searches for `/lib/' or
`/test/'. It then does a simple search/replace on the path to the
other and also changes the extension between `.ex' and
`_test.exs'."
  (interactive)

  (if (string-match-p (regexp-quote "/lib/") buffer-file-name)
      (jc/elixir-find-test-file)
    (jc/elixir-find-code-file)))

(defun jc/elixir-find-test-file ()
  "From an Elixir code file, find the test file."
  (let* ((dir-replaced (string-replace "/lib/" "/test/" (buffer-file-name)))
	 (test-filename (string-replace ".ex" "_test.exs" dir-replaced)))
    (find-file test-filename)))

(defun jc/elixir-find-code-file ()
  "From an Elixir test file, find the code file."
  (let* ((dir-replaced (string-replace "/test/" "/lib/" (buffer-file-name)))
	 (test-filename (string-replace "_test.exs" ".ex" dir-replaced)))
    (find-file test-filename)))

(defun jc/elixir-mode-setup ()
  "Configure elixir-mode to my liking."
  (setq-local tab-width 2
	      indent-tabs-mode nil
              devdocs-current-docs '("elixir~1.18"))
  (require 'flymake-credo)

  (flymake-mode 1)         ;; lsp/linter feedback
  (eglot-ensure)           ;; turn on the lsp engine for this buffer
  (flymake-credo-load)     ;; specific credo backend for flymake

  ;; make sure to format my code before saving it. All the Elixir LSP
  ;; engines support this now.

  (add-hook 'before-save-hook #'eglot-format-buffer nil t))

(use-package heex-ts-mode)

(use-package elixir-ts-mode
  :after eglot
  :init
  (require 'elixir-ts-mode)

  (add-to-list 'major-mode-remap-alist
	       '(elixir-mode . elixir-ts-mode))

  (add-to-list 'eglot-server-programs
               '(elixir-ts-mode "~/Projects/other/elixir-ls/release/language_server.sh"))

  (add-to-list 'auto-mode-alist '("\\.ex?\\'" . elixir-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.exs?\\'" . elixir-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.heex?\\'" . elixir-ts-mode))

  (add-hook 'elixir-ts-mode-hook 'jc/elixir-mode-setup))

(use-package exunit)

(use-package flymake-credo
  :ensure (flymake-credo :fetcher github :repo "vinikira/flymake-credo"))

(provide 'mode-elixir)
;;; mode-elixir.el ends here
