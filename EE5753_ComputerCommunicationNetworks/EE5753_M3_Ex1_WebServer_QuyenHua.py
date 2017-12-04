##Quyen Hua
##EE5753
##M3 Web Server

#import socket module, create an instance
from socket import *
serverSocket = socket(AF_INET, SOCK_STREAM)

#prepare the server socket
serverPort = 6804 #set port to integer 6804. its arbitrary.
serverSocket.bind(('',serverPort)) 
serverSocket.listen(1) #specify max number of queued connections


while True:
    #establish the connection
    print 'Ready to serve on port '+str(serverPort)+'...'
    connectionSocket, addr = serverSocket.accept()
    print 'received request from:'
    print addr
    try:
        # http request line. follows format:
        # GET helloworld.html HTTP/1.x
##        message, clientAddress = serverSocket.recvfrom(2048)
        message = connectionSocket.recvfrom(2048)
##        print message
##        print clientAddress
        filename = message[0].split()[1]
        f = open(filename[1:])
        outputdata = f.read()# concat message + file
        #send one HTTP header line into socket
        
        for i in range(0, len(outputdata)):
            connectionSocket.send(outputdata[i])
        connectionSocket.close()
    except IOError:
        #send response message for file not found
        print '404 file not found' #fill
        response='404 FILE NOT FOUNT'
        connectionSocket.send(response)
        #close client socket
        connectionSocket.close() #fill
    
serverSocket.close()
