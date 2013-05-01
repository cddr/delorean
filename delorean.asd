;; Copyright (c) 2013 Andy Chambers
;; All rights reserved.

;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are
;; met:

;;  o Redistributions of source code must retain the above copyright notice,
;;    this list of conditions and the following disclaimer.

;;  o Redistributions in binary form must reproduce the above copyright
;;    notice, this list of conditions and the following disclaimer in the
;;    documentation and/or other materials provided with the distribution.

;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;; A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;; HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;; SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
;; LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;; DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
;; OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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