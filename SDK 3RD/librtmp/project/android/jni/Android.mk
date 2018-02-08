LOCAL_PATH:= $(call my-dir)

#################################################################################################################
include $(CLEAR_VARS)
LOCAL_MODULE    := librtmp

LOCAL_SRC_FILES := \
	../../../src/amf.c \
	../../../src/hashswf.c \
	../../../src/i386.c \
	../../../src/log.c \
	../../../src/parseurl.c \
	../../../src/rtmp.c 

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../../../src/

LOCAL_STATIC_LIBRARIES := 
LOCAL_SHARED_LIBRARIES :=
LOCAL_LDLIBS := -llog -landroid -ljnigraphics
LOCAL_CFLAGS += -DNO_CRYPTO
LOCAL_CPPFLAGS += $(JNI_CFLAGS)

include $(BUILD_STATIC_LIBRARY)
