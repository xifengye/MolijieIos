//
//  NSData+AES256.h
//  Molijie
//
//  Created by yexifeng on 15/12/1.
//  Copyright © 2015年 moregood. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData(AES256)
-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;
@end