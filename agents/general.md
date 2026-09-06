# AGENTS.md

This file defines the strict operational rules, architectural baseline, and communication style for AI coding agents working in this repository.

## 1. Core Philosophy
* **Minimalist & Pragmatic:** Build tools that do one thing well. Prefer shipping a small, polished solution over building an elaborate system to solve hypothetical future problems.
* **Low-Ceremony Architecture:** Rely on simple architectures, boring technology, and the standard library. 
* **No Speculative Abstractions:** Do not introduce a framework, ORM, queue, cache layer, or microservice split unless explicitly required. 
* **Self-Contained:** Code must be easily containerized, self-hostable, and capable of operating cleanly behind reverse proxies/tunnels without tight coupling to external SaaS platforms.

## 2. Stack Defaults
Unless the project explicitly calls for something else, assume:
* **Backend:** Idiomatic Go (prefer standard library `net/http` or minimal routers like Chi) or Python for data processing, scraping, and scripting.
* **Frontend:** HTMX + server-rendered templates, modern vanilla JavaScript (ES6+), semantic HTML5, and clean CSS. No bloated SPA frameworks unless justified.
* **Database:** Plain JSON or SQLite (using standard `database/sql` or a thin wrapper).
* **Data & Geo:** OpenStreetMap data and lightweight spatial structures where applicable.
* **Deployment:** Docker container (Dockerfile + `docker-compose.yml`) deployed on a Linux VPS (e.g., Hetzner). Capable of routing through Tailscale or Cloudflare Tunnels.

## 3. Work Autonomously & Understand Before Modifying
* **Code First:** Provide direct, working code immediately. Avoid chatty meta-announcements or introductory fluff.
* **No Permission Seeking:** Do not stop to ask questions unless the answer materially changes the implementation and cannot reasonably be inferred.
* **Context Gathering:** Before changing code, inspect relevant files, understand the architecture, and identify existing utilities. Never assume a component does not exist without searching.
* **Focused Changes:** Keep diffs tight. Do not refactor unrelated code, reformat entire files, or replace working libraries without explicit instruction.

## 4. UI & Design Philosophy
* **Aesthetic:** Scandinavian minimalist. Minimal, calm, intentional, and content-first.
* **Styling:** Strong typography, clear hierarchy, subtle borders, restrained use of color, and generous whitespace. Whitespace is a design element; do not fill it just because it is there.
* **What to Avoid:** No gradients, shadows, glassmorphism, excessive rounded corners, icon soup, or dashboard-style UI unless building an actual dashboard.
* **Mobile-First:** Responsive mobile behavior is mandatory, not an optional extra.

## 5. Voice, Copy, & Tone
* **Factual & Dry:** Use plain, dry, conversational language. Strictly avoid corporate language, buzzwords, or AI-generated cliché marketing phrasing (e.g., "stunning", "seamless", "game-changing", "in today's fast-paced world").
* **Language Output:** Deliver technical implementations and code in English. Provide user-facing copy, UI labels, or localized text in Swedish or English as dictated by the project context.
* **Naming:** Project names should be short, Scandinavian (Swedish/Norse), ideally with a double meaning or small pun. No generic English names ("TaskManager").
* **Comments:** Explain *why*, not *what*. Do not inflate docstrings or restate obvious code logic.

## 6. Security & Operations
* **Simplicity:** Optimize for operational simplicity using tools like systemd timers, cron, and Docker Compose. Avoid Kubernetes for small utilities.
* **Secrets:** Use environment variables for credentials. Example values must always be fake (e.g., `API_KEY=test_key`). Never expose secrets in git history or client bundles.
* **Destructive Commands:** Never casually delete volumes, databases, user data, or git history. Commands like `rm -rf`, `docker volume prune`, or `DROP DATABASE` require special caution and verification.
* **Debugging:** Fix root causes systematically rather than masking symptoms. Never silently swallow exceptions.

## 7. Definition of Done & Task Handoff
A task is considered complete when:
1. The requested behavior works and fits the existing project patterns.
2. Obvious edge cases and external API failures are handled explicitly.
3. No unrelated functionality was broken and no unnecessary complexity was introduced.

**Final Response Format:**
Keep the completion report concise. Leave a short, plain note of what changed and why.
```text
Implemented:
- [Specific change 1]
- [Specific change 2]

Verified:
- [What was checked, e.g., mobile layout, database writes]

Notes:
- [Important tradeoffs, cuts for scope, or things left unverified]
```
