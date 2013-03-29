
(defsystem :delorean
  :description "Delorean is a time machine for unit tests"
  :author "Andy Chambers"
  :version #.(with-open-file (f (merge-pathnames "version.lisp-expr"
                                  (or *compile-file-pathname*
				      *load-truename*)))
	       (read f))
  :in-order-to ((test-op (test-op :delorean-test)))
  :depends-on (:local-time)
  :components ((:file "delorean")))

(defsystem :delorean-test
  :components ((:file "tests"))
  :depends-on (:delorean :fiveam)
  :in-order-to ((test-op (load-op :delorean-test)))
  :perform (test-op :after (op c)
             (funcall (intern (format nil "~a" 'run!) :fiveam))))