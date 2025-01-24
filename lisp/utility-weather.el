;;; utility-weather.el --- Get basic weather information from open-meteo  -*- lexical-binding: t; -*-

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

(defvar jc/wx-latitude 41.09363
  "Latitude to get the weather for.")

(defvar jc/wx-longitude -81.519
  "Longitude to get the weather for.")

(defvar jc/wx-timezone "America/New_York"
  "Timezone time data should be reported in.")

(defun jc/wx--url ()
  (format "https://api.open-meteo.com/v1/forecast?latitude=%.3f&longitude=%.3f&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset,daylight_duration,sunshine_duration,uv_index_max,wind_speed_10m_max,wind_gusts_10m_max&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=%s&forecast_days=1"
          jc/wx-latitude
          jc/wx-longitude
          (url-encode-url jc/wx-timezone)))

(defun jc/wx--get-url-body (url)
  (let (response)
    (with-current-buffer (url-retrieve-synchronously url)
      (goto-char (point-min))
      (re-search-forward "\n\n")  ;; Move to the end of headers.
      (setq response (buffer-substring-no-properties (point) (point-max))))
    response))

(defun jc/wx--first (field daily)
  (aref (cdr (assq field daily)) 0))

(defun jc/wx--extract-and-format-weather (json-content)
  (let* ((json-object (json-read-from-string json-content))
         (daily (assq 'daily json-object))
         (temp-max (jc/wx--first 'temperature_2m_max daily))
         (temp-min (jc/wx--first 'temperature_2m_min daily))
         (wind-max (jc/wx--first 'wind_speed_10m_max daily))
         (wind-gust (jc/wx--first 'wind_gusts_10m_max daily))
         (daylight-duration (/ (jc/wx--first 'daylight_duration daily) 60.0 60.0)))
    (format "Today's weather will have %.1f hours of daylight with a high of %.1f°F and low of %.1f°F. Wind is expected to be maximum of %.1f mph gusting to %.1f mph."
            daylight-duration
            temp-max
            temp-min
            wind-max
            wind-gust)))

(defun jc/wx-insert-today-single-line ()
  "Get today's weather as a simple single line."
  (interactive)
  (let* ((url (jc/wx--url))
         (raw (jc/wx--get-url-body url))
         (message (jc/wx--extract-and-format-weather raw)))
    (insert message)))

(provide 'utility-weather)
;;; utility-weather.el ends here
