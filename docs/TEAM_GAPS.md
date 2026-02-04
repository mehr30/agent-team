# Team Gaps Analysis

## Current Roles (8)
🏗️ Architect, 🔒 Security, 🎨 Frontend, ⚙️ Backend, 🧪 Testing, 🔧 DevOps, 👁️ Reviewer, 📝 Docs

---

## 🔍 CRITIC LOOP - PASS 1

**Gaps a senior engineer would identify:**

### 1. No Database Specialist
**Gap**: Backend handles DB, but complex projects need dedicated DB expertise
**Recommendation**: Add `/database` role for:
- Schema design & migrations
- Query optimization
- Data modeling
- Database security

### 2. No Performance/Monitoring Role
**Gap**: No one owns observability, profiling, load testing
**Recommendation**: Add `/performance` role for:
- Load testing
- Profiling & optimization
- APM setup (Datadog, New Relic)
- Performance budgets

### 3. No API Design Specialist
**Gap**: Backend builds APIs but no API design review
**Recommendation**: Add `/api-design` or merge into Architect for:
- OpenAPI/Swagger specs
- RESTful best practices
- Versioning strategy

### 4. No Accessibility Specialist
**Gap**: Frontend checks a11y but not deeply
**Recommendation**: Enhance Frontend or add `/accessibility` for:
- WCAG compliance
- Screen reader testing
- Keyboard navigation audit

### 5. No Error Handling/Resilience Role
**Gap**: Edge cases often missed
**Already addressed**: Critic loop catches these, but could be stronger

---

## 🔍 CRITIC LOOP - PASS 2

**Reviewing gaps:**

1. **Database** - High value for data-heavy apps. **RECOMMEND ADD**.
2. **Performance** - Important but can be DevOps subset initially. **DEFER**.
3. **API Design** - Can merge into Architect. **NO NEW ROLE**.
4. **Accessibility** - Can enhance Frontend checklist. **ENHANCE EXISTING**.
5. **Error Handling** - Critic loop covers this. **NO CHANGE**.

---

## Recommended Addition

Add **1 new role**: `/database` for complex data projects.

Otherwise, the current team is well-balanced for most projects.
