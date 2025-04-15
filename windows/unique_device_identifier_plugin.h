#ifndef FLUTTER_PLUGIN_UNIQUE_DEVICE_IDENTIFIER_PLUGIN_H_
#define FLUTTER_PLUGIN_UNIQUE_DEVICE_IDENTIFIER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace unique_device_identifier {

class UniqueDeviceIdentifierPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  UniqueDeviceIdentifierPlugin();

  virtual ~UniqueDeviceIdentifierPlugin();

  // Disallow copy and assign.
  UniqueDeviceIdentifierPlugin(const UniqueDeviceIdentifierPlugin&) = delete;
  UniqueDeviceIdentifierPlugin& operator=(const UniqueDeviceIdentifierPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace unique_device_identifier

#endif  // FLUTTER_PLUGIN_UNIQUE_DEVICE_IDENTIFIER_PLUGIN_H_
