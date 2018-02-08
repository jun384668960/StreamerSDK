#ifndef __HW_MEDIA_ENCODER_H__
#define __HW_MEDIA_ENCODER_H__

struct StreamEncodedataParameter
{
	char *mimetype;
	int width;
	int height;
	int fps;
	int gop;
	int64_t bitrate;

	int profile;
	int channel;
	int samplerate;
};

class CHwMediaEncoder
{
public:
	CHwMediaEncoder() { m_codecid = -1;}
	virtual ~CHwMediaEncoder() {};

public:
	virtual int Encode(unsigned char *pktBuf, int pktLen, int64_t &presentationTimeUs, unsigned char *outBuf) = 0;
	virtual bool IssuportHardware() = 0;
public:
	int m_codecid;
};

#endif
