import random
import string
from gelfclient import UdpClient
import argparse

parser = argparse.ArgumentParser(
    description='transactions generator')
parser.add_argument(
    'TransactionsNumber',
    type=int,
    help="Number of email transactions to generate")
parser.add_argument(
    'ElasticVersion',
    help="ElasticSearch version: e.g. '5.6' or '6.8'")
args = parser.parse_args()

gelf_server = 'localhost'
gelf = UdpClient(gelf_server, port=11001,source='log_generator')
ev=args.ElasticVersion
transactionsnum=args.TransactionsNumber
domains=[]
domainnum=100
# Pregenerate domains
for i in range(0,domainnum):
  domain=''.join(random.choices(string.ascii_lowercase,k=10))+'.'+''.join(random.choices(string.ascii_lowercase,k=3))
  domains.append(domain)
# Log transactions
for i in range(0,transactionsnum):
  sender=''.join(random.choices(string.ascii_lowercase,k=10))+'@'+random.choice(domains)
  rcpt=''.join(random.choices(string.ascii_lowercase,k=10))+'@'+random.choice(domains)
  qid=''.join(random.choices(string.digits+string.ascii_uppercase,k=14))
  gelf.log('mta transaction', _qid=qid,_from=sender, _to=rcpt, _fromdomain=sender.split('@')[1],_todomain=rcpt.split('@')[1],_elasticversion=ev)
