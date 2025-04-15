#include "include/unique_device_identifier/unique_device_identifier_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "unique_device_identifier_plugin.h"

void UniqueDeviceIdentifierPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  unique_device_identifier::UniqueDeviceIdentifierPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
