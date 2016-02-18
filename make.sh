#!/bin/sh

#This file will create a minifed version of raw.sh

#Note: !!! comment stripping is not perfect !!!


sed 's/#.*//g' | # Removing comments

#Minified
sed '
#Load entire file into buffer
:a;N;$!ba;

s/\n\t\+/\n/g

#Striping newlines
s/\n\n\+/\n/g
s/^\n*// #First
s/\n*$// #Last

s/{\n/{/g # {
s/\n}/}/g # }


s/ \+\n/\n/g
s/\n/;/g



#Bin sh will be stripped as a comment however it can be re introduced by uncommenting next line
#s/^/#!\/bin\/sh\n/
'


