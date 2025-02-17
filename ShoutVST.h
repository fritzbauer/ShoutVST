#pragma once
#include <audioeffectx.h>
#include "LibShoutWrapper.h"
#include "ShoutVSTEncoderMP3.h"
#include "ShoutVSTEncoderOGG.h"
#include "ShoutVSTEncoderFLAC.h"
#include "ShoutVSTEditor.h"

#include <atomic>
#include <memory>
#include <mutex>

using std::recursive_mutex;

class ShoutVST : public AudioEffectX {
 public:
  explicit ShoutVST(audioMasterCallback audioMaster);
  virtual ~ShoutVST();
  virtual void processReplacing(float** inputs, float** outputs,
                                VstInt32 sampleFrames) override;
  void connect();
  void disconnect();
  virtual bool getEffectName(char* name) override;
  virtual bool getVendorString(char* text) override;
  virtual bool getProductString(char* text) override;
  virtual VstPlugCategory getPlugCategory() override;
  virtual VstInt32 getVendorVersion() override;
  bool IsConnected();
  int GetBitrate();
  int GetTargetSampleRate();
  void UpdateMetadata(const string& metadata);

 private:
  typedef std::lock_guard<std::recursive_mutex> guard;
  recursive_mutex mtx_;
  std::shared_ptr<ShoutVSTEncoder> encTmp;
  std::shared_ptr<ShoutVSTEncoder> encSelected;
  std::shared_ptr<ShoutVSTEditor> pEditor;
  LibShoutWrapper libShoutWrapper;
};
