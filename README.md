# handlag

Personal collection of AI skills, prompts, and agent rules.

---

## Skills Reference

| Skill | Trigger / Command | Function |
| :--- | :--- | :--- |
| `hallmark` | `hallmark audit <target>`, `hallmark redesign <target>` | Frontend UI design and anti-AI-slop rules |
| `humanizer` | `humanizer` | Tone adjustment for natural voice |
| `no-ai-slop` | `no-ai-slop` | Style enforcement and cliché removal |
| `agentseed` | `agentseed`, `npx agentseed init` | Codebase static analysis & agent configuration generator (`AGENTS.md`, `CLAUDE.md`, etc.) |

### Agent Discovery
- **Gemini / Antigravity**: Auto-detects skills globally once linked.
- **Claude & Codex**: Reads `AGENTS.md` / `CLAUDE.md` and loads `.agents/skills/`.

---

## Setup & Linking

### 1. Global Setup (Gemini / Antigravity)
Symlink skills directory globally:
```bash
./scripts/export-skills.sh --symlink
```

### 2. Project Setup (Claude, Codex, Gemini)
Link `.agents/skills` and configure `AGENTS.md` into a target repository:
```bash
# Standard setup with handlag baseline rules
./scripts/setup-project.sh /path/to/project

# Or analyze codebase with agentseed to generate stack-tailored AGENTS.md + handlag rules
./scripts/setup-project.sh /path/to/project --agentseed
```

---

## Agent Rules & Templates

Curated operational rules, stack defaults, and communication guidelines located in [`agents/`](agents/):

- **[`general.md`](agents/general.md)**: Minimalist, low-ceremony operational rules, stack defaults (Go/Python, HTMX/Vanilla JS, SQLite), 7 Git commit rules, and Scandinavian design philosophy.

---

## AI Prompts Collection

A library of battle-tested development prompts located in [`prompts/`](prompts/):

- **[Bug Investigator](prompts/bug-investigator.md)**: Root cause diagnosis and regression test generation.
- **[Code Review](prompts/code-review.md)**: Production-grade review for maintainability and edge cases.
- **[Codebase Refactoring](prompts/codebase-refactoring.md)**: Architectural analysis and refactoring plans.
- **[Security Audit](prompts/security-audit.md)**: Evidence-based security audit across auth, secrets, and injection vectors.
- **[Spec Consultant](prompts/spec-consultant.md)**: Pre-implementation questionnaire and edge case discovery.
- **[STE Rewriter](prompts/ste-rewriter.md)**: Simplified Technical English (ASD-STE100) conversion.
- **[Subagent Orchestrator](prompts/subagent-orchestrator.md)**: Task decomposition and multi-agent coordination.
- **[Test Suite Generator](prompts/test-suite-generator.md)**: Comprehensive unit/integration test suites.

---

## Managing Skills

Vendor skills directly via GitHub URL:

```bash
# Add repository or subpath
./scripts/add-skill.sh https://github.com/owner/repo
./scripts/add-skill.sh https://github.com/owner/repo/tree/main/skills/foo

# Update all tracked skills
./scripts/update-skills.sh
```

---

## CLI Reference

| Command | Action |
| :--- | :--- |
| `./scripts/list-skills.sh` | List installed skills |
| `./scripts/add-skill.sh <url> [name]` | Add skill from GitHub |
| `./scripts/remove-skill.sh <name>` | Remove skill and unregister |
| `./scripts/update-skills.sh` | Pull latest updates |
| `./scripts/setup-project.sh <path> [--agentseed]` | Link skills into project (optional codebase seeding) |
| `./scripts/export-skills.sh --symlink` | Link skills globally |
| `./scripts/check-skills.sh` | Audit repository integrity |
