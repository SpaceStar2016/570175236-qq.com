//
//  SpaceByteConvert.h
//  进制工具
//
//  Created by Space Zhong on 2020/3/22.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpaceByteConvert : NSObject
+(void)test;
///十六进制转二进制字符
+(NSString *)hexStrFromBinStr:(NSString *)binary;
///二进制字符串转十六进制
+(NSString *)binStrFromHexStr:(NSString *)string;
///从十六进制转换成data
+ (NSData *)dataFromHexString:(NSString*)str;
///十六进制转十进制
+(NSString *)deciStrFromHexStr:(NSString *)hex;
///十进制转十六进制
//+(NSString *)hexStrFromDeciStr:(NSString *)deci;
///十进制转二进制
//+(NSString *)binStrFromDeciStr:(NSString *)deci;
///二进制转十进制
//+(NSString *)deciStrFromBinStr:(NSString *)bin;

@end

NS_ASSUME_NONNULL_END
