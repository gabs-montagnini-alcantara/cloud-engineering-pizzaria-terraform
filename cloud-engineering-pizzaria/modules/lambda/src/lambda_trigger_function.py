import os
import json
import boto3
from datetime import datetime

# Inicializando o cliente do SQS
sqs = boto3.client('sqs')

# Pegando as variáveis de ambiente definidas no Terraform
URL_SQS_PREPARACAO = os.environ['URL_SQS_PREPARACAO']
URL_SQS_PRONTO = os.environ['URL_SQS_PRONTO']
BUCKET_NAME = os.environ['BUCKET_NAME']

def lambda_handler(event, context):
    # Processa cada evento recebido
    for record in event['Records']:
        
        # Extraindo o nome do arquivo do evento S3
        file_key = record['s3']['object']['key']
        
        # Separando a pasta e o nome do arquivo
        folder, file_name = file_key.split('/')
        
        # Separando as partes do nome do arquivo: número do pedido e nome do cliente
        try:
            order_number, client_name = file_name.split('-')
        except ValueError:
            print(f"Erro ao separar o nome do arquivo {file_name}. Formato esperado: <pedido>-<cliente>")
            continue  # Se o formato não for correto, ignore este evento
        
        # Criando o timestamp atual
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        
        # Definindo o status baseado na pasta
        if folder == 'pronto':
            status = 'pronto'
            queue_url = URL_SQS_PRONTO
        elif folder == 'em-preparacao':
            status = 'em-preparacao'
            queue_url = URL_SQS_PREPARACAO
        else:
            print(f"Status desconhecido para a pasta: {folder}. Ignorando o evento.")
            continue  # Se a pasta não for válida, ignore este evento
        
        # Preparando a mensagem a ser enviada para a fila SQS
        message = {
            'order_number': order_number,
            'client_name': client_name,
            'status': status,
            'timestamp': timestamp
        }

        # Enviar a mensagem para a fila SQS apropriada
        try:
            response = sqs.send_message(
                QueueUrl=queue_url,
                MessageBody=json.dumps(message)
            )
            print(f"Mensagem enviada para {queue_url}: {response}")
        except Exception as e:
            print(f"Erro ao enviar mensagem para {queue_url}: {e}")
        
    return {
        'statusCode': 200,
        'body': json.dumps('Evento processado com sucesso.')
    }
