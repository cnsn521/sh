#!/bin/bash
#cpu使用率超过40%重启容器,或内存使用率超过6G（20%）
#Time用来记录日志时间
Time=$(date +"%Y-%m-%d %T")
docker ps
id=openresty
#cpu取出来的值是x.xx%,这里用100*直接取得数值，比如1.73% 等于173
cpu=`docker stats $id --no-stream | sed -n '2,2p' | awk '{print (100*$3)}' `
#内存同上
mem=`docker stats $id --no-stream | sed -n '2,2p' | awk '{print (100*$7)}' `
#40%转变过来就是4000，所以这里判断cpu大于4000就写入日志文件pro-s1.log并重启容器，*0.01是为了显示%记录日志，使用">>"使后面的数据全记录在同一个日志文件中追加记录（pro-s1.log）
echo $cpu $mem
if [ $cpu -ge 4000 ]
then
        echo "$Time CPU 超过40%使用率，当前使用率$(echo "$cpu*0.01" | bc)%,----------正在重启-【$id】">> /home/pro-s1.log
        docker restart $id
#我这里内存总容量是30G，超过6G就重启也就是30G的20%，转变过来就是超过2000就写入日志并重启
elif [ $mem -ge 100 ]
then
        echo "$Time 内存 超过6G使用率，当前使用率$(echo "$mem*0.01" | bc)%,----------正在重启-【$id】 " >> /home/pro-s1.log
        docker restart $id
#:elif [ $mem -lt 2000 -a $cpu -lt 4000 ]
#then
#        echo "$Time CPU和内存均正常，当前使用率cpu:$(echo "$cpu*0.01" | bc)%,内存:$(echo "$mem*0.01" | bc)% " >> /home/pro-s1.log

fi
