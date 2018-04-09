#!/bin/bash

name=`ls ts*`
cat nowt                                      | tee -a $name
date                                          | tee -a $name
echo '----------------------------'           | tee -a $name
now_stamp=`cat nowst`
sshn_stamp=`date +%s`
let s_stamp=($now_stamp - $sshn_stamp)
let m_stamp=( $s_stamp /60 )
echo $m_stamp                                 | tee -a $name
echo -e '\n'                                  | tee -a $name
