//
//  TripleDESTool.m
//

#import "TripleDESTool.h"

//// for Triple DES
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
    // 轉成資料
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
        
        size_t bufferSize = originalData.length + kCCBlockSize3DES;
        NSMutableData *cypherData = [NSMutableData dataWithLength:bufferSize];
        size_t movedBytes = 0;
        
        CCCryptorStatus ccStatus;
        ccStatus = CCCrypt(kCCDecrypt,
                           kCCAlgorithm3DES,
                           kCCOptionECBMode,
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
        ccStatus = CCCrypt(kCCEncrypt,
                           kCCAlgorithm3DES,
                           kCCOptionECBMode,
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

-(NSString *)decryptWithNSString:(NSData *)encryptData{
    NSData *decryptData = [self decryptWithData:encryptData];
    NSString *decryptString = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
    return decryptString;
}

@end
