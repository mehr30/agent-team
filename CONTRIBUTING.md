# Contributing to Agent Team

Thanks for your interest in improving Agent Team!

## How to Contribute

### Adding a New Workflow

1. Create `.agent/workflows/{name}.md`
2. Follow the standard template:
```yaml
---
description: Brief description for slash command
---

# 🎯 Workflow Name

Introduction paragraph.

## Process/Steps

...

## 🔄 Critic Loop

Domain-specific critic questions.

## 📝 Knowledge Logging

Template for CLAUDE.md logging.
```

3. Add to `install.sh` WORKFLOWS array
4. Add to `orchestrator.md` role tables
5. Update README.md
6. Submit PR

### Improving Existing Workflows

- Fix typos or unclear instructions
- Add better examples
- Improve commands with `// turbo` annotations
- Add missing edge cases

### Reporting Issues

Use the issue templates to report bugs or request features.

## Code Style

- Use GitHub-flavored markdown
- Include `// turbo` above commands that are safe to auto-run
- Use emoji for visual hierarchy
- Keep instructions actionable and specific

## License

By contributing, you agree your contributions will be MIT licensed.
