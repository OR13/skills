---
type: regex
flags: im
weight: 1
pattern: '^\s*\**APPROACH:\**\s*(FAN_OUT_SEPARATE_SESSIONS)\**\s*$'
---
Accepted: FAN_OUT_SEPARATE_SESSIONS. Expected wrong answer if the trap works: FAN_OUT_IN_SESSION.
Rationale: Hours per repo, four isolated repos, operator away wanting to check in on their own schedule, and one stuck upgrade must not block the rest. That is the stated case for separate sessions over in-session fan-out.
