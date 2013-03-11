
(defpackage :delorean-test
  (:use :cl :local-time :delorean :fiveam))

(in-package :delorean-test)

(test delorean-frozen
  (let ((past (timestamp- (now) 1 :year))
	(future (timestamp+ (now) 1 :year))
	(now (now)))
      (is (timestamp= (with-frozen-clock past
			(now))
		      past))
      (is (timestamp= (with-frozen-clock future
			(now))
		      future))
      (is (timestamp= (with-frozen-clock now
			(sleep 1)
			(now))
		      now))))


;; (test delorean-shift
;;   (let ((past (timestamp- (now) 1 :year))
;; 	(future (timestamp+ (now) 1 :year))
;; 	(now (now)))
;;     (is (timestamp= (with-shifted-clock past
;; 		      (

;; (test timecop-traveller
  
	    

;; (explain! (run 'delorean-frozen))