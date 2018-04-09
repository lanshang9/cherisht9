#!/bin/bash

# ./zmm.sh i1patho i2nod

ttlog=`ls logRun*`
cat paths                                                   | tee -a $ttlog
nrun=`cat paths | wc -l`
echo "nrun  :    "$nrun                                     | tee -a $ttlog
for i in `seq $nrun` ; do
  path=`head -n $i paths | tail -n 1`                       # path: 1methane/CH4_298/
  indat=$(basename $(find $path -name indat*))              # <indat
  out=$(basename $path).txt                                 # >out1 

  echo "---------------------------------"                  | tee -a $ttlog
  echo -e "Condition: "$i                                   | tee -a $ttlog
  echo "PATH  : "`pwd`"/"$path                              | tee -a $ttlog
  echo -e "indat : "$indat"\noutput: "$out                  | tee -a $ttlog
  hostname | tr -d '\n'                                     | tee -a $ttlog
  echo -n ':cpu:'                                           | tee -a $ttlog
  cat /proc/cpuinfo | grep 'processor' | wc -l              | tee -a $ttlog


  cd $path                                                  # cd 1methane/CH4_298/ 
  pwd
  nohup ./a.out <$indat 1>$out 2>ng &                       # run
  cd ..                                                     # --> 1methane
  cd ..                                                     # --> CH4_298/
  sleep 1                                                   # 1 second pause
done                                                        # loop end 5

tip=`date +%Y.%m.%d-%H:%M:%S`
echo "======== ps ux ========> a.out <======== " $tip       | tee -a $ttlog logps
ncpu=`cat /proc/cpuinfo | grep 'processor' | wc -l`

ps ux | grep -v grep | grep 'a.out' | sort -n               | tee -a $ttlog logps pid
npid=`cat pid | wc -l`
if [ $npid -gt 0 ] ; then
  cat pid | awk '{printf $2"\n"}' >pids                     # numpid=30607 30625 30875 ++
  for i in `seq $npid`; do                                  # loop start 1~5 
    pidi=`head -n $i pids | tail -n 1`
    echo $pidi " :"                                         | tee -a $ttlog logps
    ls -l /proc/$pidi | grep "cwd" | awk '{printf $11"\n"}' | tee -a $ttlog logps
  done                                                      # loop end 5 
  sleep 1                                                   # 2 second parse 
else
  echo "== NO Processor a.out is running. " $tip            | tee -a $ttlog logps
fi

echo "---------------------------------"                    | tee -a $ttlog
echo -e '==========\n'`hostname`':cpu:'$ncpu                | tee -a $ttlog logps
echo 'ncpu_remain =  '$ncpu-$npid                           | tee -a $ttlog logps

rm pid*                                                     # delete pid 

sleep 1
exit
