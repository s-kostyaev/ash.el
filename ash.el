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
(require 'ash-mode)

(defun ash-inbox ()
  "Open ash inbox in *ash inbox* buffer"
  (interactive)
  (if (get-buffer "*ash inbox*") (kill-buffer "*ash inbox*"))
  (start-process-shell-command "ash inbox" "*ash inbox*" "ash inbox")
  (switch-to-buffer "*ash inbox*")
  (ash-mode))


(provide 'ash)
;;; ash.el ends here
