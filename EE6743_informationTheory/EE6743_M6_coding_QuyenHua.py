# -*- coding: cp1252 -*-
##Quyen Hua
##EE6743
##M6
##entropy calculations based on first and second markov approximations

from collections import Counter
import math
import numpy as np


##
##EE 6743 Programming Assignment 2
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
##

print 'EE6743, Entropy of Monty Python and the Holy Grail script based on first and second order Markov assumptions'

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
##note that percent is total character probability in the whole of the text.
    ##not sure how that is going to play out?


## 30x30 matrix to develop transition matrix
## we will utilize matrix such that 30xN will be the prior character
    ## and the Nx30 will be the 'count' of seeing that character appear
    ## after the 30xN char. we base our index off sorted list d
    ## for example, mar1[3,2] is the probability of seeing a ' ' after an 'a'
mar1 = np.zeros((30,30)) #first order markov probabilities

## 30x30x30 matrix to develop 2nd degree markov transition matrix
## we will utilize matrix such that in KxNxM , K will be 1st char, N wiill be 2nd
## character, and M is the probability of seeing indexed character after seeing KN
mar2 = np.zeros((30,30,30)) #second order markov probabilities

##troll through the data, collecting first and second order markov dependencies
curChar = ''
prevChar = ''
prev2Char = ''
print 'Parsing file...'
for z in read_data:
##    print prev2Char
    prev2Char = prevChar
    prevChar = curChar
    curChar = z
    ind0 = d.index(curChar)
    if prevChar != '':
        ind1 = d.index(prevChar)
        #find our 1st order markov count
        mar1[ind1][ind0] += 1
    if prev2Char != '':
        ind2 = d.index(prev2Char)
        #find our 2nd order markov count
        mar2[ind2][ind1][ind0] += 1
    

##now that we have our counts, figure the probabilities. since we aren't worried about
##memory and stuff, make new arrays...s
print 'Generating Markov dependencies of the first and second order...'
mar1prob = np.zeros((30,30))
mar2prob = np.zeros((30,30,30))

#construct the probability transition matrices from the letter counts...
for i in range(len(d)):
    for k in range(len(d)):
        ## do the first order evaluation...
        mar1prob[i][k] = float(mar1[i][k])/float(c[d[k]])
        for m in range(len(d)):
            ##now do the second order evaluation...
            mar2prob[i][k][m] = float(mar2[i][k][m])/float(c[d[m]])


#use the probability transition matrices to get entropy in the form of matrices
print 'Calculating conditional entropies...'
mar1ent = np.zeros((30,30))
mar2ent = np.zeros((30,30,30))
mar1conEnt = np.zeros((30,1)) #i think i;ll be able to sum the conditional entropies on the fly?
mar2conEnt = np.zeros((30,1))
for i in range(len(d)):
    for k in range(len(d)):
        ## do the first order evaluation...
        if (mar1[i][k])*1000000 != 0:
            mar1ent[i][k] = -float(mar1prob[i][k])*math.log(float(mar1prob[i][k]),2)
            mar1conEnt[k] += mar1ent[i][k]
        for m in range(len(d)):
            ##now do the second order evaluation...
            if (mar2[i][k][m])*1000000 != 0: #need to be sure not taking a zero log
                mar2ent[i][k][m] = -float(mar2prob[i][k][m])*math.log(float(mar2prob[i][k][m]),2)
                mar2conEnt[m] += mar2ent[i][k][m]

#then apply our psuedo stationary probabilities as a way to weight the entropy of each character

entropy1 = 0.0 #first order assumption
entropy2 = 0.0 #second order assumption

for i in range(len(d)):
    entropy1 += mar1conEnt[i]*percent[i]
    entropy2 += mar2conEnt[i]*percent[i]

print 'Given a first-order Markovs assumption, we calcalute the entropy of our file to be: '+str(entropy1[0])
print 'Given a second-order Markov assumption, we calcalute the entropy of our file to be: '+str(entropy2[0])
print ''
print 'since we expect to have a smaller entroy based on a higher order Markov dependency, we'
print '(naively?) assume that we should divide our second-order assumption by 2 (for second).'
print 'This calculation then gives us an entropy of: '+ str(entropy2[0]/2)
