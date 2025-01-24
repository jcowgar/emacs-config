;;; package-mood-line.el --- Configure mood-line  -*- lexical-binding: t; -*-

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

(use-package mood-line
  :ensure (mood-line :host github :repo "bruno-r2/mood-line")
  :config
  (mood-line-mode))

;;(use-package doom-modeline
;;  :custom
;;  (doom-modeline-buffer-file-name-style 'relative-to-project)
;;  (doom-modeline-percent-position nil)
;;  (doom-modeline-buffer-encoding nil)
;;  (doom-modeline-indent-info nil)
;;  (doom-modeline-total-line-number nil)
;;  (doom-modeline-mu4e t)
;;  (doom-modeline-gnus nil)
;;  (doom-modeline-battery nil)
;;  (doom-modeline-vcs-max-length 32)
;;
;;  :init
;;  (doom-modeline-mode 1))

(provide 'package-mood-line)
;;; package-mood-line.el ends here
