import 'dart:typed_data';
import 'dart:js_interop';

import 'window_interop.dart';

String generateUUID() {
  final bytes = Uint8List(16);
  window.crypto.getRandomValues(bytes.toJS);

  // RFC 4122 version 4 UUID bits
  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;

  final parts = [
    bytes.sublist(0, 4),
    bytes.sublist(4, 6),
    bytes.sublist(6, 8),
    bytes.sublist(8, 10),
    bytes.sublist(10, 16),
  ].map((part) => part.map((b) => b.toRadixString(16).padLeft(2, '0')).join());

  return parts.join('-');
}

String bufferToHex(JSArrayBuffer buffer) {
  final bytes = Uint8List.view(buffer.toDart);
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
