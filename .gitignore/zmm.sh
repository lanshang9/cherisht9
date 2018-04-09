#!/bin/bash

# i1patho: /home/zmm/rcd/lCode/3pspfx/10atm_CAU1_2720/1CAU1_2720/
# i2nod:

function sshn() {
  ssh -n $nodi "
  cd $pathr
  echo -e '\n'                                                                 | tee -a $tlog
  pwd                                                                          | tee -a $tlog
  echo 'Now@  '`hostname`':cpu:'`cat /proc/cpuinfo | grep 'processor' | wc -l` | tee -a $tlog
  echo 'Gas '$i':   '$pathi                                                    | tee -a $tlog logps
  echo '*********************************'                                     | tee -a $tlog
  echo '***      Run in '$nrun' Files.      ***'                               | tee -a $tlog
  echo '*********************************'                                     | tee -a $tlog

  echo 'START =========================== '`date -d '19 minute' +%Y.%m.%d-%H:%M:%S` | tee -a $tlog
  ./zmmTs.sh
  echo '============================= END '`date -d '19 minute' +%Y.%m.%d-%H:%M:%S` | tee -a $tlog
  sleep 1
  "
}


#patho=$1                # patho: /home/zmm/rcd/lCode/3pspfx/10atm_CAU1_2720/1CAU1_2720/
nod=$1                   # nod: n53 n54 n55 ++

pwd
echo 'inod: '
cat $nod
echo 'zmm *****************************'

nnod=`cat $nod | wc -l`  # nnod:22
pathr=`pwd`/             # pathr: /home/zmm/rcd/lCode/3pspfx/10atm_CAU1_2720/1CAU1_2720/
cd $pathr                # cd     /home/zmm/rcd/lCode/3pspfx/10atm_CAU1_2720/1CAU1_2720/
ls -d */ >patht          # patht: 1methane/ 2carbondioxide/ 3hydrogen/ ++
npath=`cat patht| wc -l` # npath=9

if [ `hostname` = "n66" ] ; then

  t=`date -d '19 minute' +%Y%m%d%H%M%S`
  ti=`date -d '19 minute' +%Y.%m.%d-%H:%M:%S`
  tlog=`echo 'logRun'$t`
  date -d '19 minute'                                                  | tee -a $tlog
  echo "nnod:"$nnod"   VS   npath:"$npath                              | tee -a $tlog
  echo 'zmm *****************************'                             | tee -a $tlog

  if [ $nnod -ge $npath ]; then                                        # if nnod >= npath
    for i in `seq $npath` ; do                                         # loop start
      nodi=`head -n $i $nod | tail -n 1`                               # nodi: n53
      pathi=`head -n $i patht | tail -n 1`                             # pathi: 1methane

      ls -d $pathi*/   >paths
      cat paths
      nrun=$(cat paths | wc -l)
      sshn
    done                                                               # loop end
  mv logps logps`date -d '19 minute' +%Y%m%d%H%M%S`
  sleep 1
  rm path*

  else                                                                 # if nnod < npath
    echo "-------- ADD ssh nods first."                                # prompt text
  fi                                                                   # end if

  echo '========>' $ti                                                 | tee -a logcpu
  cat logps* | grep -B1 'ncpu_remain'                                  | tee -a logcpu
  echo -e '\n'

else
   echo '!!! Go to ----> n66 <---- first because of $(date).'          | tee -a lCAUTION

fi
