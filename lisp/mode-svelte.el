;;; mode-svelte.el --- Configure the Svelte mode for my likings  -*- lexical-binding: t; -*-

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

;;(dolist (mode '(c-mode-hook c-ts-mode-hook c++-mode-hook c++-ts-mode-hook))
;;  (add-hook mode 'eglot-ensure))

(defun jc/svelte-mode ()
  "Setup svelte mode how I like it"
  (setq-local tab-width 4
	      indent-tabs-mode t)
  (eglot-ensure)

  (add-hook 'before-save-hook #'eglot-format-buffer nil t))

(use-package svelte-mode
  :after eglot
  :config
  (add-hook 'svelte-mode-hook 'jc/svelte-mode)
  (add-to-list 'eglot-server-programs
           '(svelte-mode . ("svelteserver" "--stdio"))))

(provide 'mode-svelte)
;;; mode-svelte.el ends here
