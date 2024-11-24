import os
import json
import boto3

SENDER_EMAIL = os.environ["SENDER_EMAIL"]
RECEIVER_EMAIL = os.environ["RECEIVER_EMAIL"]
SUBJECT = "S3 Event Notification"


def lambda_handler(event, context):
    """
    Lambda Function for Sending Data event

    Args:
        event ([type]): Json event
        context ([type]): [description]
    """
    print('HELL YA')

    

