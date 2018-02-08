#!/bin/bash

CPU=arm  
VER=4.9
PREFIX=$(pwd)/android/$CPU  

export NDK=/home/donyj/workspace/android-ndk-r10e
export PREBUILT=$NDK/toolchains/$CPU-linux-androideabi-$VER/prebuilt
export PLATFORM=$NDK/platforms/android-19/arch-$CPU
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

mkdir -p /home/donyj/workspace/SDK/3rd/libx264
cp $PREFIX/include/* /home/donyj/workspace/SDK/3rd/libx264 -R

mkdir -p /home/donyj/workspace/SDK/lib
cp $PREFIX/lib/*.a $PREFIX/lib/*.so /home/donyj/workspace/SDK/lib
