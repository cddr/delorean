# delorean

A simple set of macros for mocking time

## Usage

    (with-frozen-clock (local-time:now)
      (sleep 2)
      (local-time:timestamp= (local-time:now) point-in-time))
    
    (let ((same-time-tomorrow (local-time:timestamp+ (local-time:now) 1 :day)))
      (with-shifted-clock same-time-tomorrow
        (sleep 2)
        (local-time:timestamp= (local-time:now)
          (local-time:timestamp+ same-time-tomorrow (local-time:now) 2 :seconds))))
    
    (let ((now (local-time:now)))
      (with-scaled-clock (2)
        (sleep 2)
        (local-time:timestamp= (local-time:timestamp+ now 4 :seconds))))
    
The respective clocks can be nested arbitrarily inside one-another.

## Bugs?

What bugs?  No really, if you find a bug, let me know by raising a github issue.
