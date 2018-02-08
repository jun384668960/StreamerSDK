#!/bin/bash

CPU=arm  
VER=4.6
PREFIX=$(pwd)/android/$CPU  

export NDK=/home/yangsq/3rd/android-ndk-r10
export PLATFORM=$NDK/platforms/android-19/arch-$CPU/
export PREBUILT=$NDK/toolchains/$CPU-linux-androideabi-$VER/prebuilt/
ADDI_CFLAGS="-marm"

./configure --prefix=$PREFIX \
--host=$CPU-linux \
--enable-static \
--enable-pic \
--disable-cli \
--cross-prefix=$PREBUILT/linux-x86_64/bin/$CPU-linux-androideabi- \
--sysroot=$PLATFORM

make
make install

mkdir -p /home/yangsq/3rd/libx264
cp $PREFIX/include/* /home/yangsq/3rd/libx264 -R

mkdir -p /home/yangsq/lib/
cp $PREFIX/lib/*.a $PREFIX/lib/*.so /home/yangsq/lib
