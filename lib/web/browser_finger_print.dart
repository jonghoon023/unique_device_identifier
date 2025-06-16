import 'dart:js_interop';

import 'package:unique_device_identifier/web/interops/navigator_interop.dart';
import 'package:unique_device_identifier/web/interops/screen_interop.dart';

class BrowserFingerprint {
  Future<String> collect() async {
    final List<String> components = [
      navigator.userAgent,
      navigator.platform,
      navigator.languages.toDart.join(','),
      _getSafeNumber(navigator.hardwareConcurrency),
      _getSafeNumber(navigator.deviceMemory),
      _getSafeNumber(navigator.maxTouchPoints),
      _getSafeNumber(screen.width),
      _getSafeNumber(screen.height),
      _getSafeNumber(screen.colorDepth),
      DateTime.now().timeZoneName,
    ];

    return components.join('|');
  }

  String _getSafeNumber(Object? value) {
    if (value == null) return '';
    if (value is num) return value.toInt().toString();
    return value.toString();
  }
}
