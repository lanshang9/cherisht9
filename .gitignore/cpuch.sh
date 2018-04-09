#!/bin/bash

#nohup ./cpuch.sh icpuch 1>nh`echo $(date -d '19 minute' +%Y%m%d%H%M%S)` 2>ng`echo $(date -d '19 minute' +%Y%m%d%H%M%S)` &
# /home/zmm/00indexsh
# icpuch
# @n66
# 1. Check state, 
# 2. list exact path and PID,
# 3. calculate cpu usage
#                              of running .f/.c program at nods <icpuch>.

nod=$1

if [ `hostname` = "n66" ] ; then
  pathr=`pwd`
  t=`date -d '19 minute' +%Y%m%d%H%M%S`
  tnc=`echo 'nr'$t`
  tna=`echo 'na'$t`
  tni=`echo 'nindex'$t`
  date -d '19 minute'                                                                        | tee -a $tnc $tna
  echo 'zmm ============================================================================'    | tee -a $tnc $tna

  nnod=`cat $nod | wc -l`
  for i in `seq $nnod` ; do
    nodi=`head -n $i $nod | tail -n 1`
    ssh -n $nodi "
    cd $pathr
    echo 'NOD '$i' :  '`pwd`                                                                 | tee -a $tnc
    ./cpuchI.sh
    echo 'zmm ================================================================END -----> '$i | tee -a $tnc $tna
    echo -e '\n'
    "
  done
  cat $tna | grep  'cpu'                                                                     | tee -a $tni

  cat nindex* | grep 'remain' | awk '{print $3,$5}'
 
 else
    echo '!!! Go to ----> n66 <---- first because of $(date).'          | tee -a nCAUTION66
 
 fi
 
