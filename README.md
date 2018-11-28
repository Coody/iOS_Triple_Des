# iOS_Triple_Des
ImplementTriple DES encrype and decrypt with objective-C in iOS.

# How to use

1. Set 3DES key with NSString

```
// key muse 6*4 = 24 bytes
[[TripleDESTool sharedInstance] setKey:@"111122223333444455556666"];
```

2. Encrypt with Triple DES

```
NSData *data = [@"test123" dataUsingEncoding:NSUTF8StringEncoding];
NSData *encryptData = [[TripleDESTool sharedInstance] encrpytWithData:data];
```
or
```
NSString *testString = @"test123";
NSData *encryptData = [[TripleDESTool sharedInstance] encrpytWithString:testString];
```

3. If u need Base64 NSData

```
NSData *base64Data = [[TripleDESTool sharedInstance] getBase64Data:encryptData]
```

4. Decrypt with Tripel DES

```
NSData *decryptData = [[TripleDESTool sharedInstance] decryptWithData:encryptData];
NSString *decryptString = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
```
or
```
NSString *decryptString = [[TripleDESTool sharedInstance] decryptToStringWithData:encryptData];
```

# License
[MIT](https://zh.wikipedia.org/wiki/MIT許可證) 請自由取用

