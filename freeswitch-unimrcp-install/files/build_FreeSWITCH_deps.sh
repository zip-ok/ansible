#!/bin/bash

cd ./spandsp
git checkout 0d2e6ac
./bootstrap.sh
# ./configure CFLAGS="-g -ggdb" --with-pic --prefix=/usr
./configure
# make -j`nproc --all`
make
sudo make install
cd ..

cd ./libks
cmake . -DCMAKE_INSTALL_PREFIX=/usr -DWITH_LIBBACKTRACE=1
sudo make install
cd ..

cd ./sofia-sip
./bootstrap.sh
# ./configure CFLAGS="-g -ggdb" --with-pic --with-glib=no --without-doxygen --disable-stun --prefix=/usr
./configure
# make -j`nproc --all`
make
sudo make install
cd ..

cd ./signalwire-c
PKG_CONFIG_PATH=/usr/lib/pkgconfig cmake . -DCMAKE_INSTALL_PREFIX=/usr
sudo make install
cd ..

# Install Lua Module
cp /usr/include/lua5.2/*.h ./freeswitch/src/mod/languages/mod_lua/
if [ ! -f "/usr/lib/x86_64-linux-gnu/liblua.so" ]; then
  sudo ln -s /usr/lib/x86_64-linux-gnu/liblua5.2.so /usr/lib/x86_64-linux-gnu/liblua.so
fi

cd ./freeswitch
# ./bootstrap.sh -j
./bootstrap.sh
./configure --enable-core-odbc-support --enable-core-pgsql-support
# make -j`nproc`
make
sudo make install
# make cd-sounds-install
# make cd-moh-install
cd ..

sym_links=(
  "/etc/freeswitch:/usr/local/freeswitch/conf"
  "/usr/bin/fs_cli:/usr/local/freeswitch/bin/fs_cli"
  "/usr/sbin/freeswitch:/usr/local/freeswitch/bin/freeswitch"
)

for s_l in "${sym_links[@]}"; do
  source="${s_l%:*}"
  target="${s_l#*:}"
  if [ ! -L "$source" ]; then
    ln -s "$target" "$source"
  fi
done