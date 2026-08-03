# Complete Test Suite Generator

Generate high-coverage unit and integration tests including happy paths, edge cases, boundary conditions, and mock setups.

---

## 📋 Copy-Paste Prompt

```text
Test Suite Generator

You are a senior QA & Test Engineer. Write a comprehensive test suite for the provided code.

Requirements:
- Target Test Framework: [e.g., Jest, PyTest, Vitest, Go testing]
- Cover Happy Path (expected usage and success flows).
- Cover Edge Cases (empty inputs, null/undefined, extreme values, invalid types, boundary limits).
- Cover Failure Modes (network failures, rejected promises, thrown exceptions, timeouts).
- Mocking: Use idiomatic mocks/stubs for external dependencies (APIs, databases, disk I/O).
- Readability: Use clear test names (e.g., `it("should fail when token is expired")`).

Provide runnable code only with minimal setup instructions.

Code to test:
[Paste code here]
```

---

## 💡 Usage Notes

- **Context**: Use to quickly generate thorough test suites for existing functions, modules, or APIs.
