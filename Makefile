LISP ?= sbcl
DIR := $(shell sbcl --noinform --eval '(progn(princ(namestring(car ql:*local-project-directories*)))(quit))')

build:
ifeq ("$(wildcard $(DIR)nyaml)", "")
	 @echo "cloning \"nyaml\""
	 git -C $(DIR) clone --sparse -c core.protectNTFS=false https://github.com/jasom/nyaml
endif
	 $(LISP) --load psstman.asd\
	 --eval '(ql:quickload :psstman)'\
	 --eval '(asdf:make :psstman)'\
	 --eval '(quit)'
