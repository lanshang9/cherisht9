#!/bin/bash

# zmm --> a.out

tnc=`ls nr*`
tna=`ls na*`
ncpu=`cat /proc/cpuinfo | grep 'processor' | wc -l`
ncpuzmm=`ps ux | grep -v grep | grep 'a.out' | wc -l`
#ncpuR=$[`top -i -b -n 1 | tail -n +8 | grep ' R ' | wc -l` -1]
ncpuR=`ps H -eo %cpu --sort=%cpu | tail -n $ncpu |awk '{print $1}'| while read ratecpu ; do if [ $(echo "$ratecpu >= 10.0"|bc) = 1  ] ; then echo $line; fi ;done | wc -l`
ncpur=$[$ncpu-$ncpuR]
diffR=$[$ncpuR-$ncpuzmm]

case $diffR in
0)
  echo -e '1) =======\n'`hostname`':cpu:'$ncpu                                                               | tee -a $tnc $tna
  echo  'ncpu_remain ='$ncpu'-'$ncpuR'=  '$ncpur' @ '`hostname`                                              | tee -a $tnc $tna

  ps ux | grep -v grep | grep 'a.out' | awk '{print $2,$9,$10}'                                              >pidt
  while read pidi ; do
    echo $pidi': '`ls -l /proc/$(echo $pidi | awk '{print $1}') | grep 'exe' | awk '{print $11}'`            | tee -a $tnc
    echo $pidi': '`basename $(ls -l /proc/$(echo $pidi | awk '{print $1}') | grep 'cwd' | awk '{print $11}')`| tee -a $tna
  done <pidt
  rm pidt
  ;;

1 | 2 )
  echo "!-------------- CHECK FIRST: What's the more 1 pid R is running. ---------------"                    | tee -a $tnc
  top -i -b -n 1 | sort -n                                                                                   | tee -a $tnc
  sleep 1
  echo -e '2) =======\n'`hostname`':cpu:'$ncpu                                                               | tee -a $tnc $tna
  echo  'ncpu_remain ='$ncpu'-'$ncpuR'=  '$ncpur' @ '`hostname`                                              | tee -a $tnc $tna

  ps ux | grep -v grep | grep 'a.out' | awk '{print $2,$9,$10}'                                              >pidt
  while read pidi ; do
    echo $pidi': '`ls -l /proc/$(echo $pidi | awk '{print $1}') | grep 'exe' | awk '{print $11}'`            | tee -a $tnc
    echo $pidi': '`basename $(ls -l /proc/$(echo $pidi | awk '{print $1}') | grep 'cwd' | awk '{print $11}')`| tee -a $tna
  done <pidt
  rm pidt
  ;;

*)
  echo "!------------- There are programs running. Choose another nod pls. -------------"                    | tee -a $tnc
  top -i -b -n 1 | sort -n                                                                                   | tee -a $tnc
  sleep 1
  echo -e '3) =======\n'`hostname`':cpu:'$ncpu                                                               | tee -a $tnc $tna
  echo  'ncpu_remain ='$ncpu'-'$ncpuR'=  '$ncpur' @ '`hostname`                                              | tee -a $tnc $tna

  ps ux | grep -v grep | grep 'a.out' | awk '{print $2,$9,$10}'                                              >pidt
  while read pidi ; do
    echo $pidi': '`ls -l /proc/$(echo $pidi | awk '{print $1}') | grep 'exe' | awk '{print $11}'`            | tee -a $tnc
    echo $pidi': '`basename $(ls -l /proc/$(echo $pidi | awk '{print $1}') | grep 'cwd' | awk '{print $11}')`| tee -a $tna
  done <pidt
  rm pidt
  ;;
esac
exit
