#!/bin/bash

currentdir=`pwd`

for original in *.rar; do
   dirtemp=/tmp/$original
   
   if [ ! -e $dirtemp ]; 
   then
     mkdir $dirtemp
   fi

   unrar x $original $dirtemp
   cd $dirtemp
   zip -r $currentdir/$original.zip *
   cd $currentdir
   rm -fRd $dirtemp

done