#!/bin/bash

# 读取内容
# 判断是否存在 否则创建文件夹
function isExsitDir(){
  if [ ! -d $1 ]; 
    then
      echo "创建目录：$1";
      mkdir -p $1
      return 1
    else 
      return 0
  fi
}

# $1 源目录 $2目标目录
function readsrcmkdirs() {
  for file in $(ls $1)
  do
  {
    # 如果源目录子目录文件夹
    if [ -d $1"/"$file ]
    then 
      # 创建目标目录
      isExsitDir $2"/"$file
      # 递归子目录
      readsrcmkdirs $1"/"$file $2
    else 
      # 获取文件名
      # 创建最后一层目录
      dpath=$2"/"${1##*/}"/"$file
      rfile="$1/$file"
      mkdir -p $dpath
      # 拉取项目
      # 读取源目录下文件资源
      IFS_old=$IFS      # 记录老的分隔符
      IFS=$'\n'              # 以换行符作为分隔符
      for line in `cat $rfile`
      do
        IFS=$IFS_old;
        # # 截取项目名
        # 先按空格分隔 默认是同步项目
        arr=($line)  
        extname=${arr[0]##*/}
        projname=${extname%%.*}
        
        # 取数组的第一部分
        if [ "${arr[1]}" != "false" ];
        then
          # 开始同步
          # 进入目标目录 
          cd $dpath;
          if [ -d $projname ];
          then
            echo "更新项目： $dpath/$projname"
            ## 如果存在该项目 则git merge
            cd $projname;
            git fetch -p && git merge;
            cd $homepath;
            echo -e "更新完成！！！\n"
          else
            # echo "拉取项目: ${arr[0]} --depth=1"
            echo "拉取项目: ${arr[0]}"
            ## 否则 git clone
            # git clone ${arr[0]} --depth=1;
            git clone ${arr[0]};
            cd -;
            echo "$projname: 拉取项目完成！！！"
            echo -e "\n"
          fi
        else 
          # 不做任何处理
          echo "$projname 已暂停同步";
        fi  
      done
      IFS_old=$IFS
    fi
  }&
  done
  wait 
}

# 1. 输入目标文件夹
homepath=`pwd`;
isExsitDir $1;
readsrcmkdirs "./resource" $1;
echo "同步完成!!!";