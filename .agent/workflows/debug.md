---
description: Systematic debugging - find and fix bugs methodically
---

# 🐛 Debug Mode

Systematic approach to finding and fixing bugs.

## Debug Process

```
1. REPRODUCE → Confirm the bug exists
2. ISOLATE   → Find the smallest test case
3. LOCATE    → Find the exact code causing it
4. UNDERSTAND → Why does this happen?
5. FIX       → Make the minimal change
6. VERIFY    → Confirm it's fixed
7. PROTECT   → Add test to prevent regression
```

---

## Step 1: Reproduce

```bash
# Get exact error message
// turbo
npm run dev 2>&1 | head -50

# Check logs
// turbo
tail -100 logs/error.log

# Run failing test
// turbo
npm test -- --grep "{test_name}"
```

Document:
- Exact steps to reproduce
- Expected vs actual behavior
- Error message (full stack trace)
- Environment (OS, Node version, browser)

---

## Step 2: Isolate

Reduce to minimal reproduction:
- Remove unrelated code
- Simplify inputs
- Create standalone test case

```typescript
// Minimal reproduction
it('reproduces the bug', () => {
  const input = { /* minimal input */ };
  const result = buggyFunction(input);
  expect(result).toBe(expected); // This fails
});
```

---

## Step 3: Locate

Find the exact line:

```bash
# Add debug logging
console.log('[DEBUG] variable:', variable);

# Use debugger
node --inspect-brk dist/index.js

# Binary search with git bisect
// turbo
git bisect start
git bisect bad HEAD
git bisect good {known_good_commit}
```

---

## Step 4: Understand

Before fixing, understand WHY:
- What assumption was wrong?
- What edge case wasn't handled?
- What changed to cause this?

Document the root cause:
```markdown
**Root Cause**: The function assumed `user.email` would always exist,
but when users sign up via OAuth, email can be null.
```

---

## Step 5: Fix

Make the minimal change:
- Don't refactor while fixing bugs
- Fix only the specific issue
- Keep the diff small

```typescript
// Before (buggy)
const email = user.email.toLowerCase();

// After (fixed)
const email = user.email?.toLowerCase() ?? '';
```

---

## Step 6: Verify

```bash
# Run the specific test
// turbo
npm test -- --grep "{test_name}"

# Run full test suite
// turbo
npm test

# Manual verification
# Reproduce original steps - bug should be gone
```

---

## Step 7: Protect

Add regression test:

```typescript
it('handles null email gracefully', () => {
  const user = { id: '1', email: null };
  const result = formatUser(user);
  expect(result.email).toBe('');
});
```

---

## Common Bug Patterns

| Pattern | Symptom | Fix |
|---------|---------|-----|
| Null reference | `Cannot read property of undefined` | Optional chaining `?.` |
| Race condition | Intermittent failures | Proper async/await |
| Off-by-one | Wrong array length | Check loop bounds |
| Type coercion | `"1" + 1 = "11"` | Explicit type conversion |
| Stale closure | Old value in callback | Use refs or deps array |

---

## 🔄 Critic Loop

After fixing:
> "Did I fix the root cause or just a symptom?"
> "Could this same bug occur elsewhere?"
> "Is my fix the simplest possible?"
> "Did I add a regression test?"

---

## 📝 Knowledge Logging

Log bugs to `CLAUDE.md`:
```markdown
### {date} - Bug Fix: {Title}
**Symptom**: What was observed
**Root Cause**: Why it happened
**Fix**: What was changed
**Prevention**: How to avoid similar bugs
```
