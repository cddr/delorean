curl -O ftp://ftp.clozure.com/pub/release/1.9/ccl-1.9-linuxx86.tar.gz
curl -O http://beta.quicklisp.org/quicklisp.lisp
tar -zxf ccl-1.9-linuxx86.tar.gz
ccl/lx86cl -n -l quick-build.lisp
