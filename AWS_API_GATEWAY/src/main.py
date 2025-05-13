import json
import logging
import os

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
def lambda_handler(event, context):
    try:
        logger.info(f"Event: {event}")
        message = os.environ.get('MESSAGE', 'Default Message')
        response = {
            'statusCode': 200,
            'body': json.dumps({
                'message': message,
                'event': event,
            }),
            'headers': {
                'Content-Type': 'application/json',
            },
        }
        return response
    except Exception as e:
        logger.error(f"Error: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)}),
            'headers': {
                'Content-Type': 'application/json',
            }
        }