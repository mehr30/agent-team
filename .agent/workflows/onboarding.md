---
description: New developer onboarding - get up to speed quickly
---

# 🎓 Onboarding Mode

Help new developers get productive fast.

## First Day Checklist

### Environment Setup

```bash
# 1. Clone the repo
// turbo
git clone {repo_url}
cd {project_name}

# 2. Install dependencies
// turbo
npm install

# 3. Setup environment
// turbo
cp .env.example .env

# 4. Start database (if using Docker)
// turbo
docker-compose up -d db

# 5. Run migrations
// turbo
npm run db:migrate

# 6. Seed development data
// turbo
npm run db:seed

# 7. Start development server
// turbo
npm run dev
```

### Verify Setup

```bash
# Run tests
// turbo
npm test

# Check linting
// turbo
npm run lint

# Build project
// turbo
npm run build
```

---

## Project Overview

Generate a quick overview for new developers:

### Architecture
- [ ] What framework/stack are we using?
- [ ] How is the code organized?
- [ ] What are the main components?
- [ ] How do they communicate?

### Key Files to Know

| File/Folder | Purpose |
|-------------|---------|
| `src/index.ts` | Entry point |
| `src/routes/` | API endpoints |
| `src/services/` | Business logic |
| `src/models/` | Data models |
| `src/components/` | UI components |
| `.env.example` | Environment template |

### Common Commands

| Command | What it does |
|---------|--------------|
| `npm run dev` | Start dev server |
| `npm test` | Run tests |
| `npm run lint` | Check code style |
| `npm run build` | Build for production |
| `npm run db:migrate` | Run migrations |
| `npm run db:studio` | Open database GUI |

---

## Coding Standards

### Commit Messages
```
type(scope): description

feat(auth): add password reset flow
fix(api): handle null user gracefully
```

### Branch Naming
```
feat/{issue-number}-{description}
fix/{issue-number}-{description}
```

### PR Process
1. Create branch from `main`
2. Make changes with atomic commits
3. Push and create PR
4. Address review feedback
5. Squash merge when approved

---

## Getting Help

- **Documentation**: `/docs` folder
- **API Docs**: `/api-docs` endpoint
- **Team Chat**: Slack #dev-team
- **Questions**: Create GitHub Discussion

---

## First Tasks

Good first issues for ramping up:

1. **Documentation fix** - Easy, low risk
2. **Add a test** - Learn the codebase
3. **Fix a bug** - Small, well-defined
4. **Small feature** - After 1 week

---

## Development Workflow

```
1. Pick an issue
2. Create feature branch
3. Write code + tests
4. Run critic loop
5. Push and create PR
6. Address feedback
7. Merge when approved
```

---

## 🔄 Critic Loop

For onboarding materials:
> "Can a new dev actually follow these steps?"
> "Are all prerequisites listed?"
> "Are commands copy-paste ready?"
> "Is anything outdated?"

---

## 📝 Knowledge Logging

When onboarding reveals issues:
```markdown
### {date} - Onboarding: {Title}
**Issue**: What was confusing or broken
**Fixed**: How we improved it
**Prevention**: Docs/scripts updated
```
