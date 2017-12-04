##Quyen Hua
##EE6743
##M10-M11
##Programming Assignment
##LZW of test file


from collections import Counter
import math

print 'EE6743, Programming Assignment 4, LZW of test file'

workfile = 'EE6743_grail_testfile.txt'

with open(workfile, 'r') as f:
    read_data = f.read()

init = Counter(read_data) #cheaply grab all characters in the file
 
init_s = sorted(init) #get ready to initialize some encoder

encoder = {}
compressed_data = []

#initialize the encoder with the full alphabet and other characters
for i in range(len(init_s)):
    encoder[init_s[i]] = i


# define a function which will recursively add characters and serach the dictioary
def checkDict(word, data, dictionary, compressed, word_size):
    if len(data) > 0:
        new_Word = word + data[0]
        if new_Word in dictionary:
            return checkDict(new_Word, data[1:], dictionary, compressed, word_size+1)
        else:
## debug, for reading the value of the dictionary word added to compresesd file
##            compressed.append(word)#dictionary[word])
            compressed.append(dictionary[word])
            dictionary[new_Word] = len(dictionary)
            return [compressed, dictionary, word_size]
    else:
        return [compressed, dictionary, 0]

    
index = 0
limit = len(read_data)
print '...traversing data, building encoder...'
## traverse data and build our dictionary. also, put stuff into our compressed data file
while index < limit-1:
    [compressed_data, encoder, word_size] = checkDict(read_data[index], read_data[(index+1):], encoder, compressed_data, 1)
    index = index + word_size

## debug, for reading the value of the dictionary word added to compresesd file
##compressed_data.append(read_data[index])
print '...data traversed, encoder complete...'
compressed_data.append(encoder[read_data[index]])


#Lavg = output file length/input file length * 8
lavg = float(len(compressed_data))/float(limit)*8
print 'calculated Lavg = ' +str(lavg)

#compression ratio= output bits/ input bits
# output bits = length of compressed data * 2 bytes = (x) * 16 bits
# input bits = length of input data * 8 bits (8 bit ascii) = (y) * 8 bits
compRatio = float(len(compressed_data))/float(limit)
##compRatio = float(len(compressed_data)*16)/float(limit*8)
print 'Compressed Data has length: ' + str(len(compressed_data))
print '     *Note: length is in units of 2-byte unsigned integers'
print 'Input data has length: ' + str(limit)
print 'calculated Compression Ratio = ' + str(compRatio)

print '...generating pseudo compressed file... '
outfile = file('EE6743_LZWencodedFile_QuyenHua.txt','w')
for i in compressed_data:
    outfile.write(str(i)+' ') ##put in a space between words because it helps to read the now pseudo compressed data
outfile.close()

print '..finding longest string in encoded table...'
s_long = 0
for i in encoder:
    if len(i) >= s_long:
        s_long = len(i)
        print 'encoder key: '+ i + ' has length ' + str(encoder[i])

print 'Longest string in encoded table has ' + str(s_long) + ' characters'

print '...generating \'compressed\' file... '
outfile2 = file('EE6743_LZWFile_QuyenHua','w')
binData = '' #so i dont have to read it in again
for i in compressed_data:
    temp = bin(i)[2:] #remove the prefix '0b'
    zeropad = ''
    zeros = 16-len(temp)
    for j in range(zeros):
        zeropad=zeropad+'0'
    zeropad = zeropad + temp
    outfile2.write(zeropad) ##put in a space between words because it helps to read the now pseudo compressed data
    binData= binData + zeropad
outfile2.close()
print '... generated binary output file... boy is it large! I\'m not really sure if this is the right way to write a binary file...'



##now we decode the file
print ' '
print '... now we decode...'

decode_data = ''
decode_list = []
binDataLimit = len(binData)

index = 0
step = 16 #two byte word
while index < binDataLimit:
    temp = int(binData[index:index+step], 2)
    decode_list.append(temp)
    index = index + step
    temp2 =''
    for s in encoder:
        if encoder[s] == temp:
            decode_data = decode_data+s


print 'the decoding probably took a while because my encoder storage mechanism is dumb.'
print '...writing decoded data to file...'
outfile = file('EE6743_LZWdecoded_QuyenHua.txt','w')
outfile.write(decode_data)
outfile.close()
    
        
    



