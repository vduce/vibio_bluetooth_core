//
//  AESTransfer.h
//  AES-iOS

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AESTransfer : NSObject

//bytes数组转成16进制的字符串
//The bytes array is converted to a hexadecimal string
+ (NSString *)bytesToString:(NSData *)aData;

//从字符串中取字节数组,然后再用base64进行转换
//An array of bytes is taken from a string and then base64 is used to convert it
+ (NSString *)stringToByte:(NSString *)stringValue;


@end

NS_ASSUME_NONNULL_END
