//
//  Random.m
//  AES-iOS
#import "Random.h"

@implementation Random

/**
 生成随机字符串，必须由数字或字母组成
 Generates a random string that must consist of numbers or letters
 @param len number  需要的个数 Number needed
 @return Generated string
 */
+ (NSString *)randomString:(NSInteger)len {
    
    char ch[len];
        for (int index=0; index<len; index++) {
            
            int num = arc4random_uniform(75)+48;
            if (num>57 && num<65) { num = num%57+48; }
            else if (num>90 && num<97) { num = num%90+65; }
            ch[index] = num;
        }
        
    return [[NSString alloc] initWithBytes:ch length:len encoding:NSUTF8StringEncoding];
}


@end
