---
description: Git workflow for autonomous PRs - branch creation, commits, and pull requests
---

# 🔀 Git Workflow

All agents follow this workflow for version control.

## Branch Naming

```
{role}/{feature-name}
```

Examples:
- `frontend/login-form`
- `backend/user-api`
- `security/auth-audit`
- `devops/ci-pipeline`

## Before Starting Work

```bash
# Fetch latest
// turbo
git fetch origin

# Create feature branch from main
// turbo
git checkout -b {role}/{feature-name} origin/main
```

## Commit Convention

```
{type}({scope}): {description}

Types: feat, fix, docs, style, refactor, test, chore
Scope: component or area affected
```

Examples:
- `feat(auth): add password reset flow`
- `fix(api): handle null user gracefully`
- `test(login): add e2e tests for login form`

## Creating a Pull Request

```bash
# Stage and commit
// turbo
git add -A && git commit -m "{type}({scope}): {description}"

# Push branch
// turbo
git push -u origin HEAD

# Create PR with gh CLI
// turbo
gh pr create --title "{type}({scope}): {description}" --body "## Changes\n\n- Description of changes\n\n## Testing\n\n- How it was tested" --assignee @me
```

## PR Review Assignment

| Author Role | Reviewer Roles |
|-------------|----------------|
| Frontend | Reviewer, Security |
| Backend | Reviewer, Security |
| Security | Reviewer, Architect |
| Testing | Reviewer |
| DevOps | Reviewer, Security |

## Merging

Only the **Code Reviewer** agent merges PRs after approval:

```bash
// turbo
gh pr merge --squash --delete-branch
```
