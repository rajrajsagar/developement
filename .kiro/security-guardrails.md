# Infrastructure Security Guardrails
- **IaC Engine:** Maintain explicit, clean Terraform syntax.
- **Remediation Strategy:** When resolving Checkov failures, always append missing security attributes directly to the offending resource code blocks.
- **Strict Disallowances:** Never introduce wide-open network paths (e.g., `0.0.0.0/0`) or unencrypted data volumes to resolve a compilation issue.

