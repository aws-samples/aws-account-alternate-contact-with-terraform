import os
import re

import boto3
from botocore.exceptions import ClientError

ORG_CLIENT = boto3.client("organizations")
ACCOUNT_CLIENT = boto3.client("account")

SEC_ALTERNATE_CONTACTS = os.environ.get("security_alternate_contact")
BILL_ALTERNATE_CONTACTS = os.environ.get("operations_alternate_contact")
OPS_ALTERNATE_CONTACTS = os.environ.get("billing_alternate_contact")
MANAGEMENT_ACCOUNT_ID = os.environ.get("management_account_id")

LISTED_ACCOUNTS = ORG_CLIENT.list_accounts()
FAILED_ACCOUNTS = []
CONTACTS = []


def parse_contact_types():
    CONTACT_LIST = []
    for contact in [SEC_ALTERNATE_CONTACTS, BILL_ALTERNATE_CONTACTS, OPS_ALTERNATE_CONTACTS]:
        CONTACT_LIST = re.split("=|; ", contact)
        list_to_dict = {CONTACT_LIST[i]: CONTACT_LIST[i + 1] for i in range(0, len(CONTACT_LIST), 2)}
        CONTACTS.append(list_to_dict)


def put_alternate_contact(accountId):
    for contact in CONTACTS:
        try:
            response = ACCOUNT_CLIENT.put_alternate_contact(
                AccountId=accountId,
                AlternateContactType=contact["CONTACT_TYPE"],
                EmailAddress=contact["EMAIL_ADDRESS"],
                Name=contact["CONTACT_NAME"],
                PhoneNumber=contact["PHONE_NUMBER"],
                Title=contact["CONTACT_TITLE"],
            )

        except ClientError as error:
            FAILED_ACCOUNTS.append(accountId)
            print(error)
            pass


def lambda_handler(event, context):
    parse_contact_types()
    for account in LISTED_ACCOUNTS["Accounts"]:
        if account["Status"] != "SUSPENDED" and account["Id"] != MANAGEMENT_ACCOUNT_ID:
            put_alternate_contact(account["Id"])

    return ("Completed! Failed Accounts: ", FAILED_ACCOUNTS)
