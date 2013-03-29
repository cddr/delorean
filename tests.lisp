
(defpackage :delorean-test
  (:use :cl :local-time :delorean :fiveam))

(in-package :delorean-test)

;; makes the indentation better in emacs
(defmacro deftest (name (&rest rest) &body body)
  (declare (ignore rest))
  `(test ,name ,@body))

(deftest delorean ()
  (let ((point-in-time (local-time:now)))
    (with-frozen-clock point-in-time
      (sleep 2)
      (is (local-time:timestamp= (local-time:now) point-in-time))))


  (let ((same-time-tomorrow (local-time:timestamp+ (local-time:now) 1 :day)))
    (with-shifted-clock same-time-tomorrow
      (sleep 2)
      (is (local-time:timestamp= (local-time:now)
           (local-time:timestamp-minimize-part
            (local-time:timestamp+ same-time-tomorrow 2 :sec) :nsec)))))

  
  (let ((now (local-time:now)))
    (with-scaled-clock 2
      (sleep 2)
      (is (local-time:timestamp= (local-time:now)
            (local-time:timestamp-minimize-part
              (local-time:timestamp+ now 4 :sec) :nsec))))))