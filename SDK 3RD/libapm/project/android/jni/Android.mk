LOCAL_PATH := $(call my-dir)

#################################################################################################################
include $(CLEAR_VARS)
LOCAL_MODULE    := libapm_ns

LOCAL_SRC_FILES := \
        ../../../src/modules/audio_processing/ns/noise_suppression.c \
        ../../../src/modules/audio_processing/ns/ns_core.c \
        ../../../src/modules/audio_processing/utility/fft4g.c 
LOCAL_C_INCLUDES += \
    $(LOCAL_PATH)/../../../src/

include $(BUILD_STATIC_LIBRARY)

#################################################################################################################
include $(CLEAR_VARS)
LOCAL_MODULE    := libapm_vad

LOCAL_SRC_FILES := \
        ../../../src/common_audio/vad/webrtc_vad.c \
        ../../../src/common_audio/vad/vad_core.c \
        ../../../src/common_audio/vad/vad_filterbank.c \
        ../../../src/common_audio/vad/vad_gmm.c \
        ../../../src/common_audio/vad/vad_sp.c \
        ../../../src/common_audio/signal_processing/real_fft.c \
        ../../../src/common_audio/signal_processing/division_operations.c \
        ../../../src/common_audio/signal_processing/complex_bit_reverse.c \
        ../../../src/common_audio/signal_processing/cross_correlation.c \
        ../../../src/common_audio/signal_processing/complex_fft.c \
        ../../../src/common_audio/signal_processing/downsample_fast.c \
        ../../../src/common_audio/signal_processing/vector_scaling_operations.c \
        ../../../src/common_audio/signal_processing/get_scaling_square.c \
        ../../../src/common_audio/signal_processing/energy.c \
        ../../../src/common_audio/signal_processing/min_max_operations.c \
        ../../../src/common_audio/signal_processing/spl_init.c
LOCAL_C_INCLUDES += \
    $(LOCAL_PATH)/../../../src/

include $(BUILD_STATIC_LIBRARY)

#################################################################################################################
include $(CLEAR_VARS)
LOCAL_MODULE    := libapm_aecm

LOCAL_SRC_FILES := \
        ../../../src/common_audio/signal_processing/randomization_functions.c \
        ../../../src/common_audio/signal_processing/spl_sqrt_floor.c \
        ../../../src/common_audio/signal_processing/division_operations.c \
        ../../../src/common_audio/signal_processing/min_max_operations.c \
        ../../../src/common_audio/ring_buffer.c \
        ../../../src/modules/audio_processing/utility/delay_estimator.c \
        ../../../src/modules/audio_processing/utility/delay_estimator_wrapper.c \
        ../../../src/common_audio/signal_processing/complex_bit_reverse.c \
        ../../../src/common_audio/signal_processing/complex_fft.c \
        ../../../src/modules/audio_processing/aecm/aecm_core.c \
        ../../../src/modules/audio_processing/aecm/echo_control_mobile.c
LOCAL_C_INCLUDES += \
    $(LOCAL_PATH)/../../../src/

include $(BUILD_STATIC_LIBRARY)

#################################################################################################################
include $(CLEAR_VARS)
LOCAL_MODULE    := libapm_agc

LOCAL_SRC_FILES := \
        ../../../src/common_audio/signal_processing/spl_sqrt.c \
        ../../../src/common_audio/signal_processing/copy_set_operations.c \
        ../../../src/common_audio/signal_processing/division_operations.c \
        ../../../src/common_audio/signal_processing/dot_product_with_scale.c \
        ../../../src/common_audio/signal_processing/resample_by_2.c \
        ../../../src/modules/audio_processing/agc/legacy/analog_agc.c \
        ../../../src/modules/audio_processing/agc/legacy/digital_agc.c
LOCAL_C_INCLUDES += \
    $(LOCAL_PATH)/../../../src/

include $(BUILD_STATIC_LIBRARY)