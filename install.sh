#!/bin/bash
# Agent Team Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/YOUR_USER/agent-team/main/install.sh | sh

set -e

REPO_URL="https://raw.githubusercontent.com/mehr30/agent-team/main"
WORKFLOWS_DIR=".agent/workflows"

echo "🎯 Installing Agent Team..."

# Create directories
mkdir -p "$WORKFLOWS_DIR"

# Download workflow files
WORKFLOWS=(
  # Core
  "orchestrator.md"
  "critic-loop.md"
  "team-guide.md"
  "git-workflow.md"
  # Roles
  "architect.md"
  "security.md"
  "frontend.md"
  "backend.md"
  "database.md"
  "testing.md"
  "devops.md"
  "reviewer.md"
  "docs.md"
  # Advanced
  "github.md"
  "scaffold.md"
  "debug.md"
  "refactor.md"
  "optimize.md"
  "migrate.md"
  "monitor.md"
  "dependencies.md"
  "changelog.md"
  "auto-docs.md"
  "onboarding.md"
  "emergency.md"
  "complexity.md"
)

echo "📥 Downloading workflows..."
for file in "${WORKFLOWS[@]}"; do
  curl -fsSL "$REPO_URL/.agent/workflows/$file" -o "$WORKFLOWS_DIR/$file"
  echo "   ✓ $file"
done

# Download CLAUDE.md if it doesn't exist
if [ ! -f "CLAUDE.md" ]; then
  echo "📥 Creating CLAUDE.md..."
  curl -fsSL "$REPO_URL/CLAUDE.md" -o "CLAUDE.md"
  echo "   ✓ CLAUDE.md"
fi

# Initialize git if not present
if [ ! -d ".git" ]; then
  echo "📦 Initializing git..."
  git init -q
  git add -A
  git commit -q -m "chore: initial commit with agent team"
  echo "   ✓ Git initialized"
fi

echo ""
echo "✅ Agent Team installed!"
echo ""
echo "🚀 Quick Start:"
echo "   1. Open VS Code in this directory"
echo "   2. Open Antigravity chat"
echo "   3. Type: /orchestrator"
echo "   4. Ask for anything!"
echo ""
echo "📚 Available commands:"
echo "   /orchestrator  - Single agent that does everything"
echo "   /team-guide    - See all roles and coordination"
echo "   /critic-loop   - Learn about the review process"
echo ""
