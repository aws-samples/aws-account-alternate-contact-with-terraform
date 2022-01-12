provider "aws" {
  region  = var.region
  alias   = "delegated_account"
    assume_role {
    role_arn = "arn:aws:iam::<INSERT-DELEGATED-ACCOUNT-ID>:role/<INSERT-ASSUME-ROLE-NAME>"
    }
}

provider "aws" {
  region  = var.region
  alias   = "mgmt_account"
    assume_role {
      role_arn = "arn:aws:iam::<INSERT-MANAGEMENT-ACCOUNT-ID>:role/<INSERT-ASSUME-ROLE-NAME>"
    }
}

