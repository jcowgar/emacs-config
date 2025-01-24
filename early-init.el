;;; early-init.el --- Configuration important to get out of the way ASAP  -*- lexical-binding: t; -*-

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

;; Make Emacs start a little faster?
;;
;; A good resource to read is https://www.emacswiki.org/emacs/OptimizingEmacsStartup.
;; This will not only explain in more depth the below settings but also why
;; some of these settings are important.
;;
;; NOTE: At the bottom of this file is a hook for
;; emacs-startup-hook. Garbage collection is turned back on.

;; Disable garbage collection

(setq gc-cons-threshold most-positive-fixnum)

;; Emacs >= 28 will automatically display the warning buffer in
;; certain circumstances. I found this to be iritating for a few
;; common areas where warnings would occur, not errors. Therefore,
;; let's disable the automatic display of the warning buffer for a few
;; warning types.

(if (string-greaterp emacs-version "28.0.0")
    (setq  warning-suppress-types '((comp) (auto-save))))

;; Remove unwanted UI elements. Living my life mostly in the terminal,
;; I do not need these items. Disabling them early causes less
;; "flickr" when starting Emacs vs displaying the UI and then removing
;; them.

(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Set my desired width and height of my frames. I do not like wide
;; text or code. For example, most projects I work on have a max of 95
;; characters. After that the linter starts complaining.
;;
;; As for height, I use a 27" HiDPI 5k monitor. 55 gives me a
;; mostly full height window with my desired font and size.


(push '(height . 48) default-frame-alist)
(push '(width . 95) default-frame-alist)

;; NOTE: this was copied from anothers' configuration. I am unsure of
;; the validity. Need to research.
;;
;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font.  By inhibiting this, the startup time is significantly reduced,
;; especially with fonts larger than the system default.

(setq frame-inhibit-implied-resize t)

;; From the start, do not use Emacs built in package.el

(setq package-enable-at-startup nil)

;; Once emacs has started. Notice this is not the typical
;; `emacs-startup-hook'. The elpaca manager hooks that to do it's
;; package installation. Once it is complete, it triggers the
;; `elpaca-after-init-hook'. This is when we can really start using
;; the system (systematically).

;; TODO: `elpaca-after-init-hook' is not firing for me.

(add-hook 'emacs-startup-hook
          (lambda ()
            ;; Turn garbage collection back on
            (setq gc-cons-threshold (* 50 1000 1000))

            ;; Report a nice message showing how long it took to load
            ;; Emacs. Why? Guess it comes from my Vim days of making
            ;; it start up super fast.
            (message "*** Emacs loaded in %s with %d garbage collections."
		     (emacs-init-time) gcs-done)))

(provide 'early-init)
;;; early-init.el ends here
