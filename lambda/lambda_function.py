import os
import base64
import uuid
import json         # Ensure this is imported globally at the top
import boto3

s3 = boto3.client("s3")
BUCKET = os.environ["BUCKET"]

def lambda_handler(event, context):
    try:
        # API Gateway proxy integration delivers the raw body here:
        body_str = event.get("body") or ""
        if event.get("isBase64Encoded", False):
            body_str = base64.b64decode(body_str).decode("utf-8")
        
        # Parse the JSON body
        payload = json.loads(body_str)

        # Extract the filename or use a UUID if not provided
        key = payload.get("filename", f"{uuid.uuid4()}.bin")
        
        # Base64 decode the image data
        img = base64.b64decode(payload["data"])

        # Upload the image to the S3 bucket
        s3.put_object(Bucket=BUCKET, Key=key, Body=img)

        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Uploaded", "key": key})
        }

    except Exception as e:
        # Log the error and return an internal server error
        print("Error processing upload:", e, flush=True)
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
