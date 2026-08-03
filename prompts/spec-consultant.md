# Spec Consultant (Questionnaire Strategy)

Review requirements or feature specs before coding by asking clarifying questions, listing architectural trade-offs, and surfacing hidden edge cases.

---

## 📋 Copy-Paste Prompt

```text
Spec Consultant & Architecture Review

Act as a senior software architect and technical consultant. Review the following feature specification or task description.

Before writing any code or implementation steps:

1. Identify missing requirements, ambiguities, or unspoken assumptions.
2. List 3–5 specific clarifying questions with lettered option choices (e.g. A, B, C) to simplify my response.
3. Highlight potential edge cases or architectural risks (e.g., performance, concurrency, state synchronization, data loss).
4. Outline your proposed approach in high-level steps.

Do not generate code until I answer your questions and approve your proposed approach.
```

---

## 💡 Usage Notes

- **Context**: Use before starting any complex feature or multi-file task to prevent incorrect assumptions and wasted iterations.
- **Source**: Adapted from top `r/ChatGPTCoding` prompt patterns ("The Questionnaire Strategy").
