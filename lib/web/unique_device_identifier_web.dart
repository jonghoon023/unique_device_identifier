import 'dart:developer' as developer;

import 'dart:js_interop';
import 'dart:convert';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:unique_device_identifier/unique_device_identifier_platform_interface.dart';
import 'package:unique_device_identifier/web/browser_finger_print.dart';

import 'window_interop.dart';
import 'uuid_util.dart';

class UniqueDeviceIdentifierWeb extends UniqueDeviceIdentifierPlatform {
  final BrowserFingerprint _browserFingerprint = BrowserFingerprint();

  static void registerWith(Registrar registrar) {
    UniqueDeviceIdentifierPlatform.instance = UniqueDeviceIdentifierWeb();
  }

  @override
  Future<String?> getUniqueIdentifier() async {
    const key = 'unique_device_identifier';
    String? uniqueIdentifier = window.localStorage.getItem(key);

    if (uniqueIdentifier == null) {
      try {
        final fingerprint = await _browserFingerprint.collect();
        final data = utf8.encode(fingerprint);
        final digestBuffer =
            await window.crypto.subtle.digest('SHA-256', data.toJS).toDart;

        uniqueIdentifier = bufferToHex(digestBuffer as JSArrayBuffer);
      } catch (e) {
        uniqueIdentifier = generateUUID();
        window.localStorage.setItem(key, uniqueIdentifier);

        developer.log(
          '[unique_device_identifier] Web: Failed create uuid. (Err. $e)',
        );
      }
    }

    developer.log(
      '[unique_device_identifier] Web: unique identifier: $uniqueIdentifier',
    );
    return uniqueIdentifier;
  }
}
