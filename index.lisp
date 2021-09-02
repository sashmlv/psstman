(require 'cl-yaml)
(require 'str)

(defvar psst-file "psst.yml")

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

(defun main ()
  (let ((file-found (is-file psst-file)))
    (if (not file-found)
        (princ "psst file not found")
        (let* ((parts (get-file-content psst-file))
               (str (format nil "~{~a~^~%~}" parts))
               (psst-hash (cl-yaml:parse str))
               (keys nil)
               (val nil)
               )
          (princ "Please enter your psst keys: ")
          (terpri)
          (setq keys (str:words (read-line)))
          (princ (get-hash-val keys psst-hash))))))
