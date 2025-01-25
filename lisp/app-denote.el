;;; app-denote.el --- Configure denote            -*- lexical-binding: t; -*-

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

(require 'utility-weather)

(use-package denote
  :hook (dired-mode . denote-dired-mode-in-directories)
  :custom ((denote-file-type 'markdown-yaml)
	   (denote-file-type-prompt 'markdown-yaml)
	   (denote-directory (expand-file-name "~/Documents/denote"))
	   (denote-date-prompt-use-org-read-date t)
	   (denote-dired-directories (list denote-directory
					   (expand-file-name "amps" denote-directory)
					   (expand-file-name "journal" denote-directory))))

  :init
  (require 'denote))

(use-package consult-notes
  :after (consult denote)
  :custom
  (consult-notes-file-dir-sources `(("Denote" ?d ,denote-directory)
                                    ("Journal" ?j ,(concat denote-directory "/journal"))
                                    ("AMPS" ?a ,(concat denote-directory "/amps")))))

(defun jc/denote-amps ()
  "Create a new denote in the AMPS silo."
  (interactive)
  (let ((denote-directory (expand-file-name "amps" denote-directory)))
    (call-interactively #'denote)))

(defun jc/denote-amps-meeting ()
  "Create a new denote in the AMPS silo with the meeting template."
  (interactive)
  (let ((denote-directory (concat denote-directory "/amps")))
    (call-interactively #'denote))
  ;; (jc/denote-amps)
  (insert "* Meta\n** Attendees\n*** Jeremy$0\n\n* Notes")
  (search-backward "$0")
  (kill-forward-chars 2))

(defun jc/ordinal (value)
  "Convert VALUE into its ordinal form, 1st, 2nd, 3rd, 97th, etc."
  (let ((svalue (number-to-string value)))
    (cond ((string-suffix-p "11" svalue) "th")
          ((string-suffix-p "12" svalue) "th")
          ((string-suffix-p "13" svalue) "th")
          ((string-suffix-p "1" svalue) "st")
          ((string-suffix-p "2" svalue) "nd")
          ((string-suffix-p "3" svalue) "rd")
          (t "th"))))

(defun jc/denote-journal-title ()
  "Nice journal title that shows time passing.

2023/46 - Thursday, October 16th is an example output. The year
and week number really drive home where you are in the year and
how much time you have left in this year."
  (let* ((time (current-time))
         (base-date-string (format-time-string "%Y/%j - %A, %B %d" time))
         (date (nth 3 (decode-time time)))
         (date-nth (jc/ordinal date)))
    (format "%s%s" base-date-string date-nth date)))

(defun jc/denote-journal-find-todays-file ()
  (let* ((denote-directory (concat denote-directory "/journal"))
         (todays-date (format-time-string "%Y%m%d.*_daily" (current-time)))
         (matching-files (denote-directory-files-matching-regexp todays-date)))
    (if (length> matching-files 0)
        (nth 0 matching-files))))

(defun jc/denote-journal ()
  "Create a new journal entry with my title and tags pre-defined."
  (interactive)
  (let ((todays-file (jc/denote-journal-find-todays-file)))
    (if todays-file (find-file todays-file)
      (denote (jc/denote-journal-title) '("daily") nil
              (concat denote-directory "/journal"))
      (insert "* About Today

")
      (jc/wx-insert-today-single-line)
      (org-fill-paragraph)

      (insert "

* Habit
** TODO Three glasses of water
** TODO Max 1 glass of pop
** TODO Exercise


* Big Three
** AMPS

** Personal


* Journal
** Highlights

** Interstitial"))))

(defun jc/denote-journal-insert-interstitial-time ()
  (interactive)
  (insert (format-time-string "%H:%M - " (current-time))))

(defun jc/denote-journal-add-interstitial-note ()
  "Prompt for and insert an interstitial note into today's journal
file."
  (interactive)
  (let ((old-buffer (current-buffer))
        (note (read-string "Interstitial note: ")))
    (jc/denote-journal)
    (end-of-buffer)
    (insert "*** ")
    (jc/denote-journal-insert-interstitial-time)
    (insert note)
    (save-buffer)
    (switch-to-buffer old-buffer)))

(defun jc/denote-find-file ()
  "Open `project-find-file' in the `denote-directory'."
  (interactive)
  (consult-find denote-directory))

(require 'org)

(defconst jc/termux-p (getenv "ANDROID_ROOT"))

(defun jc/clipboard-get ()
  "Return the text on the system clipboard.

This function treats Termux systems differently, the clipboard is only
accessible through the termux-clipboard-get commandline interface,
part of the the termux-api package."

  (if jc/termux-p
      (shell-command-to-string "termux-clipboard-get")
    (current-kill 0)))


(defun jc/get-url-title (url)
  "Attempt to retrieve the title string from the given URL.

  Assuming the URL points to an HTML source.

  Returns nil if there is a non-200 return status or no title could
  be found."
  (let* ((command (format "curl --fail --silent %s" url))
         (html (shell-command-to-string command))
         (regexp (rx (seq "<title>"
                          (group (+ (not (any "<" ">"))))
                          "</title>")))
         (matches (string-match regexp html))
         (suggested-title (match-string 1 html)))
    (read-string (format-prompt "Title" "") suggested-title t)))

(defun jc/denote/url (url)
  "Create a new Org-based note based on an URL.

  Use the URL on the clipboard if there is one. Then, the title
 is retrieved from the HTML source to suggest the title for the
 note."
  (interactive (list
                (let* ((clipboard (jc/clipboard-get))
                       (clipboard-url (when (org-url-p clipboard) clipboard)))
                  (read-string (format-prompt "URL" "")
                               clipboard-url
                               t))))
  (denote (jc/get-url-title url) (denote-keywords-prompt) 'org (denote-subdirectory-prompt))
  (org-set-property "URL" url))

(provide 'app-denote)
;;; app-denote.el ends here
