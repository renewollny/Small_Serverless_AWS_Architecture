import json
import boto3
import uuid

def lambda_handler(event, context):
    
    message = json.loads(json.loads(event["Records"][0]["body"])["Message"])["Records"][0]["s3"]["object"]["key"]
    file_name = str(uuid.uuid4())
    
    db = boto3.client("dynamodb")    
    response = db.put_item(
        TableName = "orders",
        Item = {
            "Order_Id": {
                "S": file_name
            },
            "Order": {
                "S": message
            }
        }
    )
    
    return {
        "statusCode": 200
    }