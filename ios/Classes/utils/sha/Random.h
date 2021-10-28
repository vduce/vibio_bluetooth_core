//
//  Random.h
//  AES-iOS
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Random : NSObject

/**
 生成随机字符串，必须由数字或字母组成
 Generates a random string that must consist of numbers or letters
 @param len number  需要的个数 Number needed
 @return Generated string
 */
+ (NSString *)randomString:(NSInteger)len;


@end

NS_ASSUME_NONNULL_END
