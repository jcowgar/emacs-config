;;; behavior-completion.el --- In buffer completion  -*- lexical-binding: t; -*-

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

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0.75)
  (corfu-quit-no-match 'separator)
  (corfu-preview-current t)
  (corfu-preselect 'directory)
  (corfu-popupinfo-delay '(0.3 . 0.1))

  :bind
  (:map corfu-map
        ;; Configure SPC for separator insertion
        ;;
        ;; 2023-12-03 - causing some issues in that I space right on
        ;; out to keep typing when I didn't really want a completion.
        ;; This leaves the completion 'No matches' message on the
        ;; screen and prevents up/down navigation as it still has
        ;; control and up/down would normally select between
        ;; completion options.
        ;;
        ;; Overall I like the idea, so leaving it here for later
        ;; experimentation to see if I can make something work.
        ;;
        ;; ("SPC" . corfu-insert-separator)

	;; Do not use enter to confirm the selection, only TAB can do
	;; that. I wind up getting to the end of a line and pressing
	;; enter and my code is changed by selecting the highlighted
	;; completion.

        ;; Disable this disabling of RET. I find it is getting in the
        ;; way of YASnippets. For example, when LSP completes a
        ;; function, it uses YASnippet to move through the parameters.
        ;; If I want to select something from the LSP completion using
        ;; TAB, that doesn't work. YASnippet wins and TAB causes the
        ;; text to be as entered and my cursor moves to the next
        ;; function parameter.

        ;; ("RET" . nil)
        )

  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))

(use-package emacs
  :ensure nil
  :init
  (setq completion-cycle-threshold 3
        tab-always-indent 'complete))

(use-package nerd-icons-corfu
  :after (corfu nerd-icons)
  :config
  (require 'nerd-icons-corfu)
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(provide 'behavior-completion)
;;; behavior-completion.el ends here
