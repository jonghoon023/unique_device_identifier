import 'package:flutter_test/flutter_test.dart';
import 'package:unique_device_identifier/unique_device_identifier.dart';
import 'package:unique_device_identifier/unique_device_identifier_platform_interface.dart';
import 'package:unique_device_identifier/unique_device_identifier_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUniqueDeviceIdentifierPlatform
    with MockPlatformInterfaceMixin
    implements UniqueDeviceIdentifierPlatform {

  @override
  Future<String?> getUniqueIdentifier() => Future.value('be2e98d5-3ae8-43ca-8e08-83b05788760c');
}

void main() {
  final UniqueDeviceIdentifierPlatform initialPlatform = UniqueDeviceIdentifierPlatform.instance;

  test('$MethodChannelUniqueDeviceIdentifier is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUniqueDeviceIdentifier>());
  });

  test('getUniqueIdentifier', () async {
    UniqueDeviceIdentifier uniqueDeviceIdentifierPlugin = UniqueDeviceIdentifier();
    MockUniqueDeviceIdentifierPlatform fakePlatform = MockUniqueDeviceIdentifierPlatform();
    UniqueDeviceIdentifierPlatform.instance = fakePlatform;

    final uniqueIdentifier = await uniqueDeviceIdentifierPlugin.getUniqueIdentifier();
    expect(uniqueIdentifier?.isNotEmpty, true);
  });
}
