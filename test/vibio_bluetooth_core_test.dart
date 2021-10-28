import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vibio_bluetooth_core/vibio_bluetooth_core.dart';

void main() {
  const MethodChannel channel = MethodChannel('vibio_bluetooth_core');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await VibioBluetoothCore.platformVersion, '42');
  });
}
