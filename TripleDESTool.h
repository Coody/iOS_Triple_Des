//
//  TripleDESTool.h
//

#import <Foundation/Foundation.h>

@interface TripleDESTool : NSObject

+(instancetype)sharedInstance;

-(void)setKey:(NSString *) keyString;

#pragma mark - Send NSData and receive NSData
-(NSData *)encrpytWithData:(NSData *)originalData;

-(NSData *)decryptWithData:(NSData *)encryptData;

#pragma nark -
/**
 * @brief  - 將 NSString 加密成 NSData
 */
-(NSData *)encrpytWithString:(NSString *)originalString;

/**
 * @brief  - 將 NSData 解密成 NSString
 */
-(NSString *)decryptToStringWithData:(NSData *)encryptData;

/**
 * @brief - Create Triple DES Key
 */
-(NSData*)create3DesKey;

@end
