#!/bin/bash
if [ `hostname` = "n66" ] ; then
  patho=`pwd`
  tname=$(echo 'lcdpo'`date -d '19 minute' +%Y%m%d%H%M%S`)
  date -d '19 minute' +%Y%m%d%H%M%S                          | tee -a $patho/$tname
  ls -d */                                                   >paths
  while read pathi ; do
    echo $pathi
    cd $pathi
    pwd                                                      | tee -a $patho/$tname
    ls -d */                                                 >$patho/paths2
    while read pathj ;do
      echo $pathj'line= '`cat $pathj/cd_po.dat | wc -l `     | tee -a $patho/$tname
    done                                                     <$patho/paths2
    cd ..
    rm paths2

  done                                                       <paths
  rm paths
else
  echo '!!! Go to ----> n66 <---- first because of $(date).' | tee -a CAUTION66

fi
