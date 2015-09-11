;;; ash.el --- ash emacs integration package         -*- lexical-binding: t; -*-

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

(defcustom ash-editor "emacsclient"
  "Editor for using with ash. Emacsclient by default")

(defun ash-inbox ()
  "Open ash inbox in *ash inbox* buffer"
  (interactive)
  (if (get-buffer "*ash inbox*") (kill-buffer "*ash inbox*"))
  (start-process-shell-command "ash inbox" "*ash inbox*" "ash inbox")
  (switch-to-buffer "*ash inbox*"))

(defun ash-ls ()
  "Open list of files in repo under cursor. Work only in *ash inbox* buffer"
  (interactive)
  (if (string-equal (buffer-name) "*ash inbox*")
  (async-shell-command (concat "ash " (ffap-string-at-point) " ls")
                       (ffap-string-at-point) "*ash errors*")
  (message "ash-ls work only in *ash inbox* buffer")))

(defun ash-review-file ()
  "Review file under cursor. Use it after ash-ls"
  (interactive)
  (if (string-equal (buffer-name) "*ash inbox*")
      (message "ash-review-file not for work in *ash inbox* buffer. Use it after ash-ls instead")
    (start-process "ash" "*ash*" "ash" "-e" ash-editor (buffer-name) "review"
                 (ffap-string-at-point))))

(defun ash-review ()
  "Review current pull request (under cursor or in buffer)"
  (interactive)
  (defvar review-url (buffer-name) "url for review")
  (if (string-equal (buffer-name) "*ash inbox*") (set 'review-url
                                                      (ffap-string-at-point)))
  (start-process "ash" "*ash*" "ash" "-e" ash-editor review-url "review"))

(defun ash-approve ()
  "Approve current pull request (under cursor or in buffer)"
  (interactive)
  (defvar review-url (buffer-name) "url for review")
  (if (string-equal (buffer-name) "*ash inbox*") (set 'review-url
                                                      (ffap-string-at-point)))
  (start-process "ash" "*ash*" "ash" review-url "approve"))

(defun ash-decline ()
  "Decline current pull request (under cursor or in buffer)"
  (interactive)
  (defvar review-url (buffer-name) "url for review")
  (if (string-equal (buffer-name) "*ash inbox*") (set 'review-url
                                                      (ffap-string-at-point)))
  (start-process "ash" "*ash*" "ash" review-url "decline"))


(provide 'ash)
;;; ash.el ends here
