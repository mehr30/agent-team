---
description: Performance optimization - find and fix bottlenecks
---

# ⚡ Optimize Mode

Find and fix performance bottlenecks systematically.

## Optimization Process

```
1. MEASURE   → Get baseline metrics
2. PROFILE   → Find the bottleneck
3. ANALYZE   → Understand why it's slow
4. OPTIMIZE  → Fix the specific issue
5. VERIFY    → Measure improvement
6. DOCUMENT  → Record what worked
```

**Golden Rule**: Never optimize without measuring first!

---

## Step 1: Measure Baseline

### Frontend

```bash
# Lighthouse audit
// turbo
npx lighthouse http://localhost:3000 --output=json --output-path=./lighthouse.json

# Bundle size
// turbo
npx -y source-map-explorer dist/**/*.js
```

### Backend

```bash
# Load test with autocannon
// turbo
npx -y autocannon -c 100 -d 30 http://localhost:3000/api/endpoint

# Memory usage
// turbo
node --expose-gc --inspect dist/index.js
```

### Database

```sql
-- Query execution time
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@test.com';
```

---

## Step 2: Profile

### Node.js Profiling

```bash
# CPU profile
// turbo
node --prof dist/index.js
node --prof-process isolate-*.log > profile.txt

# Heap snapshot
// turbo
node --inspect dist/index.js
# Then use Chrome DevTools Memory tab
```

### React Profiling

```bash
# React DevTools Profiler
# Enable "Record why each component rendered"

# Or add to code:
import { Profiler } from 'react';
<Profiler id="Component" onRender={callback}>
```

---

## Common Bottlenecks & Fixes

### Database

| Problem | Solution |
|---------|----------|
| Missing index | Add index on queried columns |
| N+1 queries | Use eager loading / joins |
| Large result sets | Pagination, limit |
| Slow queries | Optimize query, add caching |

```typescript
// Before: N+1 problem
const users = await User.findAll();
for (const user of users) {
  user.posts = await Post.findAll({ where: { userId: user.id } });
}

// After: Eager loading
const users = await User.findAll({
  include: [{ model: Post }]
});
```

### Frontend

| Problem | Solution |
|---------|----------|
| Large bundle | Code splitting, lazy loading |
| Re-renders | React.memo, useMemo, useCallback |
| Heavy computation | Web Workers, debounce |
| Slow images | Lazy load, WebP, CDN |

```typescript
// Before: Renders on every parent render
function ExpensiveList({ items }) {
  return items.map(item => <Item key={item.id} {...item} />);
}

// After: Memoized
const ExpensiveList = React.memo(function ExpensiveList({ items }) {
  return items.map(item => <Item key={item.id} {...item} />);
});
```

### API

| Problem | Solution |
|---------|----------|
| Slow responses | Caching (Redis), CDN |
| High latency | Async processing, queues |
| Memory leaks | Fix closures, clear intervals |
| CPU blocking | Worker threads, streaming |

---

## Caching Strategies

```typescript
// In-memory cache (simple)
const cache = new Map();
function getCached(key, fetchFn, ttlMs = 60000) {
  const cached = cache.get(key);
  if (cached && Date.now() < cached.expires) {
    return cached.value;
  }
  const value = fetchFn();
  cache.set(key, { value, expires: Date.now() + ttlMs });
  return value;
}

// Redis cache
await redis.setex(`user:${id}`, 3600, JSON.stringify(user));
const cached = await redis.get(`user:${id}`);
```

---

## Performance Budget

Set limits and enforce them:

```json
{
  "budgets": [
    { "metric": "first-contentful-paint", "budget": 1500 },
    { "metric": "total-blocking-time", "budget": 300 },
    { "metric": "bundle-size", "budget": 250000 }
  ]
}
```

---

## 🔄 Critic Loop

After optimizing:
> "Did I measure before AND after?"
> "Is the improvement significant?"
> "Did I introduce complexity for marginal gains?"
> "Will this optimization cause issues at scale?"

---

## 📝 Knowledge Logging

```markdown
### {date} - Optimization: {Title}
**Before**: {metric} = {old_value}
**After**: {metric} = {new_value}
**Improvement**: {percentage}%
**Technique**: What was changed
```
