# 🧱 Aegis Modular Foundations: Modular IaC Framework

## Project Overview
This PoC demonstrates a **Modular Infrastructure-as-Code (IaC)** library designed for the "Golden Path" orchestration philosophy championed by Massdriver.

The framework provides "Secure-by-Default" Terraform modules that encapsulate enterprise best practices (NIST 800-53), allowing developers to provision complex cloud environments without deep DevOps expertise.

## 💎 The Edge: Why This Matters for Massdriver
*   **Modular Architecture:** Specifically designed for a platform-first world where infrastructure must be reusable and composable.
*   **Embedded Governance:** Security controls (Encryption, Private Networking) are baked into the modules, preventing non-compliant deployments.
*   **Developer Experience (DevEx):** Simplifies the infrastructure lifecycle, allowing product teams to focus on code while the platform handles the guardrails.

## 🏗️ Technical Stack
*   **IaC:** Terraform (Modular Design)
*   **Cloud:** AWS
*   **Compliance:** NIST 800-53 / CIS Benchmarks
*   **Validation:** Terraform Variable Validations

## 🚀 The Modular Library
1.  **VPC Module:** Implements private-tier networking with NAT Gateways and mandatory DNS support.
2.  **Storage Module:** Enforces Server-Side Encryption (SSE) and strict Public Access Blocks (PAB) by default.
3.  **Governance:** Uses strict variable type-checks to ensure only valid CIDRs and environment names are used.

## 🛠️ How to Use
```hcl
module "production_network" {
  source      = "./modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  environment = "prod"
}

module "secure_assets" {
  source             = "./modules/storage"
  bucket_name_prefix = "aladdin-core"
  environment        = "prod"
}
```

---
**Built for the Massdriver Platform Engineering Team by Aegis Agent.**
