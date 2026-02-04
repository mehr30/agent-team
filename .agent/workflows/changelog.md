---
description: Changelog automation - track and document all changes
---

# 📋 Changelog Mode

Automatically maintain comprehensive changelogs.

## Changelog Format (Keep a Changelog)

```markdown
# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- New features

### Changed
- Changes in existing functionality

### Deprecated
- Soon-to-be removed features

### Removed
- Removed features

### Fixed
- Bug fixes

### Security
- Vulnerability fixes

## [1.0.0] - 2024-01-15

### Added
- Initial release
```

---

## Conventional Commits

Format: `type(scope): description`

| Type | Changelog Section |
|------|-------------------|
| `feat` | Added |
| `fix` | Fixed |
| `perf` | Changed |
| `refactor` | Changed |
| `docs` | (usually skip) |
| `style` | (usually skip) |
| `test` | (usually skip) |
| `chore` | (usually skip) |
| `BREAKING CHANGE` | ⚠️ Special callout |

---

## Auto-Generate Changelog

### Using conventional-changelog

```bash
# Install
npm install -D conventional-changelog-cli

# Generate changelog
// turbo
npx conventional-changelog -p angular -i CHANGELOG.md -s

# First time (full history)
// turbo
npx conventional-changelog -p angular -i CHANGELOG.md -s -r 0
```

### Using release-it

```bash
# Install
npm install -D release-it @release-it/conventional-changelog

# Configure (.release-it.json)
{
  "git": {
    "commitMessage": "chore: release v${version}"
  },
  "github": {
    "release": true
  },
  "plugins": {
    "@release-it/conventional-changelog": {
      "preset": "angular",
      "infile": "CHANGELOG.md"
    }
  }
}

# Run release
// turbo
npx release-it
```

---

## Semantic Versioning

`MAJOR.MINOR.PATCH`

| Bump | When | Example |
|------|------|---------|
| MAJOR | Breaking changes | `1.0.0` → `2.0.0` |
| MINOR | New features (backward compatible) | `1.0.0` → `1.1.0` |
| PATCH | Bug fixes | `1.0.0` → `1.0.1` |

---

## Release Process

```bash
# 1. Update version
npm version minor  # or major/patch

# 2. Generate changelog
npx conventional-changelog -p angular -i CHANGELOG.md -s

# 3. Commit changelog
git add CHANGELOG.md
git commit --amend --no-edit

# 4. Push with tags
// turbo
git push origin main --tags

# 5. Create GitHub release
// turbo
gh release create v$(node -p "require('./package.json').version") --generate-notes
```

---

## Changelog Entry Template

When writing manual entries:

```markdown
## [1.2.0] - 2024-01-20

### Added
- Add user profile page with avatar upload (#123)
- Add dark mode toggle in settings (#125)

### Fixed
- Fix login redirect loop on expired sessions (#122)
- Fix mobile menu not closing on navigation (#124)

### Security
- Update lodash to fix prototype pollution vulnerability
```

---

## Breaking Change Documentation

For breaking changes, add migration guide:

```markdown
## [2.0.0] - 2024-02-01

### ⚠️ BREAKING CHANGES

- **API**: Changed `getUser(id)` to return `null` instead of throwing on not found
  
  **Migration**: 
  ```javascript
  // Before
  try {
    const user = await getUser(id);
  } catch (e) {
    // handle not found
  }
  
  // After
  const user = await getUser(id);
  if (!user) {
    // handle not found
  }
  ```

- **Config**: Renamed `API_KEY` environment variable to `APP_API_KEY`
```

---

## 🔄 Critic Loop

After changelog updates:
> "Are all user-facing changes documented?"
> "Are breaking changes clearly marked?"
> "Is the version bump correct (major/minor/patch)?"
> "Are migration instructions provided for breaking changes?"

---

## 📝 Knowledge Logging

```markdown
### {date} - Release: v{version}
**Type**: Major / Minor / Patch
**Highlights**: Key changes
**Breaking**: Any breaking changes?
```
