//
//  NSData+SHA.h
//  AES-iOS
#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonCrypto.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (SHA)
- (NSString *)sha1String;
- (NSString *)sha224String;
- (NSString *)sha256String;
- (NSString *)sha384String;
- (NSString *)sha512String;

@end

NS_ASSUME_NONNULL_END
