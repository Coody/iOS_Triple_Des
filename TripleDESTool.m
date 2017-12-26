//
//  TripleDESTool.m
//

#import "TripleDESTool.h"

// for Triple DES
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface TripleDESTool()
{
    const void *_encryptKeyValue;
}
@end

@implementation TripleDESTool

+ (instancetype)sharedInstance
{
    static TripleDESTool *instanceObj= nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        if ( instanceObj == nil )
        {
            instanceObj = [[self alloc] init];
        }
    });
    return instanceObj;
}

-(instancetype)init{
    self = [super init];
    if( self ){
    }
    return self;
}

-(void) setKey:(NSString *) keyString
{
    NSData* myKeyValue = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    _encryptKeyValue = [myKeyValue bytes];
}

#pragma marl - Public Methods
#pragma mark : Send NSData and receive NSData
-(NSData *)encrpytWithData:(NSData *)originalData{
    NSData *encryptData = nil;
    if( originalData == nil ){
        NSLog(@"Original Data is nil!");
    }
    else{
        
        NSMutableData *fillData = [NSMutableData dataWithData:originalData];
        
        size_t bufferSize = originalData.length + kCCBlockSize3DES;
        NSMutableData *cypherData = [NSMutableData dataWithLength:bufferSize];
        size_t movedBytes = 0;
        
        CCCryptorStatus ccStatus;
        ccStatus = CCCrypt(kCCEncrypt,
                           kCCAlgorithm3DES,
                           kCCOptionPKCS7Padding,/* 如果用 kCCOptionECBMode 則不是 8 byte 會有問題，詳細請看 https://stackoverflow.com/questions/9911899/encryption-in-iphone-with-3des */
                           _encryptKeyValue,
                           kCCKeySize3DES,
                           NULL,
                           originalData.bytes,
                           originalData.length,
                           cypherData.mutableBytes,
                           cypherData.length,
                           &movedBytes);
        
        cypherData.length = movedBytes;
        
        if( ccStatus == kCCSuccess ){
            encryptData = [cypherData copy];
        }
        else{
            NSLog(@"Encrypto Fail!!");
        }
    }
    return encryptData;
}

-(NSData *)decryptWithData:(NSData *)encryptData{
    NSData *decryptData = nil;
    if( encryptData == nil ){
        NSLog(@"decrypt Data is nil!");
    }
    else{
        
        size_t bufferSize = encryptData.length + kCCBlockSize3DES;
        NSMutableData *cypherData = [NSMutableData dataWithLength:bufferSize];
        size_t movedBytes = 0;
        
        CCCryptorStatus ccStatus;
        ccStatus = CCCrypt(kCCDecrypt,
                           kCCAlgorithm3DES,
                           kCCOptionPKCS7Padding,
                           _encryptKeyValue,
                           kCCKeySize3DES,
                           NULL,
                           encryptData.bytes,
                           encryptData.length,
                           cypherData.mutableBytes,
                           cypherData.length,
                           &movedBytes);
        
        cypherData.length = movedBytes;
        
        if( ccStatus == kCCSuccess ){
            decryptData = [cypherData copy];
        }
        else{
            NSLog(@"Decrypto Fail!!");
        }
    }
    return decryptData;
}

#pragma nark : Send NSString and reveice NSString
-(NSData *)encrpytWithString:(NSString *)originalString{
    NSData *originalData = [originalString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData = [self encrpytWithData:originalData];
    return encryptData;
}

-(NSString *)decryptToStringWithData:(NSData *)encryptData{
    NSData *decryptData = [self decryptWithData:encryptData];
    NSString *decryptString = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
    return decryptString;
}

#pragma mark - Create Key
-(NSData*)create3DesKey
{
    NSMutableData *mData = [[NSMutableData alloc] init];
    NSMutableData *mAuxData = [[NSMutableData alloc] init];
    
    for(int i = 0; i < 16; ++i)
    {
        u_int32_t aux = arc4random() % 255;
        
        [mData appendBytes:&aux length:1];
        
        if(i < 8)
        {
            [mAuxData appendBytes:&aux length:1];
        }
    }
    
    [mData appendData:mAuxData];
    
    return mData;
}

@end
