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
      for line in `cat $rfile`
      do
        # 截取项目名
        projname=${line##*/}
        projname=${projname%%.*}

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
          # echo "拉取项目: $line --depth=1"
          echo "拉取项目: $line"
          ## 否则 git clone
          # git clone $line --depth=1;
          git clone $line;
          cd -;
          echo "拉取$projname项目完成！！！"
          echo -e "\n"
        fi
      done
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