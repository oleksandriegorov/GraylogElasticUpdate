import logging
import graypy
import string
import random

my_logger = logging.getLogger('test_logger')
my_logger.setLevel(logging.INFO)
handler = graypy.GELFTCPHandler('localhost', 11001)
my_logger.addHandler(handler)
users_num=20
bets=10000
max_bet=10000
users=[]
for i in range(0,users_num):
  users.append(''.join(random.choices(string.ascii_lowercase,k=10)))

for user in users:
  for i in range(0,bets):
    random.seed()
    num=random.randint(0,max_bet)
    #print("name={0} type=bet sum={1}".format(user,num))
    my_logger.info("name={0} type=bet sum={1}".format(user,num))
