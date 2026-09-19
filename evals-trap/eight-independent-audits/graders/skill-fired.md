---
type: tool_used
tool: Skill
weight: 1
---
Did the skill load at all. Without this, a "with skill" arm can silently
degenerate into a second baseline and the delta reads as a finding. That has
happened twice: Haiku answered all 50 runs in one turn without ever invoking
the skill, and the resulting -0.040 measured nothing.

Under with-without ablation this grader is a plugin-fired indicator, not part
of the score, so it cannot inflate the delta it exists to protect.
