import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'unique_device_identifier_platform_interface.dart';

/// An implementation of [UniqueDeviceIdentifierPlatform] that uses method channels.
class MethodChannelUniqueDeviceIdentifier extends UniqueDeviceIdentifierPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('unique_device_identifier');

  @override
  Future<String?> getUniqueIdentifier() {
    return methodChannel.invokeMethod<String>('get_unique_identifier');
  }
}
