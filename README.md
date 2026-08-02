# handlag

A personal collection of AI skills, prompts, and know-how.

## Structure

- `skills/` — Vendored skill folders.
- `sources.json` — Registry tracking all vendored skills and their source commits.
- `scripts/` — Helper scripts for managing skills.
  - `add-skill.sh` — Vendor a skill from a GitHub repository.

## Usage

To add a new skill:

```bash
./scripts/add-skill.sh <owner/repo> [name]
```

Each skill directory under `skills/` contains a `SOURCE.md` file tracking the upstream repository URL, commit SHA, and date added.

## Requirements

- `bash`
- `jq`
- `npx` (for `degit`)
