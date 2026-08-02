# handlag

A personal collection of AI skills, prompts, and know-how.

## Structure

```
handlag/
├── .github/workflows/
│   ├── update-skills.yml    # Weekly automatic skill updater workflow
│   └── validate.yml         # CI validation workflow on pushes & PRs
├── scripts/
│   ├── add-skill.sh         # Vendor a skill (supports root repos and subpaths)
│   ├── remove-skill.sh      # Remove a vendored skill
│   ├── list-skills.sh       # List all installed skills and metadata
│   ├── update-skills.sh     # Update all tracked skills in sources.json
│   ├── check-skills.sh      # Audit repository & skill integrity
│   └── export-skills.sh     # Copy or symlink skills into your AI assistant directory
├── skills/                  # Vendored skill folders
├── sources.json             # Registry tracking skill sources, SHAs, and descriptions
└── README.md
```

## Usage

### Add a Skill

Vendor a skill from a GitHub repository or subpath:

```bash
# Standard repository root
./scripts/add-skill.sh <owner/repo> [name]

# Repository subpath
./scripts/add-skill.sh <owner/repo/sub/path> [name]
```

### Remove a Skill

Uninstall a skill and clean up its registry entry:

```bash
./scripts/remove-skill.sh <name>
```

### List Installed Skills

Display a summary table of tracked skills:

```bash
./scripts/list-skills.sh
```

### Update All Skills

Re-fetch and update all tracked skills to their latest commit:

```bash
./scripts/update-skills.sh
```

### Audit & Validate Repository

Check parity between `sources.json` and `skills/`:

```bash
./scripts/check-skills.sh
```

### Export Skills to AI Assistant

Copy or symlink skills into your AI assistant's skill directory (defaults to `~/.gemini/antigravity/skills`):

```bash
# Copy mode (default)
./scripts/export-skills.sh [target_directory]

# Symlink mode
./scripts/export-skills.sh [target_directory] --symlink
```

## Requirements

- `bash`
- `jq`
- `npx` (for `degit`)
