import json
import boto3
from datetime import datetime

# Criando o cliente do DynamoDB
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('pedidos-pizzaria') 

def lambda_handler(event, context):
    # Itera sobre todos os registros enviados para a Lambda (no caso, apenas um)
    for record in event['Records']:
        # Extrai o corpo da mensagem SQS
        message_body = json.loads(record['body'])

        # Extrai os dados que você precisa da mensagem
        order_number = message_body['order_number']
        client_name = message_body['client_name'].split('.')[0]  # Remove a extensão do nome
        status = message_body['status']
        timestamp = message_body['timestamp']

        # Converte o timestamp para o formato ISO 8601 (exemplo: "2024-09-23T15:35:41Z")
        datetime_obj = datetime.strptime(timestamp, "%Y-%m-%d %H:%M:%S")
        formatted_datetime = datetime_obj.strftime("%Y-%m-%dT%H:%M:%SZ")

        # Estrutura que será inserida no DynamoDB
        item = {
            'pedido': order_number,
            'datetime': formatted_datetime,
            'cliente': client_name,
            'status': status
        }

        # Inserindo no DynamoDB
        try:
            table.put_item(Item=item)
            print(f"Item inserido com sucesso: {item}")
        except Exception as e:
            print(f"Erro ao inserir no DynamoDB: {e}")
            raise e

    return {
        'statusCode': 200,
        'body': json.dumps('Processamento concluído com sucesso.')
    }


