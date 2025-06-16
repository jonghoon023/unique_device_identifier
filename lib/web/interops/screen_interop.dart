import 'dart:js_interop';

@JS('screen')
external Screen get screen;

@JS()
@staticInterop
class Screen {}

extension ScreenExtension on Screen {
  external int get width;
  external int get height;
  external int get colorDepth;
}
