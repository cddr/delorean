
(format t "~&;;; -------------- Generating delorean docs  -------------------~%")

(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname))))
  (if (probe-file "~/quicklisp/")
      (load quicklisp-init)
      (progn
	(load "quicklisp.lisp")
	(funcall (intern (format nil "~a" 'install)
			 :quicklisp-quickstart)))))

(ql:quickload :delorean)
(ql:quickload :atdoc)

(atdoc:generate-html-documentation
 '(:delorean)
 (merge-pathnames #p"docs/" *load-truename*)
 :index-title "Delorean -- API Reference"
 :heading "Delorean -- A time machine for lisp unit tests"
 :single-page-p t
 :include-internal-symbols-p nil)

(quit)