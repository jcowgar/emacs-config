;;; behavior-git.el --- Setup several git management tools  -*- lexical-binding: t; -*-

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

;; This is not working but I left it here as it would be nice to
;; insert a git commit message in some automated form, such as:
;;
;; feat(module): MS-00 - |
;;
;; module being prompted for and | is where the cursor ends up. The
;; MS-00 would have to be parsed from the VCS branch name. feat and
;; bug can also be derived from the branch name (potentially).

(defun jc/git-commit-message ()
  (interactive))

(add-hook 'git-commit-mode-hook #'jc/git-commit-message)

;;(use-package seq)
(use-package transient)
(use-package magit)

(use-package diff-hl
  :after magit
  :init
  (global-diff-hl-mode 1)

  :hook ((magit-pre-refresh diff-hl-magit-pre-refresh)
	 (magit-post-refresh diff-hl-magit-post-refresh)))

(use-package git-messenger
  :after magit
  :custom
  (git-messenger:use-magit-popup t))

(use-package git-link
  :custom
  (git-link-open-in-browser t))

(use-package git-timemachine)

(defun jc/magit-diff-with-main ()
  "Show differences using `magit' between the current tree and main."
  (interactive)
  (magit-diff-range "main"))

(provide 'behavior-git)
;;; behavior-git.el ends here
