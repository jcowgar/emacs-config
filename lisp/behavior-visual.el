;;; behavior-visual.el --- Customize the visual appearance of Emacs     -*- lexical-binding: t; -*-

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

(use-package modus-themes
  :custom
  (modus-themes-italic-constructs t)
  (modus-themes-bold-constructs t)
  (modus-themes-mixed-fonts t)
  (modus-themes-variable-pitch-ui t)
  (modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))

  :init
  (require 'modus-themes)
  ;; (setq modus-themes-common-palette-overrides modus-themes-preset-overrides-warmer)
  (load-theme 'modus-operandi-tinted :no-confirm))

;; not sure I like this
;;(use-package spacious-padding
;;  :init
;;  (spacious-padding-mode))

(provide 'behavior-visual)
;;; behavior-visual.el ends here
