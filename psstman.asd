(asdf:defsystem "psstman"
  :description "psstman"
  :version "0.0.1"
  :author "sashmlv"
  :homepage "https://github.com/sashmlv/psstman"
  :license "UNLICENSE"
  :serial t
  :build-operation "program-op"
  :build-pathname "psstman"
  :entry-point "psstman:main"
  :depends-on ("cl-yaml" "str")
  :components((:file "main")))

