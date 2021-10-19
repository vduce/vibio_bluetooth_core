import 'dart:async';
import 'package:flutter/services.dart';

class VibioBluetoothCore {
  static const MethodChannel _channel =
  const MethodChannel('vibio_bluetooth_core');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  //sha256
  //Get SHA-256 encrypted password
  static Future<String?> sha256(String plainText) async {
    final String? sha256Value =
    await _channel.invokeMethod('fhSHA256', {"params": plainText});
    return sha256Value;
  }

  //firstStep
  // Parameters for the first step of obtaining certification
  static Future<Map?> firstStepParmas() async {
    final Map? firstStepMap =
    await _channel.invokeMethod('fhAuthFirstStepParmas');
    return firstStepMap;
  }

  //secondStep
  // Parameters for the second step of obtaining certification
  static Future<Map?> secondStepParmas(String params) async {
    final Map? secondStepMap = await _channel
        .invokeMethod('fhAuthSecondStepParmas', {"params": params});
    return secondStepMap;
  }

  //Encrypt plaintext string with AES
  static Future<String?> encryptionCode(String plainText) async {
    final String? commandCodeValue =
    await _channel.invokeMethod('aesEncryptionCode', {"params": plainText});
    return commandCodeValue;
  }

  //Decrypt the plaintext string with AES
  static Future<String?> decodeCode(String plainText) async {
    final String? decodeCode =
    await _channel.invokeMethod('aesDecodeCode', {"params": plainText});
    return decodeCode;
  }

  //byte2hex and Decrypt pass
  static Future<String?> byte2hex(List<int> value) async {
    final String? decodeCode =
    await _channel.invokeMethod('byte2hex', {"params": value});
    print(decodeCode);
    return decodeCode;
  }

  //hexadecimal string to Byte array
  static Future<List<int>> hex2byte(String hexString) async {
    final List<int> bytes =
    await _channel.invokeMethod('hex2byte', {"params": hexString});
    print(bytes);
    return bytes;
  }
}
