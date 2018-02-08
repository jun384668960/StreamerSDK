#!/bin/bash  

VER=4.6
CPU=arm 
PREFIX=$(pwd)/android/$CPU

NDK=/home/yangsq/3rd/android-ndk-r10
PLATFORM=$NDK/platforms/android-19/arch-$CPU
PREBUILT=$NDK/toolchains/$CPU-linux-androideabi-$VER/prebuilt/linux-x86_64
ADDI_CFLAGS="-marm"

rm -rf $PREFIX /home/yangsq/3rd/libffmpeg /home/yangsq/lib/libav* /home/yangsq/lib/libsw*
find ./ -name "*.o" -exec rm -f {} \;

./configure --prefix=$PREFIX \
	--target-os=linux \
	--arch=$CPU \
	--cpu=armv7-a \
	--enable-cross-compile \
	--cc=$PREBUILT/bin/$CPU-linux-androideabi-gcc \
	--cross-prefix=$PREBUILT/bin/$CPU-linux-androideabi- \
	--nm=$PREBUILT/bin/$CPU-linux-androideabi-nm \
	--sysroot=$PLATFORM \
	--disable-doc \
	--disable-programs \
	--disable-shared \
	--disable-avdevice \
	--disable-postproc \
	--disable-avfilter \
	--disable-swresample \
	--disable-avresample \
	--disable-bsfs \
	--disable-filters \
	--disable-protocols \
	--disable-muxers \
	--disable-parsers \
	--disable-demuxers \
	--disable-encoders \
	--disable-decoders \
	--disable-zlib \
	--disable-everything \
	--enable-static \
	--enable-runtime-cpudetect \
	--enable-yasm \
	--enable-asm \
	--enable-neon \
	--enable-version3 \
	--enable-nonfree \
	--enable-gpl \
	--enable-network \
	--enable-pthreads \
	--enable-avcodec \
	--enable-avformat \
	--enable-swscale \
	--enable-protocol=file \
	--enable-protocol=http \
	--enable-protocol=hls \
	--enable-parser=aac \
	--enable-parser=h264 \
	--enable-parser=hevc \
	--enable-parser=mpeg4video \
	--enable-demuxer=mpegps \
	--enable-demuxer=mpegts \
	--enable-demuxer=hls \
	--enable-demuxer=mov \
	--enable-demuxer=flv \
	--enable-demuxer=aac \
	--enable-demuxer=h264 \
	--enable-demuxer=hevc \
	--enable-demuxer=mjpeg \
	--enable-muxer=mp4 \
	--enable-muxer=flv \
	--enable-muxer=h264 \
	--enable-muxer=hevc \
	--enable-muxer=adts \
	--enable-libx264 \
	--enable-encoder=libx264 \
	--enable-decoder=h264 \
	--enable-decoder=hevc \
	--enable-encoder=mjpeg \
	--enable-decoder=mjpeg \
	--enable-libfaac \
 	--enable-encoder=libfaac \
	--enable-decoder=aac \
	--enable-decoder=pcm_s16be \
	--extra-libs=-lgcc \
        --extra-cflags="-I/home/yangsq/3rd/libx264/ -I/home/yangsq/3rd/libfaac/ -I$PLATFORM/usr/include -fPIC -DANDROID -mfpu=neon -mfloat-abi=softfp" \
        --extra-ldflags="-L/home/yangsq/lib -Wl,-T,$PREBUILT/$CPU-linux-androideabi/lib/ldscripts/armelf_linux_eabi.x -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib $PREBUILT/lib/gcc/arm-linux-androideabi/$VER/crtbegin.o $PREBUILT/lib/gcc/arm-linux-androideabi/$VER/crtend.o -lc -lm -ldl"

make
make install

rm -rf /home/yangsq/3rd/libffmpeg
mkdir -p /home/yangsq/3rd/libffmpeg
cp $PREFIX/include/* /home/yangsq/3rd/libffmpeg -R

mkdir -p /home/yangsq/lib/
cp $PREFIX/lib/*.a  /home/yangsq/lib
