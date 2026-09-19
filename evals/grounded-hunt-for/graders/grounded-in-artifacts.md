---
type: regex
flags: is
weight: 2
pattern: '(?=.*(docs/adr/00|ADR 00))(?=.*tests/test_)(?=.*(ci\.yml|45s))'
---
Failure modes must be tied to this repo: an ADR, a test path, and the CI ceiling all appear.
