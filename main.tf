module "delegated_admin_account" {
  source = "git::ssh://git@example.org/example/aws-account-alternate-contact-with-terraform.git//modules/delegated_account"
  providers = {
    aws = aws.delegated_account
  }

  management_account_id  = var.management_account_id
  alternate_contact_type = var.alternate_contact_type
  invoke_lambda          = var.invoke_lambda

  tags = var.tags
}

module "management_account" {
  source = "git::ssh://git@example.org/example/aws-account-alternate-contact-with-terraform.git//modules/management_account"
  providers = {
    aws = aws.mgmt_account
  }

  delegated_account_event_bus = module.delegated_admin_account.delegated_account_bus

  tags = var.tags
}