#import "VibioBluetoothCorePlugin.h"
#import "FlutterHelper.h"

@implementation VibioBluetoothCorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"vibio_bluetooth_core"
                                     binaryMessenger:[registrar messenger]];
    VibioBluetoothCorePlugin* instance = [[VibioBluetoothCorePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if([@"fhSHA256" isEqualToString:call.method]){
        //Get SHA-256 encrypted password
        NSString *parmas = call.arguments[@"params"];
        NSString *sha256 = [FlutterHelper sha256:parmas];
        result(sha256);
    } else if([@"fhAuthFirstStepParams" isEqualToString:call.method]){
        //Parameters for the first step of obtaining certification
        NSDictionary *firstStepParams = [FlutterHelper fhAuthFirstStepParams];
        result(firstStepParams);
    } else if([@"fhAuthSecondStepParams" isEqualToString:call.method]){
        //Parameters for the second step of obtaining certification
        NSString *parmas = call.arguments[@"params"];
        NSDictionary *secondStepParams = [FlutterHelper fhAuthSecondStepParams:parmas];
        result(secondStepParams);
    } else if([@"aesEncryptionCode" isEqualToString:call.method]){
        //Encrypt plaintext string with AES
        NSString *parmas = call.arguments[@"params"];
        NSString *commandCode = [FlutterHelper encryptionCode:parmas];
        result(commandCode);
    } else if([@"aesDecodeCode" isEqualToString:call.method]){
        //Decrypt the plaintext string with AES
        NSString *parmas = call.arguments[@"params"];
        NSString *commandCode = [FlutterHelper decodeCode:parmas];
        result(commandCode);
    } else if([@"byte2hex" isEqualToString:call.method]){
        //byte2hex and Decrypt pass
        FlutterStandardTypedData *data = call.arguments[@"params"];
        NSString *returnMsg = [FlutterHelper byte2hex:data.data];
        result(returnMsg);
    } else if([@"hex2byte" isEqualToString:call.method]){
        //hexadecimal string to Byte array
        NSString *hex = call.arguments[@"params"];
        NSData *bytes = [FlutterHelper hex2byte:hex];
        result(bytes);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
