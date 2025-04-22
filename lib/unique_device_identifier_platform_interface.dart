import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'unique_device_identifier_method_channel.dart';

abstract class UniqueDeviceIdentifierPlatform extends PlatformInterface {
  /// Constructs a UniqueDeviceIdentifierPlatform.
  UniqueDeviceIdentifierPlatform() : super(token: _token);

  static final Object _token = Object();

  static UniqueDeviceIdentifierPlatform _instance = MethodChannelUniqueDeviceIdentifier();

  /// The default instance of [UniqueDeviceIdentifierPlatform] to use.
  ///
  /// Defaults to [MethodChannelUniqueDeviceIdentifier].
  static UniqueDeviceIdentifierPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UniqueDeviceIdentifierPlatform] when
  /// they register themselves.
  static set instance(UniqueDeviceIdentifierPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns the unique device identifier for the current platform.
  ///
  /// May return `null` if the platform cannot provide a valid identifier.
  ///
  /// ### Platform behavior:
  /// - **Android**: Returns `Settings.Secure.ANDROID_ID`
  /// - **iOS**: Returns `UIDevice.identifierForVendor`
  /// - **macOS**: Returns `IOPlatformUUID` using IOKit (macOS 12+: `kIOMainPortDefault`, older: `kIOMasterPortDefault`)
  /// - **Windows**: Reads the registry value `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MachineGuid`
  /// - **Linux**: Reads from `/etc/machine-id`
  /// - **Web**: Returns a fingerprint-based hash if possible; otherwise, a random UUID is generated and stored in `localStorage`
  Future<String?> getUniqueIdentifier() {
    throw UnimplementedError('getUniqueIdentifier() has not been implemented.');
  }
}
