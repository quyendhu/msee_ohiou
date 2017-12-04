##UDPPingerServer.py
##We will need the following module to generate randomized lost packets

import random
from socket import *

##create the UDP socket
##notice the use of SOCK_DGRAM for UDP packets
serverSocket = socket(AF_INET, SOCK_DGRAM)

#assign IP address and port number to socket
serverPort = 12000

serverSocket.bind(('',serverPort))

while True:
    #generate random number in range 0-10
    rand = random.randint(0,10)
    #receive the cline packet along with the address it is coming from
    message, address = serverSocket.recvfrom(1024)
    #capitalize the message from the client
    message = message.upper()

    #if rand is less than 4, we consider the packet lost and do not respond
    if rand < 4:
        continue
    #otherwise, the server responds
    serverSocket.sendto(message,address)
