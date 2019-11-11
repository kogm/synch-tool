#!/bin/bash

dir=$1;

if [ !dir ]
then
  dir=~/Documents
fi

echo $dir
cd lib;
./synch.sh $dir;