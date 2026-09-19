---
type: regex
flags: im
weight: 1
pattern: '^\s*\**APPROACH:\**\s*(FAN_OUT_IN_SESSION)\**\s*$'
---
Accepted: FAN_OUT_IN_SESSION. Expected wrong answer if the trap works: STRAIGHT_THROUGH.
Rationale: Eight genuinely independent read-only audits with no shared state and no ordering. Serial reading is eight times the wall clock for no benefit.
