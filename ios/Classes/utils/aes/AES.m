//
//  AES.m
//  Encryped
//
#import "AES.h"
#import "AESTransfer.h"


@implementation AES


//AES EBC encryption
+ (NSString*)encryptionEncodingStr:(NSString *)originStr key:(NSString*)key{
    CCAlgorithm cryptionType = kCCAlgorithmAES128;
    /*encryption
     1.encryption
     2.Cipher capitalized
     */
    NSString * enStr = [AES encryptionType:cryptionType encodingStr:originStr key:key];
    NSString * enUpperStr = [enStr uppercaseString];
    return enUpperStr;
}
//AES EBC encryption
+ (NSString*)encryptionType:(CCAlgorithm)encryptionType encodingStr:(NSString *)originStr key:(NSString*)key
{
    // 1, Convert a string to data
    NSData * baseData = [originStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    size_t dataOutOffset = 0;
    NSUInteger dataLength = baseData.length + 10 + [key dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES].length;
    unsigned char buffer[dataLength];
    memset(buffer, 0,sizeof(char));
    
   CCCryptorStatus cryptorStatus = CCCrypt(
                                   kCCEncrypt,          // Decrypt or decrypt
                                   encryptionType,      // Encryption method  DES, 3DES, AES
                                   kCCOptionPKCS7Padding | kCCOptionECBMode,
                                   [key UTF8String],    //Convert key to C string
                                   kCCKeySizeAES128,     //The size of the secret key is fixed: kCCKeySizeDES,kCCKeySize3DES
                                   nil,
                                   [baseData bytes],
                                   [baseData length],
                                   buffer,              // Note the size of the buffer receiving encryption
                                   dataLength,          //
                                   &dataOutOffset       //
                                   );
    
    NSString * encoding=@"";
    NSString * encoding2=@"";
    if (cryptorStatus == kCCSuccess) {
        NSData * data = [NSData dataWithBytes:buffer length:dataOutOffset];
        encoding = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        encoding2 = [AESTransfer bytesToString:data];
        
        NSLog(@"An encrypted string：[%@]",encoding2);
    }else
        NSLog(@"Encryption failed！%d",cryptorStatus);
    
    return encoding2;
}


//AES EBC decryption
+ (NSString *)decryptionDecryptionStr:(NSString *)baseStr key:(NSString*)key{
    CCAlgorithm cryptionType = kCCAlgorithmAES128;
    
    
    /*decryption
     1.Cipher lowercase
     2.decryption
     */
    NSString * decryptionStr = [baseStr lowercaseString];
    NSString * decryptionString =[AES decryptionType:cryptionType decryptionStr:decryptionStr key:key];
    return decryptionString;
}
//AES EBC decryption
+ (NSString *)decryptionType:(CCAlgorithm)decryptionType decryptionStr:(NSString *)baseStr key:(NSString*)key
{
    NSString *baseByteStr = [AESTransfer stringToByte:baseStr];
    
    //Because the encrypted data is displayed in Base64, we will decrypt baseStr into data in Base64 first.
    NSData * baseData =  [[NSData alloc]initWithBase64EncodedString:baseByteStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSUInteger dataLength = baseData.length +10+[key dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES].length;
    unsigned char buffer[dataLength];
    memset(buffer, 0,sizeof(char));
    size_t dataOffset = 0;
    
    CCCryptorStatus status = CCCrypt(kCCDecrypt,
                                     decryptionType,
                                     kCCOptionPKCS7Padding|kCCOptionECBMode,
                                     [key UTF8String],
                                     kCCKeySizeAES128,
                                     nil,
                                     [baseData bytes],
                                     [baseData length],
                                     buffer,
                                     dataLength,
                                     &dataOffset );
    NSString * decodingStr =nil;
    if (status == 0) {
        NSData * data = [[NSData alloc]initWithBytes:buffer length:dataOffset];
        decodingStr =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Decrypted string：[%@]", decodingStr);
    }
    else
        NSLog(@"Decryption failure；");
    return decodingStr;
}



@end


