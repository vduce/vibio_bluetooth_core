//
//  FlutterHelper.h
//  Runner
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>


NS_ASSUME_NONNULL_BEGIN

@interface FlutterHelper : NSObject

//sha256
//Get SHA-256 encrypted password
+ (NSString *)sha256:(NSString *)plainText;

//Encrypt plaintext string with AES
+ (NSString *)encryptionCode:(NSString *)plainText;

//Decrypt the plaintext string with AES
+ (NSString *)decodeCode:(NSString *)plainText;


// first step
//Parameters for the first step of obtaining certification
+ (NSDictionary *)fhAuthFirstStepParams;

// second step
// Parameters for the second step of obtaining certification
+ (NSDictionary *)fhAuthSecondStepParams:(NSString *)parmas;


//hex2byte
+ (NSData *)hex2byte:(NSString *)stringValue;

//bytesToString and Decode pass
+ (NSString *)byte2hex:(NSData *)data;



@end

NS_ASSUME_NONNULL_END
