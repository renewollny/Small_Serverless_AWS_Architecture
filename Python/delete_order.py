import json
import boto3
import os

BUCKET_NAME = os.getenv("BUCKET_NAME")

def lambda_handler(event, context):
    
    file_name = event["s3_key"]
    bucket_name = "${BUCKET_NAME}"
    
    s3 = boto3.client("s3")    
    response = s3.delete_object(
    Bucket=bucket_name,
    Key=file_name,
    )
    
    return {
        "statusCode": 200,
        "body": json.dumps("Datei gelöscht")
    }