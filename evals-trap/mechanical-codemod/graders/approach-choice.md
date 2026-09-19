---
type: regex
flags: im
weight: 1
pattern: '^\s*\**APPROACH:\**\s*(RUN_ONE_THEN_SCRIPT|STRAIGHT_THROUGH)\**\s*$'
---
Accepted: RUN_ONE_THEN_SCRIPT, STRAIGHT_THROUGH. Expected wrong answer if the trap works: FAN_OUT_IN_SESSION.
Rationale: 200 files sounds large but the edit is one deterministic AST transform. Run one, verify, script the rest. Fanning out 200 files across workers is pure overhead.
