//
//  AESTransfer.m
//  AES-iOS
#import "AESTransfer.h"


@implementation AESTransfer

//bytes数组转成16进制的字符串
//The bytes array is converted to a hexadecimal string
+ (NSString *)bytesToString:(NSData *)aData{
    Byte *byte = (Byte *)[aData bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[aData length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",byte[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
//    NSLog(@"bytes 的16进制数为:%@",hexStr);
    return hexStr;
}


//从字符串中取字节数组,然后再用base64进行转换
//An array of bytes is taken from a string and then base64 is used to convert it
+(NSString*)stringToByte:(NSString*)stringValue {
    NSString *hexString=[[stringValue uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte bytes[16] = {0};
    int j=0;
    for(int i=0;i<[hexString length];i++) {
        int int_ch;
        unichar hex_char1 = [hexString characterAtIndex:i];
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0  Ascll value - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A  Ascll value - 65
        else
            return nil;
        i++;

        unichar hex_char2 = [hexString characterAtIndex:i];
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0  Ascll value - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A Ascll value - 65
        else
            return nil;

        int_ch = int_ch1+int_ch2;  ///Put the converted number into a Byte array
//        NSLog(@"int_ch=%d",int_ch);
        bytes[j] = int_ch;  ///Put the converted number into a Byte array
        j++;

    }
    //Base64 encryption
    NSData *byteData = [[NSData alloc] initWithBytes:bytes length:16];
    NSData *base64Data = [byteData base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
//    NSLog(@"++++++++++++base64+++++%@",baseString);
    return baseString;
}




@end
