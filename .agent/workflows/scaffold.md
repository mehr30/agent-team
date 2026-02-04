---
description: Project scaffolding - create new projects with best practices baked in
---

# 🏗️ Scaffold Mode

Create new projects with production-ready configuration.

## Available Templates

| Command | Stack | Includes |
|---------|-------|----------|
| `scaffold:next` | Next.js 14 | App Router, TypeScript, Tailwind, ESLint |
| `scaffold:express` | Express.js | TypeScript, ESLint, Jest, Docker |
| `scaffold:fastapi` | FastAPI | Python, Pydantic, pytest, Docker |
| `scaffold:vite` | Vite React | TypeScript, Tailwind, Vitest |
| `scaffold:fullstack` | Next.js + API | Full stack monorepo |

---

## Next.js Scaffold

```bash
// turbo
npx -y create-next-app@latest ./ --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm
```

Then add:
- `.env.example`
- `docker-compose.yml`
- GitHub Actions CI
- Prettier config
- Jest/Vitest testing

---

## Express Scaffold

```bash
// turbo
npm init -y
npm install express cors helmet morgan dotenv
npm install -D typescript @types/node @types/express ts-node nodemon jest @types/jest ts-jest eslint prettier
```

Create structure:
```
src/
├── index.ts
├── routes/
├── controllers/
├── services/
├── middleware/
├── models/
└── utils/
```

---

## Standard Configuration Files

### TypeScript (tsconfig.json)
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "outDir": "dist",
    "rootDir": "src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### ESLint (.eslintrc.json)
```json
{
  "extends": ["eslint:recommended", "plugin:@typescript-eslint/recommended", "prettier"],
  "parser": "@typescript-eslint/parser",
  "plugins": ["@typescript-eslint"],
  "root": true
}
```

### Prettier (.prettierrc)
```json
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5"
}
```

### Docker (Dockerfile)
```dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

### GitHub Actions (.github/workflows/ci.yml)
```yaml
name: CI
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: 'npm'
      - run: npm ci
      - run: npm run lint
      - run: npm test
      - run: npm run build
```

---

## Environment Setup

### .env.example
```bash
# App
NODE_ENV=development
PORT=3000

# Database
DATABASE_URL=postgresql://user:pass@localhost:5432/db

# Auth
JWT_SECRET=your-secret-here

# External APIs
API_KEY=
```

### .gitignore
```
node_modules/
dist/
.env
.env.local
*.log
.DS_Store
coverage/
.next/
```

---

## Post-Scaffold Checklist

After scaffolding:
- [ ] Update `package.json` name and description
- [ ] Copy `.env.example` to `.env` and fill values
- [ ] Initialize git and make first commit
- [ ] Create GitHub repo and push
- [ ] Setup branch protection
- [ ] Add team members

---

## 🔄 Critic Loop

After scaffolding:
> "Is the folder structure appropriate for this project size?"
> "Did I include all necessary dev dependencies?"
> "Is the CI pipeline testing the right things?"
> "Are secrets properly excluded from git?"
