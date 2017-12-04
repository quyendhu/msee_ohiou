##Quyen Hua
##EE5753
##M8 ICMP Pinger


from socket import *
import os
import sys
import struct
import time
import select
import binascii

ICMP_ECHO_REQUEST = 8

def checksum(str):
    csum = 0
    countTo = (len(str)/2)*2

    count = 0
    while count < countTo:
        thisVal = ord(str[count+1]) * 256 + ord(str[count])
        csum = csum + thisVal
        csum = csum & 0xffffffffL
        count = count + 2

    if countTo < len(str):
        csum = csum + ord(str[len(str)-1])
        csum = csum & 0xffffffffL

    csum = (csum >> 16) + (csum & 0xffff)
    csum = csum + (csum >> 16)
    answer = ~csum
    answer = answer & 0xffff
    answer = answer >> 8 | (answer << 8  & 0xff00)
    return answer

def receiveOnePing(mySocket, ID, timeout, destAddr):
    timeLeft = (timeout)
##    #print 'mySocket at receiveOnePing: ' + str(mySocket)
    while 1:
        
        startedSelect = time.time()
        whatReady = select.select([mySocket], [], [], timeLeft)
##        print "whatReady[0]: " + str(whatReady[0])
        howLongInSelect = (time.time() - startedSelect)
##        print "whatReady[0]: " + str(whatReady[0])
        if whatReady[0] == []: #timeout
##            print "whatReady[0] inside if: " + str(whatReady[0])
            return "Request timed out, no reply receieved"
##        print "whatReady[0]: " + str(whatReady[0])
        timeReceived = time.time()
        recPacket, addr = mySocket.recvfrom(1024)

############################################################
        #fill in start
        #Fetch ICMP header from the IP packet
##        print "size of received packet is: " + str(len(recPacket))
        sizeRecPack = len(recPacket)
        temp = recPacket[(sizeRecPack-16):(sizeRecPack-8)]
##        print str(temp)
##        print str(len(temp))
        H_TYPE, H_CODE, H_CHECKSUM, H_ID, H_SEQ = struct.unpack("bbHHh", temp)
##        print 'TYPE: ' +str(H_TYPE)
##        print 'CODE: ' +str(H_CODE)
##        print 'CHKSUM: ' +str(H_CHECKSUM)
##        print 'ID: ' +str(H_ID)
##        print 'SEQ: ' +str(H_SEQ)
        return (timeReceived-startedSelect)
        #fill in end
############################################################

        timeLeft = timeLeft - howLongInSelect

        if timeLeft <= 0:
            return "Request timed out, took too long"

def sendOnePing(mySocket, destAddr, ID):
    # Header is type (8), code (8), checksum (16), id (16), sequence (16)

    myChecksum = 0

    # make a dummy header with a 0 checksum
    # struct -- interpret strings as packed binary data

    header = struct.pack("bbHHh", ICMP_ECHO_REQUEST, 0, myChecksum, ID, 1)
    data = struct.pack("d", time.time())

    #calc the checksum on the data and the dummy header
    myChecksum = checksum(header+data)
    
    #get the right checksum, put in header
    if sys.platform == 'darwin':
        myChecksum = socket.htons(myChecksum) & 0xffff
        #conver to 16-bit integers from host to network byte order
    else:
        #myChecksum = socket.htons(myChecksum)
        myChecksum = htons(myChecksum)
##    print 'Computed outgoing checksum: ' + str(myChecksum)
    header = struct.pack("bbHHh", ICMP_ECHO_REQUEST, 0, myChecksum, ID, 1)
    packet = header + data
##    print "sent packet size is: " + str(len(packet))
##    print "packet header size is: " + str(len(header))
##    print "packet data size is: " + str(len(data))
    mySocket.sendto(packet, (destAddr, 1)) # AF_INET address must be tuple, not str
##    Both LISTS and TUPLES consist of a number objects
##which can be referenced by their position number within the object

def doOnePing(destAddr,timeout):
    #icmp = socket.getprotobyname("icmp")
    icmp = getprotobyname("icmp")
##    #print "timeout: " + str(timeout)
##    print "icmp var: " + str(icmp)
  #SOCK_RAW is a powerful socket type. For more details see: http://sock-raw.org/papers/sock_raw

############################################################
    #Fill in start  
    #Create Socket here
    mySocket = socket(AF_INET, SOCK_RAW, icmp)
##    print 'mySocket at doOnePing: ' + str(mySocket)
    #Fill in end
############################################################

    myID = os.getpid() & 0xFFFF # return the current process id
##    print 'Outgoing Packet ID: ' +str (myID)
    sendOnePing(mySocket, destAddr, myID)
    delay = receiveOnePing(mySocket, myID, timeout, destAddr)

    mySocket.close()
    return delay

def ping(host, timeout = 1.0):
  #timeout=1 means: If one second goes by without a reply from the server
  #the client assumes that either the client’s ping or the server’s pong is lost
    dest = gethostbyname(host)
##    #dest = socket.gethostbyaddr(host)
    print ""
    print "Pinging " + dest + " ["+ host+"] 5 times using Python:"
    print ""
##    #print "timeout = " + str(timeout)
    #send ping requests to a server seperated by approx 1 sec
    count = 1
    while count <=5:
        delay = doOnePing(dest,timeout)
        print 'delay is: ' + str(delay) + ' seconds'
        time.sleep(1) # wait 1 sec
        count = count + 1
    return delay

print "EE5753_M8_Python-ICMP-Pinger_QuyenHua"
print "This file must be run with administrator privileges"
ping('localhost')
ping('sydney.edu.au')
ping('www.google.com')
ping('www.inria.fr')
ping('www.kyoto-u.ac.jp')

    
