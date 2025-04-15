import 'dart:js_interop';

@JS('window')
external Window get window;

@JS()
@staticInterop
class Window {}

extension WindowExtension on Window {
  external Storage get localStorage;
  external Crypto get crypto;
}

@JS()
@staticInterop
class Storage {}

extension StorageExtension on Storage {
  external String? getItem(String key);
  external void setItem(String key, String value);
}

@JS()
@staticInterop
class Crypto {}

extension CryptoExtension on Crypto {
  external SubtleCrypto get subtle;
  external JSObject getRandomValues(JSObject array);
}

@JS()
@staticInterop
class SubtleCrypto {}

extension SubtleCryptoExtension on SubtleCrypto {
  external JSPromise digest(String algorithm, JSObject data);
}
