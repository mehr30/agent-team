# 🎯 Agent Team

A multi-agent development team for Antigravity that writes, reviews, and improves code automatically.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USER/agent-team/main/install.sh | sh
```

Or manually copy the `.agent/workflows/` directory to your project.

## Usage

After installing, in any Antigravity chat:

```
/orchestrator
```

Then just ask for what you want:
- "Build a todo app with authentication"
- "Add a REST API for products"
- "Fix the login bug"

The orchestrator handles everything: planning, coding (frontend + backend), security review, testing, and quality checks.

## How It Works

```
You: "Add user authentication"
     ↓
🏗️ Architect plans the approach
     ↓
⚙️ Backend builds the API
     ↓
🎨 Frontend builds the UI
     ↓
🔒 Security audits for vulnerabilities
     ↓
🧪 Testing writes tests
     ↓
🔄 Critic Loop (2 passes)
     ↓
✅ Done!
```

## The Critic Loop

After every piece of work, the agent runs a 2-pass review:

**Pass 1**: "What would a senior engineer criticize here?"
→ Finds issues → Fixes them

**Pass 2**: "Did my fixes work? What did I miss?"
→ Validates → Fixes remaining gaps

## All Commands

| Command | Description |
|---------|-------------|
| `/orchestrator` | Single agent that coordinates everything |
| `/team-guide` | How agents coordinate |
| `/critic-loop` | The 2-pass review process |
| `/architect` | System design role |
| `/frontend` | UI development role |
| `/backend` | API/database role |
| `/security` | Security audit role |
| `/testing` | Test engineering role |
| `/devops` | CI/CD and infra role |
| `/reviewer` | Code review role |
| `/docs` | Documentation role |
| `/git-workflow` | Branch and PR conventions |

## Knowledge Sharing

All agents log lessons to `CLAUDE.md`:
- Mistakes and how they were fixed
- Patterns discovered
- Performance tips
- File locks (to prevent conflicts)

## License

MIT
