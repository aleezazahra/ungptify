

A comprehensive security checklist for writing, reviewing, and maintaining production-grade code. Covers OWASP Top 10, cloud-native security, container hardening, and supply chain protection.

---

## 1. General Security Principles

### Input Validation & Sanitization
- **Validate all untrusted input** – never trust data from users, APIs, or third-party services.
- All login, authentication, and validation checks **must take place on the backend**, never solely on the frontend.
- Never concatenate user input into raw queries. Use **ORM bind variables** or **prepared statements** religiously.
- **Parameterize all SQL queries** to prevent injection attacks.
- Validate untrusted serialized objects with schemas or allowlists to avoid Remote Code Execution (RCE).

### Authentication & Session Management
- **Hash passwords** with Argon2id, bcrypt, or PBKDF2 – **never MD5 or SHA1**.
- Implement **Multi-Factor Authentication (MFA)** using TOTP (RFC 6238) and WebAuthn / Passkeys.
- Set cookies with **Secure, HttpOnly, and SameSite=Lax/Strict** flags.
- **Regenerate session IDs** after login or privilege changes to prevent session fixation.
- Implement **OAuth 2.0 / OIDC** – prefer the **Authorization Code Flow + PKCE**.
- Validate the `state` parameter to prevent CSRF during OAuth flows.
- Enforce **authorization on the server** – never trust client-side role checks.
- Protect authentication and session endpoints with **rate limiting** (especially login and email endpoints).

### Secrets Management
- **Never store secrets in GitHub repositories.** Use `.env` files (and `.gitignore` them) for local dev.
- For production, use **AWS Secrets Manager**, **Azure Key Vault**, or **HashiCorp Vault**.
- Never hardcode API keys, tokens, or credentials in source code, logs, or error messages.

### Authorization & Access Control
- Implement **Row-Level Security (RLS)** for every database table – write policies so each user can only read and write their own rows.
- Apply the **Principle of Least Privilege (PoLP)** to all IAM roles and database users.
- Never use wildcard `*` permissions unless absolutely necessary; restrict by specific resources.

### Rate Limiting & DoS Protection
- Add **rate limiting** to all API routes, especially anything that costs money per request (e.g., email sends, image generation, LLM calls).
- Use **circuit breakers** and exponential backoff for retries to prevent cascading failures.
- Set **global payload size limits** (e.g., `express.json({ limit: '10mb' })`) to prevent memory bombing.

### File Upload Hardening
- Validate **magic bytes (MIME types)** and file extensions – never trust the `Content-Type` header alone.
- **Sanitize filenames** – remove path traversal sequences (`../`) and special characters.
- Scan uploads for malware using antivirus or security scanners.
- **Store uploaded files outside the webroot** so they cannot be executed directly.

### Output Encoding & XSS Prevention
- Apply **context-aware output encoding**:
  - HTML body → HTML entity encoding
  - HTML attribute → attribute encoding
  - JavaScript → JS string encoding
  - CSS → CSS string encoding
  - URL → URL percent-encoding
- Never disable security protections merely to make code work.

---

## 2. HTTP Security Headers & Transport Layer

- Set **Strict-Transport-Security (HSTS)** with `max-age=31536000` and `includeSubDomains` to enforce HTTPS.
- Apply **X-Content-Type-Options: nosniff** to prevent MIME-type sniffing attacks.
- Set **X-Frame-Options: DENY** (or `SAMEORIGIN`) to prevent clickjacking.
- Implement a strict **Content-Security-Policy (CSP)** header (e.g., `default-src 'self'`) to mitigate XSS.
- Use **Referrer-Policy: strict-origin-when-cross-origin** to avoid leaking sensitive URLs in referrer headers.
- Enforce **TLS 1.2 or higher** and disable outdated ciphers (e.g., RC4, 3DES).

---

## 3. API & GraphQL Specific Security

- For **GraphQL APIs**, enforce **query depth limits** (e.g., max depth of 10) and **query complexity scoring** to prevent DoS via expensive nested queries.
- Validate and sanitize **GraphQL variables** against the defined schema – never accept arbitrary extra fields.
- Use **persisted queries** or **allow-lists** for production GraphQL endpoints to block malicious ad-hoc queries.
- Implement **API versioning** (e.g., `/api/v1/`) so deprecating insecure endpoints doesn't break clients abruptly.
- Use **rate limiting** per API key or per user, not just globally.

---

## 4. Error Handling & Information Disclosure

- **Never expose raw stack traces**, database errors, or internal file paths to the client. Always return a generic `500 Internal Server Error` for unhandled exceptions.
- Distinguish between **user-friendly errors** (e.g., "Invalid email or password") and **system errors** (logged internally).
- Use **generic error messages** for login – never tell the attacker if a username exists (avoid user enumeration).
- Sanitize error responses in development/staging to ensure they don't accidentally leak into production logs.

---

## 5. Timeouts, Context Cancellation & Resource Management

- Set **strict timeouts** on all database queries, external API calls, and file operations to prevent hanging connections and resource exhaustion.
- Always use **context cancellation** (e.g., `context.WithTimeout` in Go, `asyncio.timeout` in Python) to release resources when a client disconnects.
- Set **connection pool limits** for databases and HTTP clients to avoid overload.
- Implement **graceful shutdown** handlers to allow in-flight requests to finish before the process exits.

---

## 6. Data at Rest & Backup Security

- Encrypt **sensitive database columns** (e.g., PII, financial data, medical records) at rest using AES-256 or TDE (Transparent Data Encryption).
- Ensure **database backups** and **snapshots** are encrypted with customer-managed keys (CMK) and stored in a separate, access-controlled location.
- Regularly **test restore procedures** for backups to avoid data loss scenarios.
- Implement **data retention policies** – purge old data that is no longer needed to reduce the attack surface.

---

## 7. Container & Kubernetes Security

- Run containers as a **non-root user** (`USER 1000:1000` in Dockerfile) to limit host system access.
- Set filesystems to **read-only** (`readOnlyRootFilesystem: true`) for production containers to prevent runtime binary modification.
- Define **resource requests and limits** (CPU/Memory) in Kubernetes to prevent DoS via resource starvation.
- Scan all container images for known CVEs using tools like **Trivy**, **Clair**, or **Grype** before pushing to registries and during CI/CD.
- **Never** store secrets in Docker layer cache. Use secrets mounting (`--secret`) or Kubernetes secrets (encrypted with KMS).
- Use **distroless base images** where possible to reduce the attack surface.

---

## 8. Infrastructure as Code (IaC) & Cloud Hardening

- Scan Terraform/CloudFormation templates with **Checkov**, **tfsec**, or **Prowler** to catch misconfigurations before deployment.
- Enforce **VPC private subnets** for all backend services – only load balancers should be publicly exposed.
- Use **AWS Security Groups** or **Azure NSGs** to restrict inbound/outbound traffic to the bare minimum.
- Enable **cloud audit logs** (e.g., AWS CloudTrail, Azure Monitor) and configure alerts for suspicious activity.
- Never use static long-term cloud credentials in CI/CD – use **OIDC (OpenID Connect)** or short-lived tokens.

---

## 9. Supply Chain & Dependency Hardening

- **Pin exact dependency versions** (`package-lock.json`, `poetry.lock`, `go.sum`) to prevent automatic pulling of malicious minor/patch updates.
- Run **dependency vulnerability scanners** (`npm audit`, `pip-audit`, `OSV-Scanner`, `Snyk`) in CI/CD and fail the build on critical CVEs.
- Verify the **integrity checksums** of downloaded packages (e.g., `npm` uses `integrity` hashes in lockfiles).
- Beware of **typosquatting** – verify the package name and publisher identity before adding new open-source libraries.
- Maintain a **Software Bill of Materials (SBOM)** for your application to quickly identify affected versions during a zero-day supply chain attack.

---

## 10. CORS (Cross-Origin Resource Sharing)

- Strictly define CORS policies. For authenticated endpoints, **never** use the wildcard origin (`*`). Explicitly list trusted domains.
- Use **`Vary: Origin`** header to ensure proxies handle CORS responses correctly.
- For internal microservices, consider disabling CORS entirely or restricting it to the internal service mesh.
- Use **preflight caching** with `Access-Control-Max-Age` to reduce latency but keep the cache time reasonable.

---

## 11. CI/CD Pipeline Secrets & Build Security

- Mask all secrets in CI/CD build logs to prevent accidental exposure via environment variable dumps.
- Use **OIDC (OpenID Connect)** or short-lived credentials for cloud access from CI/CD – never store static long-term keys in GitHub Actions/Azure DevOps.
- Ensure build artifacts (e.g., Docker images, JARs, binaries) are **signed** and **checksummed** to prevent tampering during transit.
- Run security scans as part of the pipeline:
  - SAST (Static Analysis) – `bandit` (Python), `eslint-plugin-security` (JS), `Semgrep` (multi-language)
  - DAST (Dynamic Analysis) – OWASP ZAP, Burp Suite against staging environments
- Perform **fuzzing** – send malformed data to APIs to catch crashes or memory leaks (e.g., `go-fuzz`, `AFL`).

---

## 12. Zero Trust & Network Segmentation

- Explicitly **deny all traffic by default** – use allowlists for internal service-to-service communication.
- Implement **mTLS (Mutual TLS)** between internal services to authenticate and encrypt inter-service traffic.
- Avoid hardcoding static API keys for service-to-service auth; use short-lived JWTs or workload identity.
- Use **service meshes** (e.g., Istio, Linkerd) for fine-grained network policies and observability.

---

## 13. Frontend / Client-Side Specific Hardening

- Never include **credit card processing logic** or payment checks entirely in the frontend – all paywall/transaction validations **must** be re-validated on the backend.
- Implement **Subresource Integrity (SRI)** on all externally loaded scripts (e.g., CDN-hosted libraries) to prevent CDN compromise.
- Disable **autocomplete** on sensitive fields (e.g., credit card CVV) and enforce proper `autocomplete="off"` / `new-password` for login forms.
- Use **Content Security Policy (CSP)** to restrict inline scripts and `eval()` usage in the browser.
- Never expose internal API structures or error details in frontend console logs.

---

## 14. Logging, Monitoring & Incident Response

- Log security events (logins, MFA changes, privilege escalations, password resets) – but **never log PII, credit cards, or raw passwords**.
- Ensure logs are **immutable**, timestamped in **UTC**, and forwarded to a **SIEM** (e.g., Splunk, ELK, Datadog).
- Implement **alerting** for:
  - Multiple failed login attempts (brute-force detection)
  - Unusual geographic access patterns
  - Privilege escalation attempts
  - High error rates or 5xx responses
- Create a **Security Playbook** outlining steps to take if a breach is suspected (revoke keys, rotate secrets, isolate instances).
- Schedule **periodic manual security reviews** for high-risk features (payment, auth, data export).

---

## 15. Language-Specific Security Rules

### Python
- Avoid `pickle` on untrusted input – use `json` or `yaml.safe_load()`.
- Use `subprocess` with **list arguments** – never set `shell=True`.
- Use `secrets` module for cryptographically strong random numbers – never use `random` for security.
- Enable `PYTHONHASHSEED` randomization.

## html
- never include innerHtml or such tags in the code as it is highly risky


### JavaScript / Node.js
- **Never use `eval()`** or `vm.createContext()` on user input.
- Mitigate **prototype pollution** – use `Object.freeze()` or `Map` for user‑supplied keys.
- Avoid using `child_process.exec()` with user input – use `execFile()` or `spawn()` with arguments.
- Use `helmet` package to set secure HTTP headers automatically.

### Java / .NET
- Configure XML parsers securely to prevent **XXE (XML External Entity)** attacks.
- Disable dangerous default deserialization filters.
- Use **strong cipher suites** and avoid older protocols like TLS 1.0/1.1.
- In .NET, use `Microsoft.AspNetCore.DataProtection` for cryptographic operations.

### Go
- Avoid raw string concatenation in templates – use `html/template` for auto-escaping.
- Handle errors carefully to prevent **nil pointer dereferences**.
- Use `crypto/rand` for secure random generation, never `math/rand`.
- Avoid `ioutil.ReadAll` on untrusted input – set `http.MaxBytesReader` limits.

---

## 16. Pre-Release & Code Review Checklist

Before completing a significant feature:

- [ ] Perform a brief security review and report important risks.
- [ ] Add tests for security-sensitive behavior.
- [ ] Check dependencies before adding them.
- [ ] Review the final diff for security issues.
- [ ] Triage false positives from automated security tools.
- [ ] Ensure all security headers are present (HSTS, CSP, XFO, etc.).
- [ ] Validate that no secrets are accidentally committed.

---

**Remember:** Security is a **continuous process**, not a one-time checklist. Stay updated with the latest CVEs, OWASP releases, and cloud security best practices.