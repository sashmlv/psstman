(defpackage :psstman
  (:use :cl)
  (:export :main)
  (:import-from :cl-yaml :parse)
  (:import-from :str :words))

(in-package :psstman)

(require :sb-posix)

(setq sb-ext:*invoke-debugger-hook* ;; suppress errors
      (lambda (condition hook)
        (sb-ext:exit :code 0)))

(defvar psst-file "psst.yml")

(defun main ()
  (let ((file-found (psstf:is-file psst-file)))
    (if (not file-found)
        (princ "psst file not found")
        (let* ((parts (psstf:get-file-content psst-file))
               (str (format nil "~{~a~^~%~}" parts))
               (psst-hash (cl-yaml:parse str))
               (keys nil)
               (psst nil))
          (princ "please enter your psst keys: ")
          (terpri)
          (setq keys (str:words (read-line)))
          (princ (psstf:get-hash-val keys psst-hash))))))
