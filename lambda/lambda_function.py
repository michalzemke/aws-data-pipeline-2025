import json
import boto3
import os
import logging


logger = logging.getLogger()
logger.setLevel(logging.INFO)


s3 = boto3.client("s3")


RAW_BUCKET = os.environ["RAW_BUCKET"]
PROCESSED_BUCKET = os.environ["PROCESSED_BUCKET"]


def lambda_handler(event, context):

    logger.info("Lambda execution started")

    try:

        # Get input file information from event
        source_bucket = event["Records"][0]["s3"]["bucket"]["name"]
        source_key = event["Records"][0]["s3"]["object"]["key"]

        logger.info(
            f"Reading file {source_key} from bucket {source_bucket}"
        )


        # Read JSON file from Raw bucket
        response = s3.get_object(
            Bucket=source_bucket,
            Key=source_key
        )


        file_content = response["Body"].read().decode("utf-8")

        data = json.loads(file_content)


        logger.info("JSON file successfully loaded")


        # Extract required fields
        processed_data = {
            "patient_id": data["patient_id"],
            "patient_name": data["patient_name"]
        }


        logger.info(
            f"Processed data: {processed_data}"
        )


        # Create output filename
        output_key = f"processed/{source_key}"


        # Write processed JSON
        s3.put_object(
            Bucket=PROCESSED_BUCKET,
            Key=output_key,
            Body=json.dumps(processed_data),
            ContentType="application/json"
        )


        logger.info(
            f"File written to {PROCESSED_BUCKET}/{output_key}"
        )


        return {
            "statusCode": 200,
            "body": json.dumps(
                {
                    "message": "Processing completed",
                    "output": output_key
                }
            )
        }


    except Exception as error:

        logger.error(
            f"Lambda failed: {str(error)}"
        )

        raise error
