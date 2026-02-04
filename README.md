# 🎯 Agent Team

AI dev team for Antigravity. One command to install, one command to use.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USER/agent-team/main/install.sh | sh
```

## Use

```
/orchestrator
```

That's it. Ask for anything:
- "Build a todo app"
- "Add authentication"
- "Fix the login bug"

## What It Does

The orchestrator is a full dev team in one agent:
- 🏗️ Plans the architecture
- ⚙️ Writes backend code
- 🎨 Builds the frontend
- 🗄️ Designs the database
- 🔒 Audits security
- 🧪 Writes tests
- 🔄 Reviews its own work (2-pass critic loop)
- ✅ Commits when done

## Push to GitHub

To make this installable for future projects:

```bash
gh repo create agent-team --public --source=. --push
```

Then update `install.sh` and `README.md` to replace `YOUR_USER` with your GitHub username.
