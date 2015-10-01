#!/bin/bash

#Samsung JPGS contain spaces. Change IFS
IFS="
"

if [ $# -eq 0 -o "$1" == "-help" -o "$1" == "-h" ]
then
  echo ""
  echo "Usage: exifrename.sh -safe [description]"
  echo "All files with [jpg|JPG|avi|AVI|mov|MOV] extension in the"
  echo "current directory will be renamed to:"
  echo "YYYY-MM-DD-HH-MM-SS-[SU-]description.[jpg|avi|mov]"  
  echo "With the -safe option the original files will be copied"
  echo "to a subdirectory named ./original and can be deleted later."  
  echo "SU=Subseconds will be added only if its found in the exif tags."
  echo ""
  exit
fi
PARAMS="$*"
echo $PARAMS | grep -q "\-safe" > /dev/null
if [ $? -eq 0 ]
then
  SAFE="YES"
  shift
fi
if [ "$SAFE" == "YES" ]
then
  mkdir original
fi
for file in `ls *.JPG 2>/dev/null`
do
  sfile=`basename $file .JPG`
  mv $file $sfile.jpg
done
for file in *.jpg
do
  echo renaming $file
  if [ "$SAFE" == "YES" ]
  then
    cp "$file" original/
  fi
# extract subseconds and add. if no subseconds then add nothing
  subsec=`exiv2 -g Exif.Photo.SubSecTimeOriginal $file`
  subsec=`echo $subsec | cut -d ' ' -f 4`
  if [ "$subsec" = "" ]
  then 
    exiv2 -F -r "%Y-%m-%d-%H-%M-%S-$1" "$file"
  else 
    exiv2 -F -r "%Y-%m-%d-%H-%M-%S-$subsec-$1" "$file"
  fi
done
for file in `ls *.AVI 2>/dev/null`
do
  echo renaming $file
  if [ "$SAFE" == "YES" ]
  then
    cp $file original/
  fi
  EPOCH=`stat -c %Y $file`
  TIMESTAMP=`date +%Y-%m-%d-%H-%M-%S --date=@${EPOCH}` 
  mv $file ${TIMESTAMP}-${1}.avi
done
for file in `ls *.avi 2>/dev/null`
do
  echo renaming $file
  if [ "$SAFE" == "YES" ]
  then
    cp $file original/
  fi
  EPOCH=`stat -c %Y $file`
  TIMESTAMP=`date +%Y-%m-%d-%H-%M-%S --date=@${EPOCH}` 
  mv $file ${TIMESTAMP}-${1}.avi
done
for file in `ls *.mov 2>/dev/null`
do
  echo renaming $file
  if [ "$SAFE" == "YES" ]
  then
    cp $file original/
  fi
  EPOCH=`stat -c %Y $file`
  TIMESTAMP=`date +%Y-%m-%d-%H-%M-%S --date=@${EPOCH}` 
  mv $file ${TIMESTAMP}-${1}.mov
done
for file in `ls *.MOV 2>/dev/null`
do
  echo renaming $file
  if [ "$SAFE" == "YES" ]
  then
    cp $file original/
  fi
  EPOCH=`stat -c %Y $file`
  TIMESTAMP=`date +%Y-%m-%d-%H-%M-%S --date=@${EPOCH}` 
  mv $file ${TIMESTAMP}-${1}.mov
done
