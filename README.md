# handlag

Personal collection of AI skills, prompts, and agent rules.

---

## Skills Reference

| Skill | Trigger / Command | Function |
| :--- | :--- | :--- |
| `hallmark` | `hallmark audit <target>`, `hallmark redesign <target>` | Frontend UI design and anti-AI-slop rules |
| `humanizer` | `humanizer` | Tone adjustment for natural voice |
| `no-ai-slop` | `no-ai-slop` | Style enforcement and cliché removal |

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
Link `.agents/skills` and baseline `AGENTS.md` into a target repository:
```bash
./scripts/setup-project.sh /path/to/project
```

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
| `./scripts/setup-project.sh <path>` | Link skills into project |
| `./scripts/export-skills.sh --symlink` | Link skills globally |
| `./scripts/check-skills.sh` | Audit repository integrity |
