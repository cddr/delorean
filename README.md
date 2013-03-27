# delorean [![Build Status](https://travis-ci.org/[cddr]/[delorean].png)]

A simple set of macros for mocking time

## Usage

(with-frozen-clock (point-in-time)
  ...)

(with-shifted-clock (shifted-to)
  ...)

(with-scaled-clock (scale)
  ...)

The respective clocks can be nested arbitrarily inside one-another.