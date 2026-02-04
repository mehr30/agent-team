---
description: Monitoring and observability - logging, metrics, alerts, health checks
---

# 📊 Monitor Mode

Setup comprehensive monitoring and observability.

## The Three Pillars

| Pillar | What | Tools |
|--------|------|-------|
| **Logs** | What happened | Winston, Pino, CloudWatch |
| **Metrics** | How much/how fast | Prometheus, Datadog, CloudWatch |
| **Traces** | Request flow | Jaeger, Zipkin, X-Ray |

---

## Logging Setup

### Structured Logging (Pino)

```typescript
import pino from 'pino';

const logger = pino({
  level: process.env.LOG_LEVEL || 'info',
  formatters: {
    level: (label) => ({ level: label }),
  },
  redact: ['password', 'token', 'authorization'],
});

// Usage
logger.info({ userId, action: 'login' }, 'User logged in');
logger.error({ err, requestId }, 'Request failed');
```

### Log Levels

| Level | Use For |
|-------|---------|
| `error` | Errors that need attention |
| `warn` | Potential issues |
| `info` | Important business events |
| `debug` | Development troubleshooting |
| `trace` | Very detailed debugging |

### What to Log

- ✅ Request start/end with duration
- ✅ Authentication events
- ✅ Business operations (orders, payments)
- ✅ Errors with stack traces
- ✅ External API calls
- ❌ Sensitive data (passwords, tokens)
- ❌ High-volume debug logs in production

---

## Health Checks

### Basic Health Endpoint

```typescript
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});
```

### Comprehensive Health Check

```typescript
app.get('/health', async (req, res) => {
  const checks = {
    database: await checkDatabase(),
    redis: await checkRedis(),
    externalApi: await checkExternalApi(),
  };

  const allHealthy = Object.values(checks).every(c => c.status === 'ok');
  
  res.status(allHealthy ? 200 : 503).json({
    status: allHealthy ? 'ok' : 'degraded',
    timestamp: new Date().toISOString(),
    checks,
  });
});

async function checkDatabase() {
  try {
    await db.$queryRaw`SELECT 1`;
    return { status: 'ok' };
  } catch (err) {
    return { status: 'error', message: err.message };
  }
}
```

---

## Metrics

### Key Metrics to Track

| Metric | Type | Description |
|--------|------|-------------|
| `http_requests_total` | Counter | Total requests |
| `http_request_duration_ms` | Histogram | Response time |
| `http_requests_in_flight` | Gauge | Current requests |
| `db_query_duration_ms` | Histogram | Query time |
| `cache_hits_total` | Counter | Cache effectiveness |

### Express Metrics Middleware

```typescript
import { collectDefaultMetrics, Counter, Histogram } from 'prom-client';

collectDefaultMetrics();

const httpRequestsTotal = new Counter({
  name: 'http_requests_total',
  help: 'Total HTTP requests',
  labelNames: ['method', 'path', 'status'],
});

const httpRequestDuration = new Histogram({
  name: 'http_request_duration_ms',
  help: 'HTTP request duration in ms',
  labelNames: ['method', 'path'],
  buckets: [10, 50, 100, 200, 500, 1000, 2000],
});

app.use((req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    const duration = Date.now() - start;
    httpRequestsTotal.inc({ method: req.method, path: req.route?.path, status: res.statusCode });
    httpRequestDuration.observe({ method: req.method, path: req.route?.path }, duration);
  });
  next();
});

app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.send(await register.metrics());
});
```

---

## Error Tracking (Sentry)

```typescript
import * as Sentry from '@sentry/node';

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV,
  tracesSampleRate: 0.1,
});

// Express error handler
app.use(Sentry.Handlers.errorHandler());

// Manual capture
try {
  riskyOperation();
} catch (err) {
  Sentry.captureException(err, {
    extra: { userId, operation: 'risky' },
  });
}
```

---

## Alerting Rules

### Critical Alerts (Page immediately)

- Error rate > 5% for 5 minutes
- Response time p99 > 5s for 5 minutes
- Health check failing for 1 minute
- Database connection failures

### Warning Alerts (Notify team)

- Error rate > 1% for 10 minutes
- Response time p95 > 1s for 10 minutes
- Disk usage > 80%
- Memory usage > 85%

---

## Dashboard Setup

Key metrics to display:

1. **Request Rate** - Requests per second
2. **Error Rate** - % of 5xx responses
3. **Response Time** - p50, p95, p99
4. **Saturation** - CPU, Memory, Connections
5. **Business Metrics** - Signups, Orders, etc.

---

## 🔄 Critic Loop

After setting up monitoring:
> "Are we logging enough to debug issues?"
> "Are we logging too much (cost, noise)?"
> "Are alerts actionable?"
> "Are sensitive data properly redacted?"

---

## 📝 Knowledge Logging

```markdown
### {date} - Monitoring: {Title}
**Setup**: What was configured
**Alerts**: Key thresholds set
**Dashboard**: What's being tracked
```
