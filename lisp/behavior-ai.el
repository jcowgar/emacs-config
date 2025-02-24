;;; behavior-ai.el --- Configure AI plugins     -*- lexical-binding: t; -*-

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

(use-package copilot-chat
  :config
  (setq copilot-chat-model "claude-3.5-sonnet"))

(use-package gptel
  :ensure (:repo "karthink/gptel")
  :config
  ;; Github Models offers an OpenAI compatible API
  (gptel-make-openai "Github Model:gpt-4o"
    :host "models.inference.ai.azure.com"
    :endpoint "/chat/completions"
    :stream t
    :key (getenv "AZURE_API_KEY")
    :models '(gpt-4o))
  (gptel-make-openai "Github Model:o3-mini"
    :host "models.inference.ai.azure.com"
    :endpoint "/chat/completions"
    :stream t
    :key (getenv "AZURE_API_KEY")
    :models '(o3-mini)))

(provide 'behavior-ai)
;;; behavior-ai.el ends here
