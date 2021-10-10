(defpackage :psstman
  (:use :cl :nyaml)
  (:export :main)
  (:import-from :nyaml :parse)
  (:import-from :str :words))

(in-package :psstman)

(setf sb-ext:*invoke-debugger-hook* ;; suppress errors log
      (lambda (condition hook)
        (sb-ext:exit :code 0)))

(defvar psst-file "psst.yml")

(defun main ()
  (let ((file-found (psstf:is-file psst-file)))
    (if (not file-found)
        (princ "psst file not found")
        (let* ((parts (psstf:get-file-content psst-file))
               (str (format nil "~{~a~^~%~}" parts))
               (psst-hash nil)
               (keys nil)
               (psst nil))
          (with-output-to-string (*standard-output*) ;; suppress unexpected log
            (setf psst-hash (parse str)))
          (princ "please enter your psst keys: ")
          (terpri)
          (setf keys (words (read-line)))
          ;; (setf psst (psstf:get-psst-win))
          ;; (setf psst (psstf:get-psst-lin))
          ;; (princ psst)
          (princ (psstf:get-hash-val keys psst-hash))))))
