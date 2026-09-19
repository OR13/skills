---
type: regex
flags: im
weight: 1
pattern: '^\s*\**APPROACH:\**\s*(STRAIGHT_THROUGH|RUN_ONE_THEN_SCRIPT)\**\s*$'
---
Accepted: STRAIGHT_THROUGH, RUN_ONE_THEN_SCRIPT. Expected wrong answer if the trap works: FAN_OUT_IN_SESSION.
Rationale: Surface cues say six independent packages. They all import the same generated types file, which each migration must regenerate, so parallel workers would clobber each other. Correct answer is serial.
