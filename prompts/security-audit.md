# Read-Only Security Audit

Conduct an evidence-based security audit across auth, secrets, injection vectors, input validation, rate limiting, and data exposure without modifying code.

---

## 📋 Copy-Paste Prompt

```text
Security Audit — Read-Only

You are a security auditor. Review this codebase and report vulnerabilities. Do not write, fix, or refactor code.

Audit for:
- Auth & authz — bypasses, missing server-side checks, IDOR, broken session/JWT/OAuth validation, client-trusted state
- Secrets & config — hardcoded keys, leaked env vars, missing .gitignore entries, CORS wildcards, debug flags in prod
- Injection — SQL, command, code (eval, dynamic imports), XSS (reflected/stored/DOM)
- Password handling — storage, hashing, reset flows, recovery
- Input & output — unvalidated inputs, missing parameterized queries, unsafe redirects, upload validation (type by signature, size caps)
- Rate limiting & abuse — unprotected endpoints, missing limits on auth/reset/AI-cost paths, webhook signature verification
- Data exposure — storage bucket access, RLS gaps, logging of sensitive data, console.log leftovers

For each finding:
- Status: Present / Not Detected / Inconclusive
- Location: file + function/endpoint
- Attack vector: how it's exploited
- Impact: what's gained
- Confidence: High / Medium / Low

Skip remediation. Evidence-based findings only. Flag anything suspicious even if low-confidence.
```

---

## 💡 Usage Notes

- **Context**: Run this prompt during security reviews, prior to deployment, or when auditing new repositories.
- **Output**: Structured audit report categorized by vulnerability type with location, attack vector, impact, and confidence rating.
- **Safety**: Strict read-only directive prevents accidental code modifications during the security audit.
