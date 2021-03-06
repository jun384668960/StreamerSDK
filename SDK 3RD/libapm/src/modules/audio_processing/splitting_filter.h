/*
 *  Copyright (c) 2014 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef WEBRTC_MODULES_AUDIO_PROCESSING_SPLITTING_FILTER_H_
#define WEBRTC_MODULES_AUDIO_PROCESSING_SPLITTING_FILTER_H_

#include <string.h>

#include "common_audio/resampler/push_sinc_resampler.h"
#include "system_wrappers/interface/scoped_ptr.h"
#include "system_wrappers/interface/scoped_vector.h"
#include "typedefs.h"

namespace webrtc {

class IFChannelBuffer;

enum {
  kSamplesPer8kHzChannel = 80,
  kSamplesPer16kHzChannel = 160,
  kSamplesPer32kHzChannel = 320,
  kSamplesPer48kHzChannel = 480,
  kSamplesPer64kHzChannel = 640
};

struct TwoBandsStates {
  TwoBandsStates() {
    memset(analysis_state1, 0, sizeof(analysis_state1));
    memset(analysis_state2, 0, sizeof(analysis_state2));
    memset(synthesis_state1, 0, sizeof(synthesis_state1));
    memset(synthesis_state2, 0, sizeof(synthesis_state2));
  }

  static const int kStateSize = 6;
  int analysis_state1[kStateSize];
  int analysis_state2[kStateSize];
  int synthesis_state1[kStateSize];
  int synthesis_state2[kStateSize];
};

// Splitting filter which is able to split into and merge from 2 or 3 frequency
// bands. The number of channels needs to be provided at construction time.
//
// For each block, Analysis() is called to split into bands and then Synthesis()
// to merge these bands again. The input and output signals are contained in
// IFChannelBuffers and for the different bands an array of IFChannelBuffers is
// used.
class SplittingFilter {
 public:
  SplittingFilter(int channels);

  void Analysis(const IFChannelBuffer* in_data,
                const std::vector<IFChannelBuffer*>& bands);
  void Synthesis(const std::vector<IFChannelBuffer*>& bands,
                 IFChannelBuffer* out_data);

 private:
  // These work for 640 samples or less.
  void TwoBandsAnalysis(const IFChannelBuffer* in_data,
                        IFChannelBuffer* band1,
                        IFChannelBuffer* band2);
  void TwoBandsSynthesis(const IFChannelBuffer* band1,
                         const IFChannelBuffer* band2,
                         IFChannelBuffer* out_data);
  // These only work for 480 samples at the moment.
  void ThreeBandsAnalysis(const IFChannelBuffer* in_data,
                          IFChannelBuffer* band1,
                          IFChannelBuffer* band2,
                          IFChannelBuffer* band3);
  void ThreeBandsSynthesis(const IFChannelBuffer* band1,
                           const IFChannelBuffer* band2,
                           const IFChannelBuffer* band3,
                           IFChannelBuffer* out_data);
  void InitBuffers();

  int channels_;
  scoped_ptr<TwoBandsStates[]> two_bands_states_;
  scoped_ptr<TwoBandsStates[]> band1_states_;
  scoped_ptr<TwoBandsStates[]> band2_states_;
  ScopedVector<PushSincResampler> analysis_resamplers_;
  ScopedVector<PushSincResampler> synthesis_resamplers_;
  scoped_ptr<int16_t[]> int_buffer_;
};

}  // namespace webrtc

#endif  // WEBRTC_MODULES_AUDIO_PROCESSING_SPLITTING_FILTER_H_
