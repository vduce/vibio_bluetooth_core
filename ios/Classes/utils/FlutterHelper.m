//
//  FlutterHelper.m
//  Runner
#import "FlutterHelper.h"
#import "AESHeader.h"
#import "AES.h"
#import "Random.h"
#import "NSData+SHA.h"
#import "NSData+Byte.h"


@implementation FlutterHelper


//sha256
//Get SHA-256 encrypted password
+ (NSString *)sha256:(NSString *)plainText{
    return [[plainText dataUsingEncoding:NSUTF8StringEncoding] sha256String];
}

//Encrypt plaintext string with AES
+ (NSString *)encryptionCode:(NSString *)plainText{
    return [AES encryptionEncodingStr:plainText key:AESKey];;
}

//Decrypt the plaintext string with AES
+ (NSString *)decodeCode:(NSString *)plainText{
    return [AES decryptionDecryptionStr:plainText key:AESKey];;
}

/*Certification rules
 1.Send authentication information (10 random digits or letters to sha-256)
 2.Ble returns a value to check whether it is correct
 3.Send string from BLE (sha-256 value)
 4.Ble to reply OK
 */

// first step data
//Parameters for the first step of obtaining certification
+ (NSDictionary *)fhAuthFirstStepParams{
    NSString *pref = AuthKey;
    NSString *authMsg = [Random randomString:AuthRandomLength];
    NSString *total = [NSString stringWithFormat:@"%@%@%@",pref,authMsg,@";"];
    NSString *aesAuthMsgString = [AES encryptionEncodingStr:total key:AESKey];
    NSLog(@"%@",authMsg);
    NSLog(@"%@",total);
    NSLog(@"%@",aesAuthMsgString);
    NSLog(@"SHA256: %@",[[aesAuthMsgString dataUsingEncoding:NSUTF8StringEncoding] sha256String]);
    return @{@"authMsg":authMsg,@"authAesMag":aesAuthMsgString};
}



// second step data
// Parameters for the second step of obtaining certification
+ (NSDictionary *)fhAuthSecondStepParams:(NSString *)params{
    NSString *pref = AuthKey;
    NSString *shaString = [[params dataUsingEncoding:NSUTF8StringEncoding] sha256String];
    NSString *last = [shaString substringToIndex:4];
    NSString *total = [NSString stringWithFormat:@"%@%@%@",pref,last,@";"];
    NSString *aesAuthMsg = [AES encryptionEncodingStr:total key:AESKey];
    NSLog(@"%@",last);
    NSLog(@"%@",total);
    NSLog(@"%@",aesAuthMsg);
    return @{@"authAesMag":aesAuthMsg};
}

//stringTobytes
+ (NSData *)hex2byte:(NSString *)stringValue{
    return [NSData stringTobytes:stringValue];
}

//byte2hex and Decode pass
+ (NSString *)byte2hex:(NSData *)data {
    NSString *pass = [NSData bytesToString:data];
    NSLog(@"%@",pass);
    return [self decodeCode:pass];
}


@end
