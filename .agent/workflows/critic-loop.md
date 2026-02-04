---
description: Critic Loop protocol - 2-pass critical review required after all work
---

# 🔄 Critic Loop Protocol

**Every agent must run the Critic Loop twice after completing work.**

This is not optional. This catches bugs before they ship.

---

## How It Works

### After completing ANY work:

**PASS 1 - THE CRITIC**
```
Ask yourself:

"If a senior engineer reviewed this right now, what would they criticize?
What's wrong, missing, fragile, insecure, or could break in production?"

List at least 3 issues. Be ruthless.
Then FIX each one.
```

**PASS 2 - THE VALIDATOR**
```
Ask yourself:

"Did my fixes actually work? Did they introduce new problems?
What did I miss the first time that's still broken?"

Review each fix. Find remaining gaps.
Then FIX those too.
```

---

## Issue Categories to Consider

| Category | Questions to Ask |
|----------|------------------|
| **Edge Cases** | Empty input? Null? Very large values? |
| **Error Handling** | What if this fails? Is the error helpful? |
| **Security** | Can this be exploited? Injected? Bypassed? |
| **Performance** | Will this scale? N+1 queries? Memory leaks? |
| **Readability** | Will future-me understand this? |
| **Testing** | Is this testable? What's not covered? |
| **Dependencies** | What if this external thing fails? |

---

## Template (Copy This)

```markdown
## 🔍 CRITIC LOOP - PASS 1

**Reviewing**: [what I just built]

Issues a senior engineer would raise:

1. **Issue**: [description]
   **Severity**: [high/medium/low]
   **Fix**: [how I fixed it]

2. **Issue**: [description]
   **Severity**: [high/medium/low]
   **Fix**: [how I fixed it]

3. **Issue**: [description]
   **Severity**: [high/medium/low]
   **Fix**: [how I fixed it]

---

## 🔍 CRITIC LOOP - PASS 2

Validating my fixes:

1. **Fix #1 check**: [Did it work? New issues?]
2. **Fix #2 check**: [Did it work? New issues?]
3. **Fix #3 check**: [Did it work? New issues?]

**Missed first time**: [anything else?]
**Final fix**: [if needed]

---

✅ **Critic Loop Complete** - Ready for commit
```

---

## Examples of Good Critic Findings

> **Issue**: No input validation on email field - could accept invalid formats
> **Fix**: Added email regex validation + error message

> **Issue**: API endpoint returns 500 on missing user instead of 404
> **Fix**: Added proper not-found handling with descriptive error

> **Issue**: Password stored in logs during debugging
> **Fix**: Removed console.log, added to .gitignore pattern

---

## Log to CLAUDE.md

After completing the critic loop, log significant discoveries:

```markdown
### {date} - Critic Catch: {Title}
**Issue**: What the loop caught
**Root Cause**: Why it happened
**Prevention**: How to avoid in future
```
