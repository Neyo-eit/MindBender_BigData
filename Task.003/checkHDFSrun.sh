# Want to check if HDFS is running!

#!user/bin/bash

var=$(jps)




var1="NameNode"
var2="ResourceManager"

if [[ $var1 == $var ]] && [[ $var2 = $var ]] ;  ### Check if NameNode is in the output of jps
  
then 
   echo "Hadoop is on"   ### True,  means Hadoop is running 

else 
 start-all.sh

fi