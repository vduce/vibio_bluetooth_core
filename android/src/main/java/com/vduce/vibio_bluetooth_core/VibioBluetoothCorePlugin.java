package com.vduce.vibio_bluetooth_core;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.vduce.vibio_bluetooth_core.utils.FlutterHelper;
import java.util.Map;
import java.security.NoSuchAlgorithmException;

/** VibioBluetoothCorePlugin */
public class VibioBluetoothCorePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "vibio_bluetooth_core");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    //Get SHA-256 encrypted password
    switch (call.method) {
      case "fhSHA256": {
        String params = call.argument("params");
        try {
          assert params != null;
          String sha256 = FlutterHelper.fhSHA256(params);
          result.success(sha256);
        } catch (NoSuchAlgorithmException e) {
          e.printStackTrace();
          result.error("SHA ERROR", "SHA error", null);
        }
        break;
      }
      case "fhAuthFirstStepParmas":
        //Parameters for the first step of obtaining certification
        Map<String, String> firstStepParmas = FlutterHelper.fhAuthFirstStepParmas();
        result.success(firstStepParmas);
        break;
      case "fhAuthSecondStepParmas": {
        //Parameters for the second step of obtaining certification
        String params = call.argument("params");
        Map<String, String> secondStepParmas = FlutterHelper.fhAuthSecondStepParmas(params);
        result.success(secondStepParmas);
        break;
      }
      case "aesEncryptionCode": {
        //Encrypt plaintext string with AES
        String params = call.argument("params");
        String CommandCode = FlutterHelper.aesCommandCode(params);
        result.success(CommandCode);
        break;
      }
      case "aesDecodeCode": {
        //Decrypt the plaintext string with AES
        String params = call.argument("params");
        String CommandCode = FlutterHelper.aesDecodeCode(params);
        result.success(CommandCode);
        break;
      }
      case "byte2hex": {
        //Byte array to hexadecimal string and Decrypt pass
        byte[] params = call.argument("params");
        String resultMsg = FlutterHelper.byte2hex(params);
        result.success(resultMsg);
        break;
      }
      case "hex2byte": {
        //hexadecimal string to Byte array
        String params = call.argument("params");
        byte[] returnBytes = FlutterHelper.hex2byte(params);
        result.success(returnBytes);
        break;
      }
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;

      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
