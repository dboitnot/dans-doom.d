;;; editing.el --- Dan's editing customizations
;;; lisp/editing.el -*- lexical-binding: t; -*-

;;; Commentary:
;;; This package provides some basic editing adjustments.

;;; Code:

(defun start-of-line-at-pos (p)
  "Return the position of the start of the line at position P."
  (save-excursion
    (goto-char p)
    (line-beginning-position)))

(defun end-of-line-at-pos (p)
  "Return the position of the end of the line at position P."
  (save-excursion
    (goto-char p)
    (line-end-position)))
