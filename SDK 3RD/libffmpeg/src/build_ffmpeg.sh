#!/bin/bash  

VER=4.9
CPU=arm 
PREFIX=$(pwd)/android/$CPU

export NDK=/home/donyj/workspace/android-ndk-r10e
export PREBUILT=$NDK/toolchains/$CPU-linux-androideabi-$VER/prebuilt/linux-x86_64
export PLATFORM=$NDK/platforms/android-19/arch-$CPU
ADDI_CFLAGS="-marm"

rm -rf $PREFIX /home/donyj/workspace/SDK/3rd/libffmpeg /home/donyj/workspace/SDK/lib/libav* /home/donyj/workspace/SDK/lib/libsw*
mkdir -p $PREFIX
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
	--enable-libx265 \
	--enable-encoder=libx265 \
	--enable-decoder=h264 \
	--enable-decoder=hevc \
	--enable-encoder=mjpeg \
	--enable-decoder=mjpeg \
	--enable-libfaac \
 	--enable-encoder=libfaac \
	--enable-decoder=aac \
	--enable-decoder=pcm_s16be \
	--extra-libs=-lgcc \
        --extra-cflags="-I/home/donyj/workspace/SDK/3rd/libx264/ -I/home/donyj/workspace/SDK/3rd/libx265/ -I/home/donyj/workspace/SDK/3rd/libfaac/ -fPIC -DANDROID -mfpu=neon -mfloat-abi=softfp" \
        --extra-ldflags="-L/home/donyj/workspace/SDK/lib"

make
make install

rm -rf /home/donyj/workspace/SDK/3rd/libffmpeg
mkdir -p /home/donyj/workspace/SDK/3rd/libffmpeg
cp $PREFIX/include/* /home/donyj/workspace/SDK/3rd/libffmpeg -R

mkdir -p /home/donyj/workspace/SDK/lib
cp $PREFIX/lib/*.a  /home/donyj/workspace/SDK/lib
