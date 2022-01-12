provider "aws" {
  region  = var.region
  alias   = "delegated_account"
  profile = "delegated-account"
  #   assume_role {
  #     role_arn = "arn:aws:iam::<INSERT-DELEGATED-ACCOUNT-ID>:role/${var.assume_role_name}"
  #   }
}

provider "aws" {
  region  = var.region
  alias   = "mgmt_account"
  profile = "default"
  #   assume_role {
  #     role_arn = "arn:aws:iam::<INSERT-MANAGEMENT-ACCOUNT-ID>:role/${var.assume_role_name}"
  #   }
}

