import 'dart:js_interop';

@JS('navigator')
external Navigator get navigator;

@JS()
@staticInterop
class Navigator {}

extension NavigatorExtension on Navigator {
  external String get userAgent;
  external JSArray get languages;
  external String get platform;
  external int get hardwareConcurrency;
  external int get maxTouchPoints;
}
