---
description: Emergency response - handle production incidents systematically
---

# 🚨 Emergency Mode

Handle production incidents with minimal downtime.

## Severity Levels

| Level | Definition | Response Time |
|-------|------------|---------------|
| **SEV1** | Site down, all users affected | Immediate (24/7) |
| **SEV2** | Major feature broken, many users affected | < 1 hour |
| **SEV3** | Minor feature broken, some users affected | < 4 hours |
| **SEV4** | Cosmetic issue, workaround exists | Next business day |

---

## Incident Response Process

```
1. DETECT   → Alert received
2. TRIAGE   → Assess severity
3. ASSEMBLE → Get the right people
4. MITIGATE → Stop the bleeding
5. FIX      → Root cause fix
6. VERIFY   → Confirm resolution
7. POSTMORTEM → Learn from it
```

---

## Step 1: Detect & Triage

```bash
# Check service status
// turbo
curl -s https://your-app.com/health | jq

# Check recent deploys
// turbo
gh release list --limit 5

# Check error rates
# (Check your monitoring dashboard)
```

Questions to answer:
- What's actually broken?
- When did it start?
- What changed recently?
- How many users affected?

---

## Step 2: Mitigate (Stop the Bleeding)

### Common Quick Fixes

**Recent deploy broke things?**
```bash
# Rollback to previous version
// turbo
git revert HEAD --no-commit
git commit -m "revert: emergency rollback"
git push origin main
```

**Database overloaded?**
```bash
# Kill long-running queries
# Scale up read replicas
# Enable maintenance mode
```

**Traffic spike?**
```bash
# Scale up servers
# Enable rate limiting
# Activate CDN caching
```

**Memory/CPU exhausted?**
```bash
# Restart services
# Scale horizontally
# Kill memory-hungry processes
```

---

## Step 3: Communicate

### Status Page Update
```markdown
**Investigating**: We're aware of issues with [feature] and investigating.
**Identified**: The issue is caused by [cause]. Working on a fix.
**Monitoring**: A fix has been deployed. Monitoring for stability.
**Resolved**: The incident is resolved. [Summary of what happened]
```

### Stakeholder Update Template
```markdown
**Status**: [Investigating/Mitigating/Resolved]
**Impact**: [What's broken, who's affected]
**ETA**: [When do we expect resolution]
**Next Update**: [When will we update again]
```

---

## Step 4: Fix & Verify

```bash
# Deploy the fix
// turbo
git push origin main

# Verify fix is deployed
// turbo
curl -s https://your-app.com/health

# Check error rates dropping
# Monitor for 15-30 minutes
```

---

## Step 5: Postmortem

### Postmortem Template

```markdown
# Incident Postmortem: [Title]

**Date**: YYYY-MM-DD
**Duration**: X hours Y minutes
**Severity**: SEV1/2/3/4
**Author**: [Name]

## Summary
One paragraph summary of what happened.

## Timeline
- HH:MM - Alert triggered
- HH:MM - Team assembled
- HH:MM - Root cause identified
- HH:MM - Fix deployed
- HH:MM - Incident resolved

## Root Cause
What actually caused the incident?

## Impact
- X users affected
- $Y revenue lost
- Z minutes of downtime

## What Went Well
- Detection was fast
- Rollback worked smoothly

## What Went Wrong
- Monitoring didn't catch it early
- Runbook was outdated

## Action Items
- [ ] Add monitoring for X (@owner, due: date)
- [ ] Update runbook for Y (@owner, due: date)
- [ ] Add test for Z (@owner, due: date)
```

---

## Emergency Contacts

Document these somewhere accessible:
- On-call engineer
- Database admin
- Infrastructure lead
- Product manager
- Customer support lead

---

## 🔄 Critic Loop

After incident resolution:
> "Did we find the actual root cause?"
> "What monitoring would have caught this earlier?"
> "Is the fix permanent or temporary?"
> "What prevented us from resolving faster?"

---

## 📝 Knowledge Logging

```markdown
### {date} - Incident: {Title}
**Severity**: SEV1/2/3/4
**Duration**: X hours
**Root Cause**: What happened
**Prevention**: How to avoid in future
```
