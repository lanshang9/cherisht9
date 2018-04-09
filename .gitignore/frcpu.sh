#!/bin/bash

#nohup ./frcpu.sh icpuch 1>nfree`echo $(date -d '19 minute' +%Y%m%d%H%M%S)` 2>ngf`echo $(date -d '19 minute' +%Y%m%d%H%M%S)` &
# /home/zmm/00indexsh
# icpuch
# @n66
# To compare the usage of Memory at every nod.

nod=$1

if [ `hostname` = "n66" ] ; then
  pathr=`pwd`
  t=`date -d '19 minute' +%Y%m%d%H%M%S`
  date -d '19 minute'
  echo 'zmm ============================================================================'

  nnod=`cat $nod | wc -l`
  for i in `seq $nnod` ; do
    nodi=`head -n $i $nod | tail -n 1`
    ssh -n $nodi "
    cd $pathr
    echo -e '\n'
    echo 'NOD '$i' :  '`pwd`
    hostname |tr '\n' ':'
    echo 'cpu' |tr '\n' ':'
    cat /proc/cpuinfo | grep 'processor' | wc -l
    free -m
    echo 'zmm ================================================================END -----> '$i
    "
  done

else
   echo '!!! Go to ----> n66 <---- first because of $(date).'    | tee -a nCAUTION66

fi
