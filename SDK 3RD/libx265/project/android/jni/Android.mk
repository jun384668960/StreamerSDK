LOCAL_PATH:= $(call my-dir)

#################################################################################################################
include $(CLEAR_VARS)
LOCAL_MODULE    := libx265

LOCAL_SRC_FILES := \
                ../../../src/common/arm/asm-primitives.cpp \
                ../../../src/common/arm/asm.S \
                ../../../src/common/arm/blockcopy8.S \
                ../../../src/common/arm/cpu-a.S \
                ../../../src/common/arm/dct-a.S \
                ../../../src/common/arm/ipfilter8.S \
                ../../../src/common/arm/mc-a.S \
                ../../../src/common/arm/pixel-util.S \
                ../../../src/common/arm/sad-a.S \
                ../../../src/common/arm/ssd-a.S \
                ../../../src/common/bitstream.cpp \
                ../../../src/common/common.cpp \
                ../../../src/common/constants.cpp \
                ../../../src/common/cpu.cpp \
                ../../../src/common/cudata.cpp \
                ../../../src/common/dct.cpp \
                ../../../src/common/deblock.cpp \
                ../../../src/common/frame.cpp \
                ../../../src/common/framedata.cpp \
                ../../../src/common/intrapred.cpp \
                ../../../src/common/ipfilter.cpp \
                ../../../src/common/loopfilter.cpp \
                ../../../src/common/lowres.cpp \
                ../../../src/common/md5.cpp \
                ../../../src/common/param.cpp \
                ../../../src/common/piclist.cpp \
                ../../../src/common/picyuv.cpp \
                ../../../src/common/pixel.cpp \
                ../../../src/common/predict.cpp \
                ../../../src/common/primitives.cpp \
                ../../../src/common/quant.cpp \
                ../../../src/common/scalinglist.cpp \
                ../../../src/common/shortyuv.cpp \
                ../../../src/common/slice.cpp \
                ../../../src/common/threading.cpp \
                ../../../src/common/threadpool.cpp \
                ../../../src/common/version.cpp \
                ../../../src/common/wavefront.cpp \
                ../../../src/common/winxp.cpp \
                ../../../src/common/yuv.cpp \
                ../../../src/encoder/analysis.cpp \
                ../../../src/encoder/api.cpp \
                ../../../src/encoder/bitcost.cpp \
                ../../../src/encoder/dpb.cpp \
                ../../../src/encoder/encoder.cpp \
                ../../../src/encoder/entropy.cpp \
                ../../../src/encoder/frameencoder.cpp \
                ../../../src/encoder/framefilter.cpp \
                ../../../src/encoder/level.cpp \
                ../../../src/encoder/motion.cpp \
                ../../../src/encoder/nal.cpp \
                ../../../src/encoder/ratecontrol.cpp \
                ../../../src/encoder/reference.cpp \
                ../../../src/encoder/sao.cpp \
                ../../../src/encoder/search.cpp \
                ../../../src/encoder/sei.cpp \
                ../../../src/encoder/slicetype.cpp \
                ../../../src/encoder/weightPrediction.cpp

LOCAL_C_INCLUDES += \
    $(LOCAL_PATH)/../../../src/common  \
    $(LOCAL_PATH)/../../../src/encoder \
    $(LOCAL_PATH)/../../../src/

LOCAL_ARM_MODULE := arm
LOCAL_CFLAGS := -Wall -Wextra -Wshadow -std=gnu++98 -fPIC -Wno-array-bounds -ffast-math -fno-exceptions -fpermissive -frtti -Wno-maybe-uninitialized
LOCAL_CFLAGS += -DEXPORT_C_API=1 -DHAVE_INT_TYPES_H=1 -DHIGH_BIT_DEPTH=0 -DX265_DEPTH=8 -DX265_NS=x265 -D__STDC_LIMIT_MACROS=1 -DHAVE_STRTOK_R -DHAVE_NEON -DX265_ARCH_ARM
LOCAL_EXPORT_CFLAGS := $(LOCAL_CFLAGS)

include $(BUILD_STATIC_LIBRARY)