;;; ash-mode.el --- ash emacs integration major-mode         -*- lexical-binding: t; -*-

;; Copyright (C) 2015 Sergey Kostyaev

;; Author: Sergey Kostyaev
;; Keywords: extensions

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;

;; Code:

(defvar ash-mode-hook nil)

(defvar ash-mode-map
  (let ((map (make-keymap)))
    (define-key map (kbd "C-c C-l") 'ash-ls)
    (define-key map (kbd "C-c C-f") 'ash-review-file)
    (define-key map (kbd "C-c C-r") 'ash-review)
    map)
  "Keymap for ash mode")

(defvar ash-review-url "" "url for review")

(defun ash-mode ()
  "Major mode for work with ash"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'ash-mode)
  (setq mode-name "ASH")
  (use-local-map ash-mode-map)
  (run-hooks 'ash-mode-hook))

(defcustom ash-editor "emacsclient"
  "Editor for using with ash. Emacsclient by default")

(defun must-ash-mode (&rest BODY)
    "Wrapper for check using this function only in ash-mode"
    (if (string-equal mode-name "ASH") (progn BODY)
      (message "This function work only in ash mode")))

(defun ash-ls ()
  "Open list of files in repo under cursor. Work only in *ash inbox* buffer"
  (interactive)
  (must-ash-mode
   (if (string-equal (buffer-name) "*ash inbox*")
       (progn (shell-command (concat "ash " (ffap-string-at-point) " ls")
                                   (ffap-string-at-point) "*ash errors*")
              (switch-to-buffer (ffap-string-at-point))
              (ash-mode))
     (message "ash-ls work only in *ash inbox* buffer"))))

(defun ash-review-file ()
  "Review file under cursor. Use it after ash-ls"
  (interactive)
  (must-ash-mode
   (if (string-equal (buffer-name) "*ash inbox*")
       (message "ash-review-file not for work in *ash inbox* buffer. Use it after ash-ls instead")
     (start-process "ash" "*ash*" "ash" "-e" ash-editor (buffer-name) "review"
                    (ffap-string-at-point)))))

(defun ash-review ()
  "Review current pull request (under cursor or in buffer)"
  (interactive)
  (must-ash-mode
   (set 'review-url (buffer-name))
   (if (string-equal (buffer-name) "*ash inbox*") (set 'review-url
                                                       (ffap-string-at-point)))
   (start-process "ash" "*ash*" "ash" "-e" ash-editor review-url "review")))

(defun ash-approve ()
  "Approve current pull request (under cursor or in buffer)"
  (interactive)
  (must-ash-mode
   (set 'review-url (buffer-name))
   (if (string-equal (buffer-name) "*ash inbox*") (set 'review-url
                                                       (ffap-string-at-point)))
   (start-process "ash" "*ash*" "ash" review-url "approve")))

(defun ash-decline ()
  "Decline current pull request (under cursor or in buffer)"
  (interactive)
  (must-ash-mode
   (set 'review-url (buffer-name))
   (if (string-equal (buffer-name) "*ash inbox*") (set 'review-url
                                                       (ffap-string-at-point)))
   (start-process "ash" "*ash*" "ash" review-url "decline")))


(provide 'ash-mode)
;;; ash-mode.el ends here
