
# Solution in python for first Homework

import json
import pydoop.hdfs as hdfs

import string

with open("Shakespeare.txt") as file1:
	txtFile=file1.read().split()
# List to store clean words
newlist=[]

# Create a set to exclude punctuations

exclude=set(string.punctuation)

# For each string in the text file, remove unwanted character
for i in txtFile:
	i=''.join( ch for ch in i if ch not in exclude)
	newlist.append(i)

# Convert all words in the list to lower case
wordlist= [w.lower() for w in newlist]

dic=dict()

for word in wordlist:
	if word in dic:
		dic[word]+=1
	else:
		dic[word]=1

dic

result = sorted(dic.items() , key = lambda x: x[1])

with open("sample.txt", "w") as outfile: 
    json.dump(result, outfile) 
file_path = "/home/user/sample.txt"
finalFile = "hdfs://localhost:9000/Test_002"
hdfs.put(file_path, finalFile)
