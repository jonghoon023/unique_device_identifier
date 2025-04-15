import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unique_device_identifier/unique_device_identifier_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelUniqueDeviceIdentifier platform = MethodChannelUniqueDeviceIdentifier();
  const MethodChannel channel = MethodChannel('unique_device_identifier');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getUniqueIdentifier', () async {
    final uniqueIdentifier = await platform.getUniqueIdentifier();
    expect(uniqueIdentifier?.isNotEmpty, true);
  });
}
