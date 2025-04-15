import 'dart:js_interop';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:unique_device_identifier/unique_device_identifier_platform_interface.dart';

import 'navigator_interop.dart';
import 'window_interop.dart';
import 'uuid_util.dart';

class UniqueDeviceIdentifierWeb extends UniqueDeviceIdentifierPlatform {
  static void registerWith(Registrar registrar) {
    UniqueDeviceIdentifierPlatform.instance = UniqueDeviceIdentifierWeb();
  }

  @override
  Future<String?> getUniqueIdentifier() async {
    try {
      final info = [
        navigator.userAgent,
        navigator.languages.toDart.cast<String>().join(','),
        navigator.platform,
        navigator.hardwareConcurrency.toString(),
        navigator.maxTouchPoints.toString(),
        DateTime.now().timeZoneName,
      ].join('|');

      final data = Uint8List.fromList(utf8.encode(info));
      final digestBuffer = await window.crypto.subtle
          .digest('SHA-256', data.jsify() as JSObject)
          .toDart;

      return bufferToHex(digestBuffer as JSArrayBuffer);
    } catch (_) {
      const key = 'unique_device_id_fallback';
      var stored = window.localStorage.getItem(key);
      if (stored == null) {
        stored = generateUUID();
        window.localStorage.setItem(key, stored);
      }
      return stored;
    }
  }
}
