#!/bin/bash --login

if [ `hostname` = "n66" ] ; then
  pathr=`pwd`
  name='ts'`date -d '19 minute' +%Y%m%d%H%M%S`
  date -d '19 minute'                             | tee -a $pathr/$name
  pwd                                             | tee -a $pathr/$name
  hostname                                        | tee -a $pathr/$name
  echo ----------------------------               | tee -a $pathr/$name
  
#  for i in $(seq 51 66 ; seq 71 85) 91 ; do 
  for i in 66 91 135 ; do  
    ssh -n n$i " 
    cd $pathr 
    hostname | tr -d '\n'                         | tee -a $pathr/$name
    echo -n ':cpu:'                               | tee -a $pathr/$name
    cat /proc/cpuinfo | grep 'processor' | wc -l  | tee -a $pathr/$name
    echo ----------------------------             | tee -a $pathr/$name
    echo `date -d '19 minute' +%s`                >nowst
    echo `date -d '19 minute'`' @Beijing Time'    >nowt
    ./timediff.sh
    echo ----------------------------             | tee -a $pathr/$name
    sleep 0.2
    rm now*
    exit
    " 
  done 

else
  echo '!!! Go to ----> n66 <---- first because of $(date).' | tee -a nCAUTION

fi
