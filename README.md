# delorean

A simple set of macros for mocking time

## Usage

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

The respective clocks can be nested arbitrarily inside one-another.

## Bugs?

What bugs?  No really, if you find a bug, let me know by raising a github issue.
