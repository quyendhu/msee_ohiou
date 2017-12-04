##Quyen Hua
##EE5753
##txtbk example
##UDP server

from socket import *
serverPort = 12005
serverSocket = socket(AF_INET, SOCK_DGRAM)
serverSocket.bind(('',serverPort))
print 'the server is ready to receive on port: '+str(serverPort)

while True:
    message, clientAddress = serverSocket.recvfrom(2048)
    print 'client requests capitalization of: '+message
    
    modifiedMessage = 'server respnse: '+message.upper()
    
    serverSocket.sendto(modifiedMessage, clientAddress)
