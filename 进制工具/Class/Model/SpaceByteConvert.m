//
//  SpaceByteConvert.m
//  进制工具
//
//  Created by Space Zhong on 2020/3/22.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "SpaceByteConvert.h"

@implementation SpaceByteConvert

//十六进制数据字符串转换为data
+ (NSData *)hexStringToData:(NSString*)str {
    if (!self || str.length == 0) {
        return nil;
    }
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if (str.length % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < str.length; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

//16进制字符转二进制字符
+(NSString *)binaryWithHexadecimal:(NSString *)string{
    
    long a = strtoul(string.UTF8String, NULL, 16);
    NSMutableString *binary = [[NSMutableString alloc] init];
    while (a/2 !=0) {
        [binary insertString:[NSString stringWithFormat:@"%ld",a%2] atIndex:0];
        a = a/2;
    }
    
    [binary insertString:[NSString stringWithFormat:@"%ld",a%2] atIndex:0];
    
    //不够4位的高位补0
    while (binary.length%4 !=0) {
        [binary insertString:@"0" atIndex:0];
    }
    return binary;
}

+(void)test
{
//    NSData * data = [NSData da]
    NSString * str = @"a";
    NSData * data = [self hexStringToData:str];
    NSString * binaryStr = [self binaryWithHexadecimal:str];
    NSLog(@"%@",data);
}

@end
