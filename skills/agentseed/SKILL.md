---
name: agentseed
description: "Generate and initialize production-grade AGENTS.md, CLAUDE.md, .cursorrules, and AI agent configuration files from static codebase analysis. Use when seeding agent instructions for a project, auditing existing AGENTS.md against current project architecture, or invoking agentseed."
version: 1.0.0
---

# Agentseed

Static codebase analyzer and seed generator for AI coding agent configuration files (`AGENTS.md`, `CLAUDE.md`, `.cursorrules`, `.github/copilot-instructions.md`, and `.windsurfrules`).

Agentseed automatically discovers repository languages, frameworks, package dependencies, build/test/lint commands, directory architecture, entry points, and naming conventions without requiring an API key.

---

## ⚡ Quick Invocation

```bash
# Generate AGENTS.md for current repository (Free, instant static analysis)
npx agentseed init

# Generate configuration for all AI assistants (AGENTS.md, CLAUDE.md, .cursorrules, Copilot, Windsurf)
npx agentseed init --format all

# Force refresh/overwrite existing agent files
npx agentseed init --force

# Inspect detected project stack, commands, and heuristics without writing files
npx agentseed scan

# Optional: Enhance with LLM for richer narrative architecture (bring your own key)
export ANTHROPIC_API_KEY="sk-ant-..."
npx agentseed init --provider claude
```

---

## Supported Output Formats

| Format Flag | Target File | Supported AI Tools |
| :--- | :--- | :--- |
| `--format agents` *(default)* | `AGENTS.md` | Antigravity / Gemini, Codex, Copilot, Cursor, Devin, 20+ tools |
| `--format claude` | `CLAUDE.md` | Claude Code CLI & Anthropic workbench |
| `--format cursor` | `.cursorrules` | Cursor IDE |
| `--format copilot` | `.github/copilot-instructions.md` | GitHub Copilot |
| `--format windsurf` | `.windsurfrules` | Windsurf / Codeium |
| `--format all` | All of the above | Generates all supported formats concurrently |

---

## When to Use This Skill

1. **New / Greenfield Repository Setup:**
   When working in a repository that lacks an `AGENTS.md` or `CLAUDE.md`, run `npx agentseed init` to map out the stack, test runners, and architecture before writing code.

2. **Codebase Evolution / Audit:**
   When dependencies, build tools, or directory structures change (e.g. migrating from npm to pnpm, switching test frameworks to Vitest, or re-structuring a monorepo), run `agentseed` to sync agent instructions with reality.

3. **Multi-Agent Alignment:**
   When team members use different AI tools (Antigravity, Cursor, Claude Code, Copilot), use `--format all` so every tool shares consistent context and boundaries.

---

## Handlag Integration Protocol

Agentseed provides the **factual project context** (detected languages, dependencies, scripts, entry points). `handlag` provides the **behavioral & architectural governance** (minimalism, tone, commit rules, Scandinavian design, anti-AI slop).

When seeding or configuring a project within the `handlag` ecosystem:

### Step 1: Run Agentseed
```bash
npx agentseed init
```

### Step 2: Harmonize with Handlag Rules
Inspect the generated `AGENTS.md`. Verify and ensure that:
1. **Core Philosophy:** Minimalist, pragmatic, no speculative abstractions, direct communication style (from `agents/general.md`).
2. **Commands Block:** Keep the exact test, lint, and build commands detected by agentseed (e.g., `npm test`, `pytest`, `cargo check`). Test running them to ensure they pass.
3. **Skills & Runbooks:** Include links to active skills (e.g. `.agents/skills/hallmark`, `humanizer`, `no-ai-slop`).
4. **Git Discipline:** Retain handlag's 7 rules for commit messages.

### Step 3: Symlink Support
For projects utilizing both Claude Code and standard AGENTS tooling:
```bash
ln -sf AGENTS.md CLAUDE.md
```

---

## Heuristics & Detection Engine

Agentseed extracts information across two passes:

### Pass 1: Static Analysis (Instant, Offline)
- **Package Manifests:** `package.json`, `Cargo.toml`, `pyproject.toml`, `requirements.txt`, `Pipfile`, `go.mod`, `dbt_project.yml`.
- **Task Runners:** `Makefile`, `Justfile`, `turbo.json`, `nx.json`.
- **Conventions:** Detects indentation, file naming (kebab-case, camelCase, snake_case), type safety requirements.
- **Monorepos:** Maps sub-packages, workspaces, and inter-package dependencies.

### Pass 2: Optional LLM Enhancement
- Smart-samples key entry points (`src/index.*`, `main.py`, config files).
- Requests a concise architectural summary via provider (`claude`, `openai`, `ollama`).
- Tracks git SHAs so subsequent runs only inspect modified areas.
