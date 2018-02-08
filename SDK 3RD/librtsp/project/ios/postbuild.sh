#!/bin/sh

# generate the Makefile
CURDIR=`pwd`
cd ../../
SRCROOT=`pwd`"/src"
cd $CURDIR
DESTROOT=CURDIR
echo "begin genMakefiles..."
#[  -z “$SRCROOT” ] ||  SRCROOT=`pwd`

cd "${SRCROOT}"

[ -z “${CONFIGURATION}” ] || CONFIGURATION="Debug"
[ -z “${EXECUTABLE_NAME}” ] || EXECUTABLE_NAME="liblive555.a"

# This will generate a Makefile in the "live" directory and each subdirectory.
"genMakefiles" iphoneos
echo "genMakefiles success."

LIVELIB_PATH="${DESTROOT}/output/lib"
if [ ! -d  "${LIVELIB_PATH}" ]; then
mkdir -p "${LIVELIB_PATH}"
fi

#SIMULATOR_LIB_PATH="${SYMROOT}/${CONFIGURATION}-iphonesimulator/${EXECUTABLE_NAME}"
DEVICE_LIB_PATH="${SYMROOT}/${CONFIGURATION}-iphoneos/${EXECUTABLE_NAME}"
OUTPUT_LIB_PATH="${DESTROOT}/output/lib/${EXECUTABLE_NAME}"


echo "begin to creating universal (multi-architecture) static library..."
# run `lipo -create` when both the simulator and device library exist.
if [ -f "${SIMULATOR_LIB_PATH}" ] && [ -f "${DEVICE_LIB_PATH}" ];
then
echo "both simulator lib and device lib exist, create the univeral file liblive555.a"
lipo -create "${SIMULATOR_LIB_PATH}" "${DEVICE_LIB_PATH}" -output "${OUTPUT_LIB_PATH}"
fi
echo "create success"

INCLUDE_PATH="${DESTROOT}/output/include"

echo "begin copy the header files..."
if [ ! -d "${INCLUDE_PATH}" ]; then
mkdir -p "${INCLUDE_PATH}"
fi

if [ ! -d "${INCLUDE_PATH}/UsageEnvironment/include/" ]; then
mkdir -p "${INCLUDE_PATH}/UsageEnvironment/include/"
fi

if [ ! -d "${INCLUDE_PATH}/liveMedia/include/" ]; then
mkdir -p "${INCLUDE_PATH}/liveMedia/include/"
fi

if [ ! -d "${INCLUDE_PATH}/groupsock/include/" ]; then
mkdir -p "${INCLUDE_PATH}/groupsock/include/"
fi

if [ ! -d "${INCLUDE_PATH}/BasicUsageEnvironment/include/" ]; then
mkdir -p "${INCLUDE_PATH}/BasicUsageEnvironment/include/"
fi

echo "INCLUDE_PATH:${INCLUDE_PATH}"
echo "SRCROOT ${SRCROOT}/User"
# -R / --recursive
chmod a+w "${INCLUDE_PATH}"
cp -R -f "${SRCROOT}/UsageEnvironment/include/"      "${INCLUDE_PATH}/UsageEnvironment/include/"
cp -R -f "${SRCROOT}/liveMedia/include/"             "${INCLUDE_PATH}/liveMedia/include/"
cp -R -f "${SRCROOT}/groupsock/include/"             "${INCLUDE_PATH}/groupsock/include/"
cp -R -f "${SRCROOT}/BasicUsageEnvironment/include/" "${INCLUDE_PATH}/BasicUsageEnvironment/include/"
echo "copy the header files success."
chmod a+w "${LIVELIB_PATH}"
cp -R -f "${DEVICE_LIB_PATH}"  "${LIVELIB_PATH}"
echo "copy lib file ${DEVICE_LIB_PATH} to ${LIVELIB_PATH} ok"

