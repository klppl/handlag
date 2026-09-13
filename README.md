# handlag

Personal collection of AI skills, prompts, and agent rules.

---

## ⚡ At a Glance: Calling Skills in Chat

Type these directly in your chat with Gemini, Claude, or Codex:

| Action | Chat Command / Prompt | Skill Used |
| :--- | :--- | :--- |
| **Audit UI Design** | `hallmark audit <file or url>` | `hallmark` |
| **Redesign UI** | `hallmark redesign <file>` | `hallmark` |
| **Fresh UI Build** | *"Build a landing page for X"* | `hallmark` (auto-triggered) |
| **Humanize Text** | `humanizer: <paste text>` | `humanizer` |
| **Remove AI Slop** | `no-ai-slop: <paste text>` | `no-ai-slop` |

> **How agents locate skills:**
> - **Gemini**: Auto-detects all skills globally once linked.
> - **Claude & Codex**: Read `AGENTS.md` / `CLAUDE.md` and load `.agents/skills/`.

---

## 🚀 Zero-Copy Setup (Stop Downloading Files)

Never manually download or copy markdown files into projects again.

### 1. Global Setup (Gemini / Antigravity)
Symlink all skills globally once. Every Gemini project inherits them automatically:
```bash
./scripts/export-skills.sh --symlink
```

### 2. Project Setup (Claude, Codex, Gemini)
Wire up any project in one command. Links `.agents/skills`, copies `AGENTS.md`, and creates `CLAUDE.md`:
```bash
./scripts/setup-project.sh /path/to/project
```

---

## 📦 Adding & Updating Skills

Paste GitHub URLs straight from your browser:

```bash
# Add a full repo
./scripts/add-skill.sh https://github.com/owner/repo

# Add a subpath / tree URL directly from browser
./scripts/add-skill.sh https://github.com/owner/repo/tree/main/skills/foo

# Update all tracked skills to latest commits
./scripts/update-skills.sh
```

---

## 🛠 CLI Cheat Sheet

| Task | Command |
| :--- | :--- |
| **List skills** | `./scripts/list-skills.sh` |
| **Add skill** | `./scripts/add-skill.sh <url_or_repo> [name]` |
| **Remove skill** | `./scripts/remove-skill.sh <name>` |
| **Update all** | `./scripts/update-skills.sh` |
| **Link project** | `./scripts/setup-project.sh <path>` |
| **Global link** | `./scripts/export-skills.sh --symlink` |
| **Integrity check** | `./scripts/check-skills.sh` |
