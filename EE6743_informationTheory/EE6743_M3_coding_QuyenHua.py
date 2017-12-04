# -*- coding: cp1252 -*-
##Quyen Hua
##EE6743
##M3
##Huffman encoding of monty python and the holy grail

from collections import Counter
import math


##
##EE 6743 Programming Assignment 1
##
##The test file “EE6743_grail_testfile.txt” is the script from the movie “Monty Python and the Holy Grail.” It has been modified so that it contains only 30 different characters: 
##
##lowercase a-z (ascii 9710-12210), 
##“space (sp)” (ascii 3210), 
##“line feed (lf)” (ascii 1010)
##“carriage return (cr)” (ascii 1310),
##and “end of text (etx)” (ascii 0310).
##
##All uppercase, punctuation, and numerals have been removed. The file is in “.txt” format, and contains 61,392 characters. It has also been compressed using zip. First, unzip the file, and note the size of the zipped file vs. the unzipped .txt file.
##
##Write the following programs:
##
##1.	Write a program to calculate the 30 letter probabilities directly from the file.
##
##2.	Write a program to construct a binary Huffman code based on these probabilities.
##
##3.	Print out a neat, concise table of your Huffman code, showing the character, probability, Huffman code representation, and code length for each character.
##
##4.	Write a program to Huffman encode the data, so that the output file is a sequence of ones and zeros. Then group the output bits symbols into groups of 8 bits (i.e. bytes) so that the final output file is a sequence of 8-bit ascii characters.
##
##5.	Have your program calculate the final length, in bits, of the compressed output file. Also have your program calculate the entropy of the source, based on your derived probability values, (assuming that source symbols are independent, which is not really true).
##
##6.	Have your program calculate the ratio of output bits per input character. This is Lavg for this compression scheme.
##
##7.	Compare Lavg to the calculated entropy of the source. Explain the differences you see.
##
##8.	Write a program to decode your encoded data. Confirm that it perfectly reconstructs the original file.

workfile = 'EE6743_grail_testfile.txt'

#set up letter counter. let 27 be space, 28 be line feed, 29 be carriage return, and 30 be end of text
counts = []
d = []
## set up a percentage holder
percent = []
##for i in range(30):
##    counts.append(0)
##    d.append('')
    
with open(workfile, 'r') as f:
    read_data = f.read()

## get the total file length (for percentage measurements)
char_count = len(read_data)

## use module Counter to let the thing automatically count for us
c = Counter(read_data)
c_sort = sorted(c.items())

for k in range(len(c_sort)):
    d.append(c_sort[k][0])
    counts.append(c_sort[k][1])
    percent.append(float(c_sort[k][1])/float(char_count))


## 2 write a program that builds a huffman code based on these probabilities

##We need a object to behave like a tree. we will use a huffnode object, where
##      where l can be None or a huffNode
##            r can be None or a huffNode
##            val is the val, like ' ' or 'e'
##            b is binary value if a branch or leaf    
class huffNode(object):
    def __init__(self, l, r, b, val, freq):
        self.l=l
        self.r=r
        self.val=val
        self.b = b
        self.freq = freq
    def branch(self):
        return((self.l, self.r))
    def code(self):
        return(self.b)
    def value(self):
        return(self.val)

##we will try and split the tree by probability, where we
##attempt to split the tree in approximately 1/2

##sort my lists by probability
d_sort = []
p_sort = []
temp_percent = percent
for k in range(len(d)):
    temp_index = temp_percent.index(max(temp_percent))
    d_sort.append(d[temp_index])
    p_sort.append(percent[temp_index])
    temp_percent[temp_index] = -1
    


## need a way to split the tree by probability
def splitList(data):
    temp_prob = 0.0
    sum_list = 0.0
    for i in data:
        sum_list += i
    #print sum_list
##    print data
    counter = 0
    for i in data:
        if temp_prob < sum_list/float(2):
            temp_prob += i
            if(temp_prob < sum_list/float(2)):
                counter += 1
    subData = data[0:counter]
    return [subData, counter]

## start trying to construct huffman tree

## refer to wiki on huffman codes
##1. create a node for each symbol
##2. if more nodes,
##2a. remove next two nodes
##2b. create new branching node with probability
##2c. add new node to queue
##3. last node is root
##


huffTree = []
for i in range(len(percent)):
    huffTree.append(huffNode(None, None, None, d_sort[i], p_sort[i]))


def branch(hList):
    while len(hList) > 1:
        temp1 = hList.pop()
        temp2 = hList.pop()
        tempHuff = huffNode(temp1, temp2, None, None,temp1.freq+temp2.freq)
        hList.append(tempHuff)
    return hList[0]

## here we assume that our hufftree and p_sorted are in syc
## we need to sort the list, break it up based on probability, then pass a left and right nodes

## use our split list above, pass long list left (1) short list right (0)
##   on the right

## left list gets branch, right list gets split + branch
## dictionary is misnomer for hufflist
def grow(dictionary, frequencies):
    #if our list is just a single value, create and return a node
    if (len(frequencies) == 1):
        output = dictionary[0]
##        print 'reached a leaf with val: '+ dictionary[0].value()
    elif ( len(frequencies) == 2):
##        print 'reached two leafs with vals: '+ dictionary[0].value() + ' and: '+ dictionary[1].value()
        rightNode = dictionary[0]
        leftNode = dictionary[1]
        output = huffNode(leftNode, rightNode, None, None, leftNode.freq+rightNode.freq)

    elif ( len(frequencies) == 4): # do an even split?
        rrNode = dictionary[0]
        rlNode = dictionary[1]

        llNode = dictionary[2]
        lrNode = dictionary[3]

        rightNode = huffNode(rrNode, rlNode, None, None, rrNode.freq+rlNode.freq)
        leftNode = huffNode(llNode, lrNode, None, None, llNode.freq+lrNode.freq)

        output = huffNode(leftNode, rightNode, None, None, leftNode.freq+rightNode.freq)
        
    #else we try to grow
    else:

##        print str(len(dictionary)) + ' in dictionary'
##        print str(len(frequencies)) + ' in freq'
        [highFreq, index] = splitList(frequencies)
        if(index == 0):
##            print 'made it to the end of the list because probabilities are so low that my splitlist thing doesnt work anymore'
            output = branch(dictionary)
        else:
##            print 'going into right branch are: '+ str(len(frequencies[:index]))+' items'
##            print 'going into left right are: '+ str(len(frequencies[index:]))+' items'
            rightNode = grow(dictionary[:index], frequencies[:index])
            leftNode = grow(dictionary[index:], frequencies[index:])
            output = huffNode(leftNode, rightNode, None, None, None)
    return output


testTree = huffTree
test_freq = p_sort

test_out = grow(testTree,test_freq)
                    


##huffList = branch(huffTree)



##huffList is my huffman code

##now walk the tree so that i can assign code values under the 'b' field
##arbitrarily give right '0' and left '1'

def walk(node, code, huffmanCode):
    node.b = code
    if node.val != None:
        print str(node.freq)+', '+repr(node.value()) + ', '+str(len(code))+', '+ code
        huffmanCode[node.value()] = code
    if(node.l != None):
        huffmanCode = walk(node.l, str(code)+'1', huffmanCode)
    if(node.r != None):
        huffmanCode = walk(node.r, str(code)+'0', huffmanCode)
    return huffmanCode
print 'We have Huffman code:'
print '[Frequency, value, code length, huffman code]'

huffDict = {'000':  0}
huffCodeKey = walk(test_out, '',huffDict)
huffDict.pop('000') # get rd of initialized huffDict value
## now encode the test file...

encodedData = ''
for i in range(len(read_data)):
    encodedData = encodedData+huffDict[read_data[i]]
print '\n'
print 'The encoded data has size: '+ str(len(encodedData))+' bits'
print 'Which means the encoded data has size: '+str(len(encodedData)/8)+' bytes'
print 'Windows explorer says the original file has size: 60000 bytes'

lEncodedData = len(encodedData)
#take the 8 bits, turn to ascii, then print to file
compressData = ''

for i in range(len(encodedData)/8):
    compressData= compressData+chr(int(encodedData[:8],2))
    encodedData = encodedData[8:]

if (encodedData != ''):
    temp = 8 - len(encodedData)
    for i in range(temp):
        encodedData = '0'+encodedData
    compressData= compressData+chr(int(encodedData[:8],2))
    encodedData = ''

outfile = file('EE6743_encodedFile_QuyenHua.txt','w')
outfile.write(compressData)
outfile.close()

print 'after converting the encoded data to ascii, we have a file of size: '+str(len(compressData))
print 'which agrees with our previous estimate'
print '\n'

entropy = 0.0

for i in c_sort:
    temp = float(i[1])/float(char_count)*math.log(float(i[1])/float(char_count),2)
    entropy -= temp

print 'The entropy of the source was calculated as: ' +str(entropy)
    
lAvg = float(lEncodedData)/float(char_count)
print 'And the source has average bit length of: ' + str(lAvg) 

print ' Wow! thats a really small difference. I imagine that the difference can be explained through some minor inefficiencies in my huffman tree'
print ' I am sure that a more sensible/meticulous one could be made by hand...'

## now decode the file??? 
## read in the compressed file
f = open('EE6743_encodedFile_QuyenHua.txt', 'r')

newLineCount = 0 #debugging reveals that interesting newlines are preventing traditional readinf of my encoded file?
                # so just count to 5 newlines and call it end of file

######## can't figure out how to read in our file which is compressed. so instead, use our stored variable of compressed 
##numlines = 0
##uncompressData = ''
##while newLineCount < 5:
##    st = f.readline()
##    numlines +=1
##    print len(st)
##    if (st != ''):
##        temp = ''
##        for x in st:
##            xbin = format(ord(x), 'b')
##            if len(xbin) < 8:
##                for i in range(8 - len(xbin)):
##                   xbin = '0'+xbin
##            temp = temp+xbin
##        uncompressData = uncompressData + temp
##        newLineCount = 0
##    elif (st == ''):
##        newLineCount += 1


## we need to convert each character to its 8bit representation        
numlines = 0        
uncompressData = ''
for ch in compressData:
    st = ch
    numlines +=1
##    print len(st)
    if (st != ''):
        temp = ''
        for x in st:
            xbin = format(ord(x), 'b')
            if len(xbin) < 8:
                for i in range(8 - len(xbin)):
                   xbin = '0'+xbin
            temp = temp+xbin
        uncompressData = uncompressData + temp
        newLineCount = 0
    elif (st == ''):
        newLineCount += 1


#now, read the data back based on  dictionary. this might take a while.


print '\n'
print 'now decode the compressed data after you have read it in...'
interpret_data = ''
tempRead = ''
for x in uncompressData:
    tempRead = tempRead+x;
    for [dval, dcode] in huffCodeKey.iteritems():
       if str(tempRead) == dcode:
           interpret_data = interpret_data + dval
           tempRead = ''

print 'tada!'

outfile = file('EE6743_decodedFile_QuyenHua.txt','w')
outfile.write(interpret_data)
outfile.close()

        


