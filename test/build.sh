#!/bin/bash

curdir=$(pwd)

cd $curdir
cd ../3rd/lua-5.4.3
make
chmod +x lua
chmod +x luac

cd $curdir
../src/luaprofile/
make linux
cp profile.so $curdir

echo "build one"



