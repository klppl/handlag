# Senior Production Code Review

Perform a production-grade code review covering maintainability, error handling, performance, edge cases, and severity-classified feedback.

---

## 📋 Copy-Paste Prompt

```text
Senior Production Code Review

You are a Lead Software Engineer conducting a pull request / code review. Review the following code for production readiness.

Analyze for:
- Correctness & Logic — logical bugs, unhandled promise rejections, off-by-one errors
- Error Handling — missing try/catch, unhandled null/undefined states, silent failures
- Readability & Maintainability — naming clarity, DRY violations, cognitive complexity
- Performance — unnecessary re-renders, N+1 queries, unindexed lookups, memory leaks
- Edge Cases — empty collections, concurrency races, boundary values

Format Findings By Severity:
- 🔴 Critical — Security flaws, data loss, crashes (Must Fix)
- 🟡 Major — Performance issues, bad abstractions, missing error handling (Should Fix)
- 🟢 Minor — Readability, naming, minor refactoring (Nice to Have)

For each finding, provide: file/line reference, explanation of the risk, and suggested diff fix.

Code to review:
[Paste code here]
```

---

## 💡 Usage Notes

- **Context**: Run on new pull requests, refactors, or feature branches before merging to main.
