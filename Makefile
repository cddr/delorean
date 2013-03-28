
.PHONY: ccl
ccl:
	sh install-ccl.sh

delorean.image: delorean.asd delorean.lisp quick-build.lisp tests.lisp
	ccl/lx86cl -n -l quick-build.lisp

all: delorean.image