---
description: Master guide for coordinating multiple Antigravity agents as a development team
---

# Multi-Agent Development Team Guide

## Quick Start

Open **multiple VS Code windows** for this project and use these slash commands in each:

| Command | Role | Focus Areas |
|---------|------|-------------|
| `/architect` | 🏗️ System Architect | Design, cross-cutting concerns |
| `/security` | 🔒 Security Specialist | Audits, vulnerabilities, auth |
| `/frontend` | 🎨 Frontend Developer | UI, components, styling |
| `/backend` | ⚙️ Backend Developer | APIs, database, services |
| `/testing` | 🧪 Test Engineer | Unit, integration, E2E tests |
| `/devops` | 🔧 DevOps Engineer | CI/CD, Docker, deployment |
| `/reviewer` | 👁️ Code Reviewer | PR review, quality gate |
| `/docs` | 📝 Docs Writer | README, API docs, guides |

---

## 🔒 File Locking Protocol

**Before editing shared files**, claim them in `CLAUDE.md`:

1. Check the File Locks table in `CLAUDE.md`
2. If file is free, add your lock:
   ```markdown
   | /path/to/file | {your-role} | {timestamp} | active |
   ```
3. After committing, update status to `released`

> **Never edit a file that another agent has locked!**

---

## 🔁 Mandatory Self-Review

**Every agent must review their own work before committing:**

1. Re-check against role-specific quality standards
2. Test the changes work as expected
3. Look for edge cases or issues
4. Log any lessons learned to `CLAUDE.md`

---

## 🔀 Git Workflow

Use `/git-workflow` for full details. Quick reference:

- **Branch**: `{role}/{feature-name}`
- **Commit**: `{type}({scope}): {message}`
- **PR**: Created via `gh pr create`
- **Merge**: Only Reviewer agent merges

---

## Avoiding Conflicts

1. **Check file locks** in `CLAUDE.md` before editing
2. **Never edit the same file** in two agent windows
3. **Commit frequently** - small, focused commits
4. **Use feature branches** via `/git-workflow`
5. **Define interfaces first** in `CLAUDE.md`

---

## Recommended Workflow

```
1. Architect plans the feature
   ↓
2. Define interfaces in CLAUDE.md
   ↓
3. Backend + Frontend work in parallel
   ↓
4. Testing writes tests
   ↓
5. Each agent self-reviews
   ↓
6. Create PRs
   ↓
7. Reviewer approves and merges
   ↓
8. Security does final audit
```

---

## Directory Ownership

| Agent | Primary Directories |
|-------|---------------------|
| Architect | `/docs/architecture`, `CLAUDE.md` |
| Frontend | `/src/components`, `/src/pages`, `/src/styles`, `/public` |
| Backend | `/src/api`, `/src/services`, `/src/models`, `/src/lib` |
| Testing | `/tests`, `/e2e`, `*.test.*`, `*.spec.*` |
| DevOps | `/infra`, `/docker`, `/.github`, config files |
| Security | Reviews all, owns `/src/auth`, `/src/security` |
| Docs | `/docs`, `README.md`, `CHANGELOG.md` |
| Reviewer | Reviews PRs, doesn't own files |

