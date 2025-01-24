;;; init.el --- Base entry point to my Emacs configuration  -*- lexical-binding: t; -*-

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

;; Here I break out my configuration into many separate files.
;; Configuration files consist of
;;
;; package-*: the goal is the package itself.
;;
;; behavior-*: a group of packages and settings to cause Emacs to
;;             behave in a certain way. eg., today the minibuf is
;;             enhanced by vertico, marginalia, consult and orderless.
;;             Tomorrow, the minibuf may use some other completion
;;             framework that is newer and better. Another example is
;;             behavior-lsp. Today I am using eglot. Maybe tomorrow
;;             I will use lsp-mode or lsp-bridge. In the end the behavior
;;             is an lsp interface.
;;
;;             A behavior can be swapped in and out with little effect
;;             on the rest of the configuration.
;;
;; mode-* all configuration and extra packages that enable a
;;        particular mode to work. Elixir contains `elixir-ts-mode'
;;        and `exunit' to make Elixir development nice.
;;
;; app-* packages that are large enough to be considered applications
;;       themselves, such as Denote.

;; These items I want in order.

;; Preamble

;; Standard place to store locally created elisp packages/configurations.
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; 1. Need to get package management up and running for almost every
;; other file to work properly.

(require 'package-elpaca)

;; 2. Configure the basics of Emacs, including some items that may
;; help to reduce flickr as the properties change. eg. font faces.

(require 'package-emacs)

;; 3. Visual setup such as the theme. If this loads too late, an Emacs
;; frame may appear with a white background and then change a split
;; second later. This is distracting and not desired, so do this work
;; as soon as possible in the startup sequence.

(require 'behavior-visual)

;; 4. Everything else.

(require 'behavior-minibuf)
(require 'behavior-mode-line)
(require 'behavior-git)
(require 'behavior-lsp)
(require 'behavior-treesit)
(require 'behavior-completion)

(require 'package-yasnippet)

(require 'app-denote)

(require 'mode-c)

;; Set up where our customization's are stored.

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p custom-file)
    (load custom-file))

;; Block any further processing until elpaca-use-package is installed.
;; This way we can rely on it being available for the rest of our
;; initialization.

(elpaca-wait)

(provide 'init)
;;; init.el ends here
