---
description: Code complexity analysis - identify and reduce complex code
---

# 🧮 Complexity Mode

Analyze and reduce code complexity.

## Complexity Metrics

| Metric | Tool | Threshold |
|--------|------|-----------|
| Cyclomatic Complexity | ESLint | < 10 per function |
| Cognitive Complexity | SonarQube | < 15 per function |
| Lines per Function | ESLint | < 50 lines |
| Dependencies per File | Manual | < 10 imports |
| File Size | Manual | < 400 lines |

---

## Measuring Complexity

### ESLint Complexity Rules

```json
{
  "rules": {
    "complexity": ["error", { "max": 10 }],
    "max-lines-per-function": ["warn", { "max": 50 }],
    "max-depth": ["warn", { "max": 4 }],
    "max-params": ["warn", { "max": 4 }],
    "max-nested-callbacks": ["warn", { "max": 3 }]
  }
}
```

### Run Complexity Analysis

```bash
# ESLint with complexity
// turbo
npx eslint src --rule 'complexity: [error, 10]' --format compact

# Full complexity report
// turbo
npx -y complexity-report src/**/*.ts
```

---

## Reducing Complexity

### 1. Extract Functions

```typescript
// Before: High complexity (nested conditions)
function processOrder(order) {
  if (order.items.length > 0) {
    if (order.customer.isActive) {
      if (order.total > 100) {
        // apply discount
      }
    }
  }
}

// After: Lower complexity (extracted conditions)
function processOrder(order) {
  if (!hasItems(order)) return;
  if (!isActiveCustomer(order)) return;
  if (qualifiesForDiscount(order)) {
    applyDiscount(order);
  }
}
```

### 2. Use Early Returns

```typescript
// Before: Deep nesting
function validate(user) {
  if (user) {
    if (user.email) {
      if (isValidEmail(user.email)) {
        return true;
      }
    }
  }
  return false;
}

// After: Early returns
function validate(user) {
  if (!user) return false;
  if (!user.email) return false;
  if (!isValidEmail(user.email)) return false;
  return true;
}
```

### 3. Replace Switch with Maps

```typescript
// Before: Long switch
function getStatusText(status) {
  switch (status) {
    case 'pending': return 'Pending';
    case 'active': return 'Active';
    case 'cancelled': return 'Cancelled';
    default: return 'Unknown';
  }
}

// After: Object map
const STATUS_TEXT = {
  pending: 'Pending',
  active: 'Active',
  cancelled: 'Cancelled',
};
const getStatusText = (status) => STATUS_TEXT[status] ?? 'Unknown';
```

### 4. Use Strategy Pattern

```typescript
// Before: Complex conditionals
function calculatePrice(type, amount) {
  if (type === 'basic') {
    return amount * 1.0;
  } else if (type === 'premium') {
    return amount * 0.9;
  } else if (type === 'enterprise') {
    return amount * 0.8;
  }
}

// After: Strategy pattern
const pricingStrategies = {
  basic: (amount) => amount * 1.0,
  premium: (amount) => amount * 0.9,
  enterprise: (amount) => amount * 0.8,
};
const calculatePrice = (type, amount) => pricingStrategies[type](amount);
```

---

## Complexity Smells

Watch for these indicators:

- [ ] **Deeply nested code** (> 3 levels)
- [ ] **Long functions** (> 50 lines)
- [ ] **Many parameters** (> 4)
- [ ] **Multiple return statements** scattered throughout
- [ ] **Complex boolean expressions** (> 3 conditions)
- [ ] **God classes** (> 500 lines)
- [ ] **Feature envy** (accessing other objects' data heavily)

---

## Refactoring Priority

Focus complexity reduction on:

1. **Frequently modified files** (high change rate)
2. **Bug-prone areas** (history of issues)
3. **Core business logic** (high importance)
4. **Onboarding blockers** (confusing to new devs)

---

## 🔄 Critic Loop

After reducing complexity:
> "Is the code actually clearer, or just different?"
> "Did I add indirection that makes it harder to follow?"
> "Can a new developer understand this?"
> "Did I break any tests?"

---

## 📝 Knowledge Logging

```markdown
### {date} - Complexity: {Title}
**Before**: Complexity score X
**After**: Complexity score Y
**Technique**: How it was reduced
**Trade-off**: Any downsides to the change
```
