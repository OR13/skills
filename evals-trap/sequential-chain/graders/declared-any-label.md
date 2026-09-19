---
type: regex
flags: im
weight: 1
pattern: '^\s*\**APPROACH:\**\s*(STRAIGHT_THROUGH|FAN_OUT_IN_SESSION|FAN_OUT_SEPARATE_SESSIONS|HAND_BACK|ASK_FIRST|RUN_ONE_THEN_SCRIPT)\**\s*$'
---
Compliance only: did the run emit a valid APPROACH line at all, right or wrong.
Reported separately from accuracy, as the pre-registration requires. Without this,
a missing label and a wrong answer are indistinguishable.
