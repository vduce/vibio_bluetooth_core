//
//  NSData+Byte.h
//  Runner

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Byte)

//isEmpty
+ (BOOL)isEmpty:(id)object;

//stringTobytes
+ (NSData *)stringTobytes:(NSString *)stringValue;

//bytesToString
+ (NSString *)bytesToString:(NSData *)data;


@end

NS_ASSUME_NONNULL_END
