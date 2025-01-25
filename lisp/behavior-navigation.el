;;; behavior-navigation.el --- Navigating around within a buffer  -*- lexical-binding: t; -*-

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

(use-package block-nav
  :bind (("s-<left>" . block-nav-previous-indentation-level)
	 ("s-<right>" . block-nav-next-indentation-level)
	 ("s-<up>" . block-nav-previous-block)
	 ("s-<down>" . block-nav-next-block)))

(use-package avy
  :custom
  (avy-keys '(?a ?s ?d ?f ?j ?k ?l ?\;))
  
  :bind (("C-;" . avy-goto-char-2)
	 ("C-:" . avy-goto-char-timer)))

(provide 'behavior-navigation)
;;; behavior-navigation.el ends here
