#ifndef __HW_MEDIA_DECODER_H__
#define __HW_MEDIA_DECODER_H__

#if defined(_ANDROID)
#include <android/native_window_jni.h>
#elif defined(_IOS)
#include "mixobjc.h"
#endif

struct StreamDecodedataParameter
{
	char *mimetype;
	int width; 
	int height;
	#ifdef _ANDROID
	ANativeWindow *window;
	#endif
	int profile;
	int channel;
	int samplerate;
};

class CHwMediaDecoder
{
public:
	CHwMediaDecoder() { m_codecid = -1;}
	virtual ~CHwMediaDecoder() {}

public: //音频输出: aac, 视频输出: yuv
	virtual int Decode(unsigned char *pktBuf, int pktLen, int64_t &presentationTimeUs, unsigned char *outBuf) = 0;	
	virtual bool IssuportHardware() = 0;
public:
	int m_codecid; //输出编码格式
	int m_param1;
	int m_param2;
	int m_videow;
	int m_videoh;
};

#endif
