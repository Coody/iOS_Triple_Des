//
//  main.m
//  TripleDesProject
//
//  Created by CoodyChou on 2017/12/22.
//  Copyright © 2017年 CoodyChou. All rights reserved.
//
//  Online encrypt tool:
//  https://www.tools4noobs.com/online_tools/encrypt/
//  Online decrypt tool:
//  https://www.tools4noobs.com/online_tools/decrypt/

#import <Foundation/Foundation.h>
#import "TripleDESTool.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Test Triple DES");
        
        if([[TripleDESTool sharedInstance] setKey:@"testtesttesttesttesttest"])
        // NSData -> NSData
        {

            NSString *testString = @"testtest";
            NSData *data = [testString dataUsingEncoding:NSUTF8StringEncoding];
            NSData *encryptData = [[TripleDESTool sharedInstance] encrpytWithData:data];
            NSLog(@"EncrpytData = %@" , encryptData);
            
            NSLog(@"EncrpytData to base64 Data = %@" , [[TripleDESTool sharedInstance] getBase64Data:encryptData] );
            
            NSString* newStr = [[NSString alloc] initWithData:[[TripleDESTool sharedInstance] getBase64Data:encryptData] encoding:NSUTF8StringEncoding];
            NSLog(@"EncrpytData to Base64 String = %@" , newStr);
            
            NSData * base64StrToData = [[TripleDESTool sharedInstance] getBase64StringToData:newStr];
            NSLog(@"Encrpyt base64 String to EncrpytData= %@" , base64StrToData);
            
            NSData *decryptData = [[TripleDESTool sharedInstance] decryptWithData:base64StrToData];
            
            NSString *decryptString = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
            NSLog(@"DecryptString = %@" , decryptString);
        }else
        {
            NSLog(@"the Key an invalid size");
        }
        
        // NSString -> NSData && NSData -> NSString
        {
            NSString *testString = @"testtest";
            NSData *encryptData = [[TripleDESTool sharedInstance] encrpytWithString:testString];
            NSLog(@"EncrpytData = %@" , encryptData);

            NSString *decryptString = [[TripleDESTool sharedInstance] decryptToStringWithData:encryptData];
            NSLog(@"DecryptString = %@" , decryptString);
        }
    }
    return 0;
}
