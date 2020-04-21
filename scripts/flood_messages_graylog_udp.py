import random
import string
from gelfclient import UdpClient
import argparse

parser = argparse.ArgumentParser(
    description='Just find out elasticsearch version')
parser.add_argument(
    'ElasticVersion',
    help="ElasticSearch version: e.g. '5.6' or '6.8'")
args = parser.parse_args()

gelf_server = 'localhost'
gelf = UdpClient(gelf_server, port=11001,source='log_generator')
ev=args.ElasticVersion
users_num=7
bets=10000
max_bet=10000
users=[]
for i in range(0,users_num):
  users.append(''.join(random.choices(string.ascii_lowercase,k=10)))

for user in users:
  for i in range(0,bets):
    random.seed()
    num=random.randint(0,max_bet)
    gelf.log('bet', _price=num, _user=user, _elasticversion=ev)
