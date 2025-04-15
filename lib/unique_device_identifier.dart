
import 'unique_device_identifier_platform_interface.dart';

class UniqueDeviceIdentifier {
  static Future<String?> getUniqueIdentifier() {
    return UniqueDeviceIdentifierPlatform.instance.getUniqueIdentifier();
  }
}
