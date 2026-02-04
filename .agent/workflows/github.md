---
description: GitHub automation - repo management, issues, PRs, releases, branch protection
---

# 🐙 GitHub Automation Mode

You handle all GitHub operations automatically.

## Capabilities

### 1. Repository Management

```bash
# Create new repo
// turbo
gh repo create {name} --public --source=. --push

# Clone existing
// turbo
gh repo clone {owner}/{repo}

# Fork a repo
// turbo
gh repo fork {owner}/{repo} --clone

# View repo info
// turbo
gh repo view
```

### 2. Issue Management

```bash
# Create issue from bug
// turbo
gh issue create --title "Bug: {title}" --body "{description}" --label bug

# Create feature request
// turbo
gh issue create --title "Feature: {title}" --body "{description}" --label enhancement

# List open issues
// turbo
gh issue list --state open

# Close issue
// turbo
gh issue close {number} --comment "Fixed in #{pr_number}"
```

### 3. Pull Request Automation

```bash
# Create PR with template
// turbo
gh pr create --title "{type}({scope}): {title}" --body "## Changes
- {change1}
- {change2}

## Testing
- {test1}

Closes #{issue_number}"

# Add reviewers
// turbo
gh pr edit {number} --add-reviewer {user}

# Add labels
// turbo
gh pr edit {number} --add-label "{label}"

# Merge when ready
// turbo
gh pr merge {number} --squash --delete-branch
```

### 4. Release Automation

```bash
# Create release with auto-generated notes
// turbo
gh release create v{version} --generate-notes --title "v{version}"

# Create pre-release
// turbo
gh release create v{version}-beta --prerelease --title "v{version} Beta"

# List releases
// turbo
gh release list
```

### 5. Branch Protection (Recommend to User)

Suggest these settings for `main` branch:
- Require PR reviews before merging
- Require status checks to pass
- Require signed commits
- Include administrators

```bash
# View current rules
// turbo
gh api repos/{owner}/{repo}/branches/main/protection
```

---

## Auto-Actions

### On Bug Discovery
```
1. Create GitHub issue with bug label
2. Create feature branch: fix/{issue-number}-{slug}
3. Fix the bug
4. Create PR linking to issue
5. Request review
```

### On Feature Request
```
1. Create GitHub issue with enhancement label
2. Create feature branch: feat/{issue-number}-{slug}
3. Implement feature
4. Create PR linking to issue
5. Request review
```

### On Release
```
1. Update version in package.json
2. Update CHANGELOG.md
3. Commit: "chore: release v{version}"
4. Create git tag
5. Push with tags
6. Create GitHub release with notes
```

---

## Issue Templates

### Bug Report
```markdown
## Bug Description
{description}

## Steps to Reproduce
1. 
2. 
3. 

## Expected Behavior
{expected}

## Actual Behavior
{actual}

## Environment
- OS: 
- Node: 
- Browser: 
```

### Feature Request
```markdown
## Feature Description
{description}

## Use Case
{why_needed}

## Proposed Solution
{solution}

## Alternatives Considered
{alternatives}
```

---

## 🔄 Critic Loop

After GitHub operations:
> "Did I link the PR to the correct issue?"
> "Are the labels accurate?"
> "Did I add the right reviewers?"
> "Is the PR description clear?"

---

## 📝 Knowledge Logging

Log significant GitHub patterns to `CLAUDE.md`:
```markdown
### {date} - GitHub: {Title}
**Action**: What was done
**Pattern**: Reusable workflow
```
