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
  :depends-on ("nyaml" "str" "trivial-clipboard")
  :components ((:module "src" ;; project dir
                :components ((:file "main" :depends-on ("func"))
                             (:file "func")))))
