
(format t "~&;;; -------------- Running delorean tests on ~a -------------------~%"
	(lisp-implementation-type))

(setf *load-verbose* nil 
      *compile-verbose* nil 
      *compile-print* nil)

(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname))))
  (if (probe-file "~/quicklisp/")
      (load quicklisp-init)
      (progn
	(load "quicklisp.lisp")
	(funcall (intern (format nil "~a" 'install)
			 :quicklisp-quickstart)))))

(ql:quickload :delorean)

(asdf:operate 'asdf:test-op :delorean)

(quit)