import os
import sys
from pip._internal import main

# install latest version of boto3
main(
    [
        "install",
        "-I",
        "-q",
        "boto3",
        "--target",
        "/tmp/",
        "--no-cache-dir",
        "--disable-pip-version-check",
    ]
)
sys.path.insert(0, "/tmp/")
import boto3

from botocore.exceptions import ClientError

altcontacttype = os.environ.get("ALT_CONTACT_TYPE")
emailaddress = os.environ.get("EMAIL_ADDRESS")
contactname = os.environ.get("CONTACT_NAME")
phonenumber = os.environ.get("PHONE_NUMBER")
title = os.environ.get("CONTACT_TITLE")

orgClient = boto3.client("organizations")
client = boto3.client("account")

listedAccounts = orgClient.list_accounts()
failedAccounts = []


def put_alternate_contact(accountId):
    try:
        response = client.put_alternate_contact(
            AccountId=accountId,
            AlternateContactType=altcontacttype,
            EmailAddress=emailaddress,
            Name=contactname,
            PhoneNumber=phonenumber,
            Title=title,
        )
        print(accountId)

    except ClientError as error:
        failedAccounts.append(accountId)
        print(error)
        pass


def lambda_handler(event, context):
    for account in listedAccounts["Accounts"]:
        if account["Status"] != "SUSPENDED":
            put_alternate_contact(account["Id"])
    return ("Completed! Failed Accounts: ", failedAccounts)
