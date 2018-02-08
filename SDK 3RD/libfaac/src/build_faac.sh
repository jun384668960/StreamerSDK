#!/bin/bash

CPU=arm
VER=4.9
PREFIX=$(pwd)/android/$CPU

export NDK=/home/donyj/workspace/android-ndk-r10e
export PREBUILT=$NDK/toolchains/$CPU-linux-androideabi-$VER/prebuilt
export PLATFORM=$NDK/platforms/android-19/arch-$CPU

CFLAGS="-fpic -DANDROID -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__ -Wno-psabi -march=armv5te -mtune=xscale -msoft-float -mthumb -Os -fomit-frame-pointer -fno-strict-aliasing -finline-limit=64 -DANDROID -Wa,--noexecstack -MMD -MP "
CROSS_COMPILE=$PREBUILT/linux-x86_64/bin/$CPU-linux-androideabi-
export CPPFLAGS="$CFLAGS"
export CFLAGS="$CFLAGS"
export CXXFLAGS="$CFLAGS"
export CXX="${CROSS_COMPILE}g++ --sysroot=${PLATFORM}"
export LDFLAGS="$LDFLAGS"
export CC="${CROSS_COMPILE}gcc --sysroot=${PLATFORM}"
export NM="${CROSS_COMPILE}nm"
export STRIP="${CROSS_COMPILE}strip"
export RANLIB="${CROSS_COMPILE}ranlib"
export AR="${CROSS_COMPILE}ar"

./configure --program-prefix=$PREFIX \
--host=$CPU-linux \
--enable-static \
--disable-shared \
--with-pic \
--without-mp4v2 

make

mkdir -p /home/donyj/workspace/SDK/3rd/libfaac
cp include/*.h /home/donyj/workspace/SDK/3rd/libfaac

mkdir -p /home/donyj/workspace/SDK/lib
cp libfaac/.libs/*.a /home/donyj/workspace/SDK/lib
