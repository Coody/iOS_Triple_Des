//
//  main.m
//  TripleDesProject
//
//  Created by CoodyChou on 2017/12/22.
//  Copyright © 2017年 CoodyChou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TripleDESTool.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Test Triple DES");
        
        [[TripleDESTool sharedInstance] setKey:@"testtest"];
        
        // NSData -> NSData
        {
            NSData *data = [@"test" dataUsingEncoding:NSUTF8StringEncoding];
            NSData *encryptData = [[TripleDESTool sharedInstance] encrpytWithData:data];
            
            NSString* newStr = [[NSString alloc] initWithData:[[TripleDESTool sharedInstance] getBase64Data:encryptData] encoding:NSUTF8StringEncoding];
            NSLog(@"EncrpytData = %@" , newStr);
            
            NSLog(@"Encrpyt base64 Data = %@" , [[TripleDESTool sharedInstance] getBase64Data:encryptData] );
            
            NSData *decryptData = [[TripleDESTool sharedInstance] decryptWithData:encryptData];
            NSString *decryptString = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
            NSLog(@"DecryptString = %@" , decryptString);
        }
        
//        // NSString -> NSData && NSData -> NSString
//        {
//            NSString *testString = @"Test Triple DES project!(NSString -> NSData)";
//            NSData *encryptData = [[TripleDESTool sharedInstance] encrpytWithString:testString];
//            NSLog(@"EncrpytData = %@" , encryptData);
//
//            NSString *decryptString = [[TripleDESTool sharedInstance] decryptToStringWithData:encryptData];
//            NSLog(@"DecryptString = %@" , decryptString);
//        }
    }
    return 0;
}
