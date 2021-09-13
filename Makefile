LISP ?= sbcl

build:
	 $(LISP) --load psstman.asd\
	 --eval '(ql:quickload :psstman)'\
	 --eval '(asdf:make :psstman)'\
	 --eval '(quit)'
