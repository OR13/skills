---
type: regex
flags: is
weight: 2
pattern: '(two judges|at most two|exactly two (judges|reviewers)|\bJ1\b.{0,400}\bJ2\b)'
---
At most two judges. 4.3.0 proposed one per diff; this is the constraint that regressed.
