
CMUCL    ?= lisp
OPENMCL  ?= openmcl
SBCL     ?= sbcl
CLISP    ?= clisp
ALLEGRO  ?= alisp
SCL      ?= scl
CCL      ?= ccl

TEST_SCRIPT = "run-tests.lisp"

clean:
	@$(MAKE) -wC tests clean
	find . -name ".fasls" | xargs rm -rf
	find . \( -name "*.dfsl" -o -name "*.fasl" -o -name "*.fas" -o -name "*.lib" -o -name "*.x86f" -o -name "*.amd64f" -o -name "*.sparcf" -o -name "*.sparc64f" -o -name "*.hpf" -o -name "*.hp64f" -o -name "*.ppcf" -o -name "*.nfasl" -o -name "*.ufsl" -o -name "*.fsl" -o -name "*.lx64fsl" \) -exec rm {} \;

test-openmcl:
	@-$(OPENMCL) --load $(TEST_SCRIPT)

test-sbcl:
	@-$(SBCL) --noinform --load $(TEST_SCRIPT)

test-cmucl:
	@-$(CMUCL) -load $(TEST_SCRIPT)

test-scl:
	@-$(SCL) -load $(TEST_SCRIPT)

test-clisp:
	@-$(CLISP) -q -x '(load "$(TEST_SCRIPT)")'

test-clisp-modern:
	@-$(CLISP) -modern -q -x '(load "$(TEST_SCRIPT)")'

test-allegro:
	@-$(ALLEGRO) -L $(TEST_SCRIPT)

test-ccl:
	@-$(CCL) --no-init --load $(TEST_SCRIPT)

test: test-openmcl test-sbcl test-cmucl test-clisp