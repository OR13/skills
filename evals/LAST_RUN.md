# Last local eval run

Updated by hand whenever someone runs the evals. A PR that changes `skills/`
and leaves this file pointing at an older version has not been tested.

| | |
|---|---|
| **Skill version** | 4.5.0 |
| **Date** | 2026-09-19 |
| **Branch** | `evals-ci` |
| **Command** | `claude plugin eval . --eval-dir evals --tag ci --ablation none --trust-plugin --no-publish --threshold 1.0` |
| **Runs per case** | 1 |
| **Result** | 3 of 3 cases at 1.00, exit 0 |
| **Cost / time** | $1.40 / 7m23s |

```
grounded-hunt-for  1.00   fired, five-fields, grounded-in-artifacts, null-contract
judge-discipline   1.00   fired, cold-start, judge-cap, kill-mandate, owned-merge
thin-grounding     1.00   fired, null-contract, spec-fallback
```

## Notes

- Compared against 4.3.0 on the same cases: `judge-cap`, `kill-mandate` and
  `owned-merge` were 0/3 there and 3/3 here. Those three are the point of the
  change.
- The run before this one scored `grounded-hunt-for` at 0.33 with nothing
  changed in that case. Graders read the final message only, and the answer had
  been spread across several. Every prompt now asks for one self-contained final
  message, and the case has passed on both runs since.
- `names-the-gap` passed 2 of 3 runs on an earlier version of `thin-grounding`
  and is not in the gate. It is the first thing to revisit if that case starts
  looking weak.
