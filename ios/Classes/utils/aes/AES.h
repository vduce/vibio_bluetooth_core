//
//  AES.h
//  Encryped

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

NS_ASSUME_NONNULL_BEGIN

@interface AES : NSObject

//AES encryption
+ (NSString*)encryptionEncodingStr:(NSString *)originStr key:(NSString*)key;
+ (NSString*)encryptionType:(CCAlgorithm)encryptionType encodingStr:(NSString *)originStr key:(NSString*)key;


//AES decryption
+ (NSString *)decryptionDecryptionStr:(NSString *)baseStr key:(NSString*)key;
+ (NSString *)decryptionType:(CCAlgorithm)decryptionType decryptionStr:(NSString *)baseStr key:(NSString*)key;




@end

NS_ASSUME_NONNULL_END
