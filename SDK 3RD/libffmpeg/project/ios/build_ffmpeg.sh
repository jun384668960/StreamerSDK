#!/bin/sh
CURDIR=`pwd`
cd ../../..
ROOTDIR=`pwd`
# directories
SOURCE=$ROOTDIR/libffmpeg/src  #"ffmpeg-3.1.7"
chmod +x $SOURCE/configure
chmod +x $SOURCE/version.sh
cd $CURDIR
FAT="FFmpeg-iOS"

SCRATCH="scratch"
# must be an absolute path
THIN=`pwd`/"thin"


# absolute path to x264 library
X264=$ROOTDIR/libx264/project/ios/x264-iOS
#X264=`pwd`/fat-x264

FDK_AAC=$ROOTDIR/libfaac/project/ios/faac-iOS-1.28

#CONFIGURE_FLAGS="--enable-cross-compile --disable-debug --disable-programs \
#                 --disable-doc --enable-pic"
#--disable-network \


CONFIGURE_FLAGS="--enable-cross-compile \
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
	--disable-yasm \
	--disable-zlib \
	--disable-everything \
	--enable-static \
	--enable-runtime-cpudetect \
	--enable-asm \
	--enable-neon \
	--enable-version3 \
	--enable-nonfree \
	--enable-gpl \
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
	--enable-demuxer=mov \
	--enable-demuxer=flv \
	--enable-demuxer=aac \
	--enable-demuxer=h264 \
	--enable-demuxer=hevc \
	--enable-demuxer=mjpeg \
	--enable-demuxer=hls \
	--enable-muxer=mp4 \
	--enable-muxer=flv \
	--enable-muxer=h264 \
	--enable-muxer=hevc \
	--enable-muxer=adts \
	--enable-muxer=hls \
	--enable-libx264 \
	--enable-encoder=libx264 \
	--enable-decoder=h264 \
	--enable-decoder=hevc \
	--enable-encoder=mjpeg \
	--enable-decoder=mjpeg \
	--enable-libfaac \
 	--enable-encoder=libfaac \
	--enable-decoder=aac \
"

if [ "$X264" ]
then
	CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-gpl --enable-libx264 --enable-encoder=libx264"
	#echo "CONFIGURE_FLAGS $CONFIGURE_FLAGS"
fi

if [ "$FDK_AAC" ]
then
	CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-libfaac --enable-encoder=libfaac"
fi

# avresample
#CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-avresample"

#ARCHS="arm64 armv7 x86_64 i386"
#ARCHS="arm64 armv7"
ARCHS="arm64 armv7"
COMPILE="y"
LIPO="y"

DEPLOYMENT_TARGET="8.0"  #"6.0"

if [ "$*" ]
then
	if [ "$*" = "lipo" ]
	then
		# skip compile
		COMPILE=
	else
		ARCHS="$*"
		if [ $# -eq 1 ]
		then
			# skip lipo
			LIPO=
		fi
	fi
fi

if [ "$COMPILE" ]
then
	if [ ! `which yasm` ]
	then
		echo 'Yasm not found'
		if [ ! `which brew` ]
		then
			echo 'Homebrew not found. Trying to install...'
                        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
				|| exit 1
		fi
		echo 'Trying to install Yasm...'
		brew install yasm || exit 1
	fi
	if [ ! `which gas-preprocessor.pl` ]
	then
		echo 'gas-preprocessor.pl not found. Trying to install...'
		(curl -L https://github.com/libav/gas-preprocessor/raw/master/gas-preprocessor.pl \
			-o /usr/local/bin/gas-preprocessor.pl \
			&& chmod +x /usr/local/bin/gas-preprocessor.pl) \
			|| exit 1
	fi

	if [ ! -r $SOURCE ]
	then
		echo 'FFmpeg source not found. Trying to download...'
		curl http://www.ffmpeg.org/releases/$SOURCE.tar.bz2 | tar xj \
			|| exit 1
	fi

	CWD=`pwd`
	for ARCH in $ARCHS
	do
		echo "building $ARCH..."
		mkdir -p "$SCRATCH/$ARCH"
		cd "$SCRATCH/$ARCH"

		CFLAGS="-arch $ARCH"
		if [ "$ARCH" = "i386" -o "$ARCH" = "x86_64" ]
		then
		    PLATFORM="iPhoneSimulator"
		    CFLAGS="$CFLAGS -mios-simulator-version-min=$DEPLOYMENT_TARGET"
		else
		    PLATFORM="iPhoneOS"
		    #CFLAGS="$CFLAGS -mios-version-min=$DEPLOYMENT_TARGET -fembed-bitcode -mfpu=neon -mfloat-abi=softfp"
		    CFLAGS="$CFLAGS -mios-version-min=$DEPLOYMENT_TARGET  -mfpu=neon -mfloat-abi=softfp"
		    if [ "$ARCH" = "arm64" ]
		    then
		        EXPORT="GASPP_FIX_XCODE5=1"
		    fi
		fi

		XCRUN_SDK=`echo $PLATFORM | tr '[:upper:]' '[:lower:]'`
		CC="xcrun -sdk $XCRUN_SDK clang"
		CXXFLAGS="$CFLAGS"
		LDFLAGS="$CFLAGS"
		if [ "$X264" ]
		then
			CFLAGS="$CFLAGS -I$X264/include"
			LDFLAGS="$LDFLAGS -L$X264/lib"
			echo "Now x264 CFLAGS $CFLAGS  LDFLAGS $LDFLAGS"
		fi
		if [ "$FDK_AAC" ]
		then
			CFLAGS="$CFLAGS -I$FDK_AAC/include"
			LDFLAGS="$LDFLAGS -L$FDK_AAC/lib"
		fi

		TMPDIR=${TMPDIR/%\/} $SOURCE/configure \
		    --target-os=darwin \
		    --arch=$ARCH \
		    --cc="$CC" \
		    $CONFIGURE_FLAGS \
		    --extra-cflags="$CFLAGS" \
		    --extra-ldflags="$LDFLAGS" \
		    --prefix="$THIN/$ARCH" \
		|| exit 1

		make -j3 install $EXPORT || exit 1
		cd $CWD
	done
fi

if [ "$LIPO" ]
then
	echo "building fat binaries..."
	mkdir -p $FAT/lib
	set - $ARCHS
	CWD=`pwd`
	cd $THIN/$1/lib
	for LIB in *.a
	do
		cd $CWD
		echo lipo -create `find $THIN -name $LIB` -output $FAT/lib/$LIB 1>&2
		lipo -create `find $THIN -name $LIB` -output $FAT/lib/$LIB || exit 1
	done

	cd $CWD
	cp -rf $THIN/$1/include $FAT
fi

echo Done
