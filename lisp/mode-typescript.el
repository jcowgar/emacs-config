;;; mode-typescript.el --- Configure TypeScript mode for my likings  -*- lexical-binding: t; -*-

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

(defun jc/typescript-mode ()
  "Setup typescript mode how I like it"
  (setq-local tab-width 4
              indent-tabs-mode t)
  (eglot-ensure)

  (add-hook 'before-save-hook #'eglot-format-buffer nil t))

(use-package typescript-mode
  :after eglot
  :mode "\\.ts\\'"
  :config
  (add-hook 'typescript-mode-hook 'jc/typescript-mode)
  (add-to-list 'eglot-server-programs
               '(typescript-mode . ("typescript-language-server" "--stdio"))))

(provide 'mode-typescript)
;;; mode-typescript.el ends here


