---
description: Database and API migrations - safe data and schema changes
---

# 🔄 Migrate Mode

Handle database and API migrations safely.

## Migration Types

| Type | Risk | Strategy |
|------|------|----------|
| Add column/table | Low | Direct migration |
| Rename column | Medium | Two-phase deploy |
| Delete column | Medium | Deprecate first |
| Change type | High | Create new, migrate, delete old |
| API breaking change | High | Version API |

---

## Database Migration Process

### Safe Migration Pattern

```
1. BACKUP    → Always backup before migrating
2. TEST      → Run migration on staging first
3. DEPLOY    → Deploy code that works with old AND new schema
4. MIGRATE   → Run migration
5. VERIFY    → Check data integrity
6. CLEANUP   → Remove old column support (next release)
```

---

## Adding a Column (Safe)

```bash
# Generate migration
// turbo
npm run db:generate -- --name add_phone_to_users
```

```sql
-- Migration: add nullable column (safe)
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- Later: backfill data
UPDATE users SET phone = '' WHERE phone IS NULL;

-- Later: make not null if needed
ALTER TABLE users ALTER COLUMN phone SET NOT NULL;
```

---

## Renaming a Column (Two-Phase)

### Phase 1: Add new column, copy data
```sql
-- Add new column
ALTER TABLE users ADD COLUMN full_name VARCHAR(255);

-- Copy data
UPDATE users SET full_name = name;

-- Update code to write to BOTH columns
```

### Phase 2: Switch reads, drop old
```sql
-- After code only reads from full_name
ALTER TABLE users DROP COLUMN name;
```

---

## Deleting a Column (Deprecate First)

```
Release 1: Stop writing to column (code change)
Release 2: Stop reading from column (code change)
Release 3: Drop column (migration)
```

---

## API Versioning

### URL Versioning
```
/api/v1/users  → Old version
/api/v2/users  → New version
```

### Header Versioning
```
Accept: application/vnd.api+json; version=2
```

### Deprecation Headers
```typescript
res.set('Deprecation', 'true');
res.set('Sunset', 'Sat, 31 Dec 2024 23:59:59 GMT');
res.set('Link', '</api/v2/users>; rel="successor-version"');
```

---

## Breaking Change Checklist

Before making breaking changes:

- [ ] Document the change in CHANGELOG
- [ ] Notify API consumers (if external)
- [ ] Provide migration guide
- [ ] Set deprecation timeline (minimum 2 weeks)
- [ ] Add deprecation warnings in responses
- [ ] Create v2 endpoint
- [ ] Keep v1 working during transition

---

## Rollback Plan

Always have a rollback:

```bash
# Database rollback
// turbo
npm run db:rollback

# Git rollback
// turbo
git revert HEAD

# Deployment rollback
// turbo
git push origin HEAD~1:main --force  # Only if necessary!
```

---

## Data Migration Script Template

```typescript
// scripts/migrate-data.ts
async function migrateData() {
  const BATCH_SIZE = 1000;
  let offset = 0;
  let processed = 0;

  while (true) {
    const batch = await db.users.findMany({
      take: BATCH_SIZE,
      skip: offset,
    });

    if (batch.length === 0) break;

    for (const user of batch) {
      await db.users.update({
        where: { id: user.id },
        data: { newField: transformOldField(user.oldField) },
      });
      processed++;
    }

    console.log(`Processed ${processed} records`);
    offset += BATCH_SIZE;
  }

  console.log(`Migration complete: ${processed} records`);
}
```

---

## 🔄 Critic Loop

After migrations:
> "Did I test on staging first?"
> "Is there a rollback plan?"
> "Did I backup the data?"
> "Are there any edge cases in the data transformation?"

---

## 📝 Knowledge Logging

```markdown
### {date} - Migration: {Title}
**Type**: Schema / Data / API
**Risk**: Low / Medium / High
**Rollback**: How to undo if needed
**Gotchas**: Issues encountered
```
