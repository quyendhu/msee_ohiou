##Quyen Hua
##EE5753
##M3 UDP Pinger Client

#module for timestamping
from datetime import datetime

#module for waiting up to a sec
##import time

from socket import *



serverName = '192.168.1.109'
serverPort = 12000
clientSocket = socket(AF_INET, SOCK_DGRAM)

clientSocket.settimeout(1)

#send the ping message 10 times.
# print server response, if any. otherwise, print timeout
# calculate and print round trip time in seconds of each packet
#

print 'Contacting host: '+serverName
print 'through port: '+str(serverPort)
message = raw_input('with (input lowercase string): ')

##begin ping
for i in range(10):
    try:
        #get start time
        time_s = str(datetime.now().time())
        time_start = time_s.split(':')
        clientSocket.sendto(message,(serverName, serverPort))
##        print 'message sent'
        modifiedMessage, serverAddress = clientSocket.recvfrom(2048)
        
        #get response time
        time_responded = str(datetime.now().time()).split(':')
##        print 'message received'
        RTT = str(float(time_start[2])-float(time_responded[2]))
##        print 'RTT calc'
        print 'Ping ['+str(i)+'], Sent: '+time_s+', RTT: '+RTT+', Response: '+ modifiedMessage
    except:
        print 'Request Timed Out['+str(i)+']'



clientSocket.close()
