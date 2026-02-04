---
description: Dependency management - vulnerability scanning, updates, license compliance
---

# 📦 Dependencies Mode

Manage dependencies safely and securely.

## Security Scanning

### NPM Audit

```bash
# Full audit
// turbo
npm audit

# Fix automatically (minor/patch)
// turbo
npm audit fix

# See what would be fixed
// turbo
npm audit fix --dry-run

# Force fix (may break things)
npm audit fix --force  # Use with caution!
```

### Snyk (More Comprehensive)

```bash
# Install
// turbo
npm install -g snyk

# Authenticate
// turbo
snyk auth

# Scan project
// turbo
snyk test

# Monitor continuously
// turbo
snyk monitor
```

---

## Updating Dependencies

### Check for Updates

```bash
# See outdated packages
// turbo
npm outdated

# Interactive update tool
// turbo
npx -y npm-check-updates -i
```

### Safe Update Process

1. **Check what's outdated**
   ```bash
   npm outdated
   ```

2. **Read changelogs** for breaking changes

3. **Update one at a time** (for major versions)
   ```bash
   npm install package@latest
   ```

4. **Run tests after each update**
   ```bash
   npm test
   ```

5. **Commit separately**
   ```bash
   git commit -m "chore(deps): update package to v2.0"
   ```

---

## Lock File Management

```bash
# Regenerate lock file
// turbo
rm -rf node_modules package-lock.json && npm install

# Check for lock file drift
// turbo
npm ci  # Fails if lock file doesn't match package.json
```

---

## License Compliance

### Check Licenses

```bash
# List all licenses
// turbo
npx -y license-checker --summary

# Check for problematic licenses
// turbo
npx -y license-checker --failOn "GPL;AGPL"

# Generate license report
// turbo
npx -y license-checker --json > licenses.json
```

### License Categories

| License | Commercial Use | Notes |
|---------|----------------|-------|
| MIT | ✅ Safe | Do anything |
| Apache-2.0 | ✅ Safe | Attribution required |
| BSD | ✅ Safe | Attribution required |
| ISC | ✅ Safe | Similar to MIT |
| GPL | ⚠️ Copyleft | Must open source your code |
| AGPL | ⚠️ Strong copyleft | Even network use triggers |
| Unlicensed | ❌ Avoid | No permission granted |

---

## Dependency Health Checklist

Before adding a new dependency:

- [ ] **Is it maintained?** (Last commit < 1 year)
- [ ] **Is it popular?** (npm downloads, GitHub stars)
- [ ] **Is it secure?** (No known vulnerabilities)
- [ ] **Is the license compatible?**
- [ ] **Is it really needed?** (Can we do without it?)
- [ ] **How big is it?** (Bundle size impact)

```bash
# Check package size
// turbo
npx -y bundlephobia-cli {package-name}
```

---

## Renovate/Dependabot Setup

### GitHub Dependabot (.github/dependabot.yml)

```yaml
version: 2
updates:
  - package-ecosystem: npm
    directory: "/"
    schedule:
      interval: weekly
    open-pull-requests-limit: 10
    labels:
      - dependencies
    commit-message:
      prefix: "chore(deps):"
```

---

## 🔄 Critic Loop

After dependency changes:
> "Did I check for breaking changes?"
> "Are there any new vulnerabilities?"
> "Is the license still compatible?"
> "Did I run the full test suite?"

---

## 📝 Knowledge Logging

```markdown
### {date} - Dependency: {Package}
**Action**: Added / Updated / Removed
**Version**: From v1.0 → v2.0
**Breaking**: Yes/No - what changed
**Why**: Reason for change
```
