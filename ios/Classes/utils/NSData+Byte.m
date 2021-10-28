//
//  NSData+Byte.m
//  Runner

#import "NSData+Byte.h"

@implementation NSData (Byte)

+ (BOOL)isEmpty:(id)object{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        return [object isEqualToString:@""];
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [object isEqualToNumber:@(0)];
    }
    return NO;
}

+ (NSData *)stringTobytes:(NSString *)stringValue{
    //以及初始化的Byte数组
    //And the initialized Byte array
    Byte bt[16] = {0};
    for (int i =0; i < stringValue.length; i+=2) {
        NSString *strByte = [stringValue substringWithRange:NSMakeRange(i,2)];
        unsigned red = strtoul([strByte UTF8String],0,16);
        Byte b =  (Byte) ((0xff & red) );//( Byte) 0xff&iByte;
        bt[i/2+0] = b;
    }
    NSData *adata3 = [[NSData alloc] initWithBytes:bt length:16];
    return adata3;
}

+ (NSString *)bytesToString:(NSData *)data{
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数 Hexadecimal number
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    NSLog(@"bytes 的16进制数为:%@",hexStr);
    return hexStr;
}

@end
