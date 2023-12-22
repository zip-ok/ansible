#!/bin/bash

cd ./unimrcp-deps-1.6.0/libs/apr
./configure --prefix=/usr/local/apr
make
sudo make install
cd ..

cd ./apr-util
./configure --with-apr=/usr/local/apr --prefix=/usr/local/apr
make
sudo make install
cd ../../..

cd ./unimrcp
./bootstrap
./configure
make
sudo make install
cd ..