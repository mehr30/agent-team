---
description: Safe refactoring - improve code structure without breaking functionality
---

# ♻️ Refactor Mode

Improve code quality while ensuring nothing breaks.

## Golden Rules

1. **Never refactor without tests** - Add tests first if none exist
2. **One change at a time** - Don't mix multiple refactors
3. **Run tests after each change** - Catch breaks immediately
4. **Keep commits atomic** - Easy to revert if needed

---

## Refactoring Process

```
1. IDENTIFY  → What needs improvement?
2. TEST      → Ensure coverage exists
3. REFACTOR  → Make ONE change
4. VERIFY    → Run all tests
5. COMMIT    → Small, atomic commit
6. REPEAT    → Next improvement
```

---

## Common Refactorings

### Extract Function
```typescript
// Before
function processOrder(order) {
  // 50 lines of validation
  // 30 lines of calculation
  // 20 lines of formatting
}

// After
function processOrder(order) {
  validateOrder(order);
  const total = calculateTotal(order);
  return formatResponse(order, total);
}
```

### Extract Variable
```typescript
// Before
if (user.age >= 18 && user.country === 'US' && user.verified) {

// After
const isEligible = user.age >= 18 && user.country === 'US' && user.verified;
if (isEligible) {
```

### Rename for Clarity
```typescript
// Before
const d = new Date();
const x = users.filter(u => u.a);

// After
const currentDate = new Date();
const activeUsers = users.filter(user => user.isActive);
```

### Replace Magic Numbers
```typescript
// Before
if (password.length < 8) {
setTimeout(retry, 30000);

// After
const MIN_PASSWORD_LENGTH = 8;
const RETRY_DELAY_MS = 30_000;
if (password.length < MIN_PASSWORD_LENGTH) {
setTimeout(retry, RETRY_DELAY_MS);
```

### Simplify Conditionals
```typescript
// Before
if (status === 'active') {
  return true;
} else {
  return false;
}

// After
return status === 'active';
```

---

## Code Smell Checklist

Look for these problems:

- [ ] **Long functions** (> 30 lines)
- [ ] **Deep nesting** (> 3 levels)
- [ ] **Duplicate code** (copy-paste)
- [ ] **Magic numbers** (unexplained constants)
- [ ] **Dead code** (unused functions/variables)
- [ ] **God objects** (classes doing too much)
- [ ] **Long parameter lists** (> 4 params)
- [ ] **Comments explaining bad code** (fix the code instead)

---

## Safe Refactoring Commands

```bash
# Check test coverage first
// turbo
npm run test:coverage

# Run tests in watch mode while refactoring
// turbo
npm test -- --watch

# Lint after refactoring
// turbo
npm run lint -- --fix

# Type check
// turbo
npx tsc --noEmit
```

---

## Refactoring Commit Convention

```
refactor({scope}): {what was improved}

Examples:
- refactor(auth): extract validation into separate function
- refactor(api): rename unclear variable names
- refactor(utils): remove duplicate date formatting logic
```

---

## 🔄 Critic Loop

After each refactoring:
> "Did I change any behavior, even subtly?"
> "Are all tests still passing?"
> "Is the code actually clearer now?"
> "Did I introduce any new dependencies?"

---

## 📝 Knowledge Logging

Log refactoring patterns to `CLAUDE.md`:
```markdown
### {date} - Refactor: {Title}
**Before**: What was wrong
**After**: What improved
**Technique**: Refactoring pattern used
```
