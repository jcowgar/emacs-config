;;; package-emacs.el --- Visual settings that need to be performed ASAP  -*- lexical-binding: t; -*-

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

(use-package emacs
  :ensure nil
  :custom-face
  ;; Setup our base fonts. Iosevka comes in multiple flavors. The base
  ;; is fixed but Aile and Etoile are variable width, but of similar
  ;; style. This allows for a beautiful representation of mixed font
  ;; files such as an Org file.
  (default ((t (:family "Iosevka Jeremy Coding" :height 150))))
  (variable-pitch ((t (:family "Iosevka Jeremy Coding" :height 150))))

  :custom
  ;; We do not need the startup message.
  (inhibit-startup-message t)

  ;; I prefer not to have GUI elements popping up. I am happy to work
  ;; in the mini buffer.

  (use-file-dialog nil)
  (use-dialog-box nil)

  ;; With my workflow temporary lock files in my working directories are
  ;; much more pain than rare file collisions.
  ;;
  ;; For instance, I have file watchers that will restart tests. Sure,
  ;; I could configure them to ignore these lock files, but I have to
  ;; do that in each project or once in Emacs to not create them :-)

  (create-lockfiles nil)

  ;; Save backup filer else where as I do not like files cluttering my
  ;; working tree. Also, do not auto-save. This goes against my backup
  ;; scheme.

  (backup-by-copying t)
  (backup-directory-alist '(("." . "~/.local/state/emacs/backups")))

  ;; I use Git on anything important, but having backup files that are
  ;; versioned with at least a number never hurt anyone. There are
  ;; changes between commits :-)

  (version-control t)
  (delete-old-versions t)
  (kept-new-versions 20)
  (kept-old-versions 20)

  ;; Sane scrolling setup.

  ;; show at least X lines in the direction of scroll.

  (scroll-margin 5)

  ;; Number of lines to scroll the window when we reach the windows
  ;; edge. If 10, for example, 10 more lines will become visible. This
  ;; sounds good, but your cursor now moves down the screen 10 lines,
  ;; then tracks back up until it hits the edge again, then goes back
  ;; down 10 lines. I prefer to only scroll 1 line per time. This
  ;; keeps my cursor right where my eyes are focused at.

  (scroll-step 1)

  ;; Set this value high enough to never recenter the point

  (scroll-conservatively 1000)

  ;; While scrolling with the mouse wheel or keyboard (C-v/M-v) keep
  ;; the cursor in the same screen location when possible.

  (scroll-preserve-screen-position 1)

  ;; Act like most other applications I use and delete any selected
  ;; text when I start to type. I see the benefit and not doing this,
  ;; but Emacs is the only application I use that wouldn't do this
  ;; making my computing experience in this area inconsistent.

  (delete-selection-mode 1)

  ;; Show matching parens always.

  (show-paren-mode t)

  ;; Trailing whitespace for my normal work is a bad thing. Point this
  ;; out to me when it exists.
  ;;
  ;; NOTE: I am questioning if I need this. Reason is I automatically
  ;; trim trailing whitespace in any programming mode. So, if the
  ;; editor can fix the problem for me on save, do I really want to be
  ;; bothered with it while editing? All I'd probably do is save the
  ;; file to make the editor fix it anyway.

  ;; NOTE: decided against this. Let's try with this off for a while
  ;; and see how I like it.

  (show-trailing-whitespace nil)

  ;; Similar to trailing whitespace, multiple blank lines at the end
  ;; of a file is frowned upon. Have Emacs highlight those for me.
  ;;
  ;; NOTE: this puts a weird mark in the gutter. Reminds me of vim
  ;; putting ~ on each non-populated line from the last line in the
  ;; file till the bottom of the editor. I do not care for this
  ;; behavior at all. It may be my theme. Needs research.

  (indicate-empty-lines nil)

  ;; It's easier then I'd care to admit to loose my cursor in the
  ;; buffer. Highlighting the line where it makes loosing it nearly
  ;; impossible. I like it.

  (global-hl-line-mode t)

  ;; Keeping with a minimal theme, I do not use line numbers all that
  ;; often. When I do care about line numbers it generally is going to a
  ;; line number and using the Goto Line function. The only other time
  ;; that I care about it is when pair programming. Therefore, I do set
  ;; it up to look nice and function well. I have a leader key
  ;; configuration area where I can toggle the line numbers on and off
  ;; for those pair programming sessions (SPC . l).

  (display-line-numbers-grow-only t)
  (display-line-numbers-width-start 3)
  (line-number-mode 0)
  (column-number-mode 0)

  (global-display-line-numbers-mode nil)

  ;; Sentences end with a single space, not two.

  (sentence-end-double-space nil)

  ;; do not prompt yes or no but y or n
  (use-short-answers t)

  ;; use-package emacs ends here
  )

(use-package recentf
  :ensure nil
  :init
  (require 'recentf)
  (recentf-mode)
  :custom
  (recentf-max-saved-items 200)
  (recentf-max-menu-items 15))

;; Always backup the buffer. Without this, buffer backups are time
;; based, not "save" based.

(defun jc/backup-buffer-always ()
  "Force a buffer backup to take place."
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook #'jc/backup-buffer-always)

(provide 'package-emacs)
;;; package-emacs.el ends here
