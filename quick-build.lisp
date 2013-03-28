
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname))))
  (if (probe-file "~/quicklisp/")
      (load quicklisp-init)
      (progn
	(load "quicklisp.lisp")
	(funcall (intern (format nil "~a" 'install)
			 :quicklisp-quickstart)))))

(ql:quickload :delorean)
(ql:quickload :trivial-dump-core)

(trivial-dump-core:dump-image "delorean.image")