;;; mode-markdown.el --- Configure markdown mode  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Jeremy Cowgar

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

(use-package markdown-mode
  :custom
  (markdown-fontify-code-blocks-natively t)
  (markdown-hide-markup-in-view-modes t)
  (markdown-header-scaling t)
  (markdown-header-scaling-values '(1.8 1.6 1.4 1.1 1.0 1.0))
  (markdown-marginalize-headers nil))

(provide 'mode-markdown)
;;; mode-markdown.el ends here
