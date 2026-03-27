# Repository Structure

This document describes the current and target directory layout of `fst-azcloud-fndtn-ptrn-testing`.

## Top-Level Layout

```text
faast-azurecloud-foundation-pattern/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── config.yml
│   │   └── deployment-request.yml
│   └── workflows/
│       ├── alz-cd-sharedservices.yml
│       ├── alz-ci-sharedservices.yml
│       └── bootstrap-sharedservices.yml
├── alz-platform/
│   ├── ase/
│   │   ├── networking/
│   │   │   ├── .gitignore
│   │   │   ├── backend.tfvars
│   │   │   ├── main.tf
│   │   │   ├── networking.tfvars
│   │   │   ├── outputs.tf
│   │   │   ├── providers.tf
│   │   │   └── variables.tf
│   │   ├── security/
│   │   │   ├── .gitignore
│   │   │   ├── backend.tfvars
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── providers.tf
│   │   │   ├── security.tfvars
│   │   │   └── variables.tf
│   └── inc/
│       ├── NC2/
│       │   ├── .gitignore
│       │   ├── backend.tfvars
│       │   ├── main.tf
│       │   ├── nc2.tfvars
│       │   ├── outputs.tf
│       │   ├── providers.tf
│       │   └── variables.tf
│       ├── networking/
│       │   ├── .gitignore
│       │   ├── backend.tfvars
│       │   ├── main.tf
│       │   ├── networking.tfvars
│       │   ├── outputs.tf
│       │   ├── providers.tf
│       │   └── variables.tf
│       ├── security/
│       │   ├── .gitignore
│       │   ├── backend.tfvars
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   ├── providers.tf
│       │   ├── security.tfvars
│       │   └── variables.tf
└── README.md
```

## Directory Purpose

- `.github/ISSUE_TEMPLATE/`: GitHub issue templates and template configuration.
- `.github/workflows/`: CI/CD workflows for shared services plan/apply/bootstrap pipelines.
- `alz-platform/ase/networking/`: Terraform root for ASE networking subscription deployment.
- `alz-platform/ase/management/`: Terraform root for ASE management subscription deployment.
- `alz-platform/ase/security/`: Terraform root for ASE security subscription deployment.
- `alz-platform/ase/sharedservices/`: Terraform root for ASE shared services deployment.
- `alz-platform/inc/networking/`: Terraform root for INC networking subscription deployment.
- `alz-platform/inc/management/`: Terraform root for INC management subscription deployment.
- `alz-platform/inc/security/`: Terraform root for INC security subscription deployment.
- `alz-platform/inc/sharedservices/`: Terraform root for INC shared services deployment.
- `alz-platform/inc/NC2/`: Terraform root for INC NC2-specific deployment.

## Terraform File Roles

- `main.tf`: Resource definitions and module composition.
- `variables.tf`: Input variable declarations.
- `outputs.tf`: Deployment outputs.
- `providers.tf`: Provider and backend/provider settings.
- `backend.tfvars`: Backend configuration values for remote state.
- `sharedservices.tfvars`, `networking.tfvars`, `management.tfvars`, `security.tfvars`, or `nc2.tfvars`: Environment/workload-specific variable values.
