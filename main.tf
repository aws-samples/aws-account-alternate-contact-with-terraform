module "delegated_admin_account" {
  source = "./modules/delegated_account"
  providers = {
    aws = aws.delegated_account
  }

  management_account_id        = var.management_account_id
  security_alternate_contact   = var.security_alternate_contact
  operations_alternate_contact = var.operations_alternate_contact
  billing_alternate_contact    = var.billing_alternate_contact
  invoke_lambda = var.invoke_lambda

  tags = var.tags
}

module "management_account" {
  source = "./modules/management_account"
  providers = {
    aws = aws.mgmt_account
  }

  delegated_account_event_bus = module.delegated_admin_account.delegated_account_bus

  tags = var.tags
}
