import json
import boto3

def lambda_handler(event, context):
    
    file_name = event["s3_key"]
    bucket_name = "ue124-bucket"
    
    s3 = boto3.client("s3")    
    response = s3.delete_object(
    Bucket=bucket_name,
    Key=file_name,
    )
    
    return {
        "statusCode": 200,
        "body": json.dumps("Datei gelöscht")
    }