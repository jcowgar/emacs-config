;;; mode-rust.el --- Configure the Rust mode for my likings  -*- lexical-binding: t; -*-

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

(defun jc/rust-mode ()
  "Setup Rust mode how I like it"
  (eglot-ensure)
  (add-hook 'before-save-hook #'eglot-format-buffer nil t))

(use-package rust-ts-mode
  :ensure nil
  :after eglot
  :mode ("\\.rs" . rust-ts-mode)
  :hook ((rust-ts-mode . jc/rust-mode)))

(use-package toml-ts-mode
  :ensure nil
  :mode ("\\.toml" . rust-toml-mode))

(provide 'mode-rust)
;;; mode-rust.el ends here
