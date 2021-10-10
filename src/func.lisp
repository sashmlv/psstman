(defpackage :psstman-func
  (:use :cl :uiop)
  (:nicknames :psstf)
  (:export :is-file
           :get-file-content
           :get-hash-val
           :get-psst-win
           :get-psst-lin))

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
    (setf keys (cdr keys))
    (if is-hash
        (get-hash-val keys val)
        val)))

(defmethod get-psst-win ()
  "Get psst in win"
  (uiop:run-program '("powershell.exe"
                      "-Command"
                      "$psst=read-host -assecurestring;\
                       $bstr=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($psst);\
                       [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)")
                    :output '(:string :stripped t)
                    :input :interactive
                    :error-output :interactive))

(defmethod get-psst-lin ()
  "Get psst in lin"
  (uiop:run-program "stty -echo;\
                     read psst;\
                     printf '%s' $psst;\
                     stty echo;"
                    :output :string
                    :input :interactive
                    :error-output :interactive))
