---
type: regex
flags: im
weight: 1
pattern: '^\s*\**APPROACH:\**\s*(STRAIGHT_THROUGH)\**\s*$'
---
Accepted: STRAIGHT_THROUGH. Expected wrong answer if the trap works: FAN_OUT_IN_SESSION.
Rationale: Each step's output is the next step's input: the schema migration must land before the model layer compiles, which must land before the API layer, which must land before the client. Nothing can run in parallel.
