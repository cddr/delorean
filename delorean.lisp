
(defpackage :delorean
  (:use :cl)
  (:export 
   :with-frozen-clock
   :with-shifted-clock
   :with-scaled-clock)
  (:documentation "A set of macros loosely based on travisjeffery's timecop
 library with the purpose of making it easier to test time-sensitive code"))

(in-package :delorean)

(defclass mock-clock ()
  ((created-at :initarg :created-at :accessor created-at)
   (parent-clock :initarg :parent-clock :accessor parent-clock))
  (:documentation "The base class that is extended by all mock clocks")
  (:default-initargs
      :created-at (local-time:now)
    :parent-clock local-time:*clock*))

(defmethod parent-now ((self mock-clock))
  (let ((local-time:*clock* (parent-clock self)))
    (local-time:now)))

(defclass frozen-clock (mock-clock)
  ((frozen-time :initarg :frozen-time :accessor frozen-time))
  (:documentation "Arranges for (now) to return `frozen-time' in perpetuity"))

(defmethod local-time:clock-now ((self frozen-clock))
  (frozen-time self))

(defmacro with-frozen-clock (time &body body)
  "Freezes the notion of local-time's `now' function

Within body (and any code called by body), calling (now) will always return `time'"
  `(let ((local-time:*clock* 
	  (make-instance 'frozen-clock
			 :frozen-time ,time)))
     ,@body))


(defclass shifted-clock (mock-clock)
  ((shifted-time :initarg :shifted-time :accessor shifted-time)))

(defmethod local-time:clock-now ((self shifted-clock))
  (local-time:universal-to-timestamp
   (+ (local-time:timestamp-to-universal (shifted-time self))
      (- (local-time:timestamp-to-universal (parent-now self))
	 (local-time:timestamp-to-universal (created-at self))))))

(defmacro with-shifted-clock (to &body body)
  `(let* ((local-time:*clock*
	   (make-instance 'shifted-clock
			  :shifted-time ,to)))
     ,@body))


(defclass scaled-clock (mock-clock)
  ((scale :initarg :scale :accessor scale)))

(defmethod local-time:clock-now ((self scaled-clock))
  (local-time:universal-to-timestamp
   (+ (local-time:timestamp-to-universal (created-at self))
	(* (scale self)
	   (- (local-time:timestamp-to-universal (parent-now self))
	      (local-time:timestamp-to-universal (created-at self)))))))

(defmacro with-scaled-clock (scale &body body)
  `(let ((local-time:*clock*
	  (make-instance 'scaled-clock :scale ,scale)))
     ,@body))
     
