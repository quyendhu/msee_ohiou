##Quyen Hua
##EE5753
##txtbk example
##UDP client


from socket import *
serverName = 'hostname'
serverPort = 12001
clientSocket = socket(socket.AF_INET, socket.SOCK_DGRAM)
message = raw_input('INPUT LOWERCASE SENTENCE: ')
clientSocket.sendto(message,(serverName, serverPort))
modifiedMessage, serverAddress = clientSocket.recvfrom(2048)
print modifiedMessage
clientSocket.close()
