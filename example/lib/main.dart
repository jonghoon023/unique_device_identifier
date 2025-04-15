import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:unique_device_identifier/unique_device_identifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _uniqueIdentifier = 'Unknown';
  final _uniqueDeviceIdentifierPlugin = UniqueDeviceIdentifier();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String uniqueIdentifier;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      uniqueIdentifier =
          await _uniqueDeviceIdentifierPlugin.getUniqueIdentifier() ?? 'Unknown unique identifier';
    } on PlatformException {
      uniqueIdentifier = 'Failed to get unique identifier.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() => _uniqueIdentifier = uniqueIdentifier);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Unique Identifier: $_uniqueIdentifier'),
        ),
      ),
    );
  }
}
