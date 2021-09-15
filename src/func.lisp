(defpackage :psstman-func
  (:use :cl)
  (:nicknames :psstf)
  (:export :is-file
           :get-file-content
           :get-hash-val))

(in-package :psstman-func)

(defun is-file (name)
  "Check is file"
  (let ((path (probe-file name)))
    (if path
        (pathname-name path))))

(defun get-file-content (filename)
  "Read file in list by new line"
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defmethod get-hash-val (keys hash)
  "Get value from hash by keys list"
  (let* ((key (car keys))
         (val (gethash key hash))
         (is-hash (eq (type-of val) 'HASH-TABLE)))
    (setq keys (cdr keys))
    (if is-hash
        (get-hash-val keys val)
        val)))
