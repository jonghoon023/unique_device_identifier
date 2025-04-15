#include "unique_device_identifier_plugin.h"

#include <windows.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>
#include <string>
#include <vector>
#include <iomanip>

namespace unique_device_identifier {

void UniqueDeviceIdentifierPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "unique_device_identifier",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<UniqueDeviceIdentifierPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

UniqueDeviceIdentifierPlugin::UniqueDeviceIdentifierPlugin() {}

UniqueDeviceIdentifierPlugin::~UniqueDeviceIdentifierPlugin() {}

std::string GetMachineGuid() {
  HKEY hKey;
  if (RegOpenKeyExW(HKEY_LOCAL_MACHINE,
                    L"SOFTWARE\\Microsoft\\Cryptography",
                    0,
                    KEY_READ | KEY_WOW64_64KEY,
                    &hKey) != ERROR_SUCCESS) {
    return "";
  }

  wchar_t guid[256];
  DWORD size = sizeof(guid);
  if (RegQueryValueExW(hKey,
                       L"MachineGuid",
                       nullptr,
                       nullptr,
                       reinterpret_cast<LPBYTE>(&guid),
                       &size) != ERROR_SUCCESS) {
    RegCloseKey(hKey);
    return "";
  }
  RegCloseKey(hKey);

  int len = WideCharToMultiByte(CP_UTF8, 0, guid, -1, nullptr, 0, nullptr, nullptr);
  if (len <= 1) return "";

  std::string result(len - 1, 0);
  WideCharToMultiByte(CP_UTF8, 0, guid, -1, &result[0], len - 1, nullptr, nullptr);
  return result;
}

void UniqueDeviceIdentifierPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name() == "get_unique_identifier") {
    std::string guid = GetMachineGuid();
    if (!guid.empty()) {
      result->Success(flutter::EncodableValue(guid));
    } else {
      result->Error("UNAVAILABLE", "Machine GUID not available");
    }
  } else {
    result->NotImplemented();
  }
}

}  // namespace unique_device_identifier
