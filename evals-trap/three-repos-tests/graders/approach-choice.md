---
type: regex
flags: im
weight: 1
pattern: '^\s*\**APPROACH:\**\s*(FAN_OUT_IN_SESSION|FAN_OUT_SEPARATE_SESSIONS)\**\s*$'
---
Accepted: FAN_OUT_IN_SESSION, FAN_OUT_SEPARATE_SESSIONS. Expected wrong answer if the trap works: STRAIGHT_THROUGH.
Rationale: Three independent repos with failing suites, no ordering between them. Either fan-out is defensible; doing it serially is the failure.
