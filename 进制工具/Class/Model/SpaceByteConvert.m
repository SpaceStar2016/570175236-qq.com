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
+ (NSData *)dataFromHexString:(NSString*)str {
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
+(NSString *)binStrFromHexStr:(NSString *)string{
    
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

+(NSString *)hexStrFromBinStr:(NSString *)binary
{
    NSUInteger binLen = binary.length;
    const char *sSrc = binary.UTF8String;
    int times = (int)binLen / 4;
    int x = 0;
    NSMutableString * mString = [NSMutableString string];
    for (int i = 0; i < times; i++) {
        x=8*(sSrc[i*4]-'0');
        x+=4*(sSrc[i*4+1]-'0');
        x+=2*(sSrc[i*4+2]-'0');
        x+=sSrc[i*4+3]-'0';
        NSString * str = [NSString stringWithFormat:@"%1x",x];
        [mString appendString:str];
    }
    return mString;
}

+(NSString *)deciStrFromHexStr:(NSString *)hex
{
    char * s = (char *)hex.UTF8String;
    int i = 0,t = 0;             //t记录临时加的数
    long long sum =0;
    for(;s[i];i++)
    {
        if(s[i]>='0'&&s[i]<='9')
        t=s[i]-'0';       //当字符是0~9时保持原数不变
        if(s[i]>='a'&&s[i]<='z')
        t=s[i]-'a'+10;
        if(s[i]>='A'&&s[i]<='Z')
        t=s[i]-'A'+10;
        sum=sum*16+t;
    }
    return [NSString stringWithFormat:@"%lld",sum];
}

+(void)test
{
//    NSData * data = [NSData da]
//    NSString * str = [self hexStrFromBinStr:@"0x0000111101011111111111111100101011011010101001"];
//    NSLog(@"----%@",str);
    NSString * str = @"111a1111111111111111111111111111111";
//    long value = fun(str.UTF8String);
//    int longStr =  str.longLongValue;
//
//
    NSString * ss = [self deciStrFromHexStr:str];
     NSLog(@"---");
    unsigned int he = 0x22;
    long long re=0;   // 保存转换为10进制的结果
    int k=16;   // 16进制
    int n=1;    // 位权
//    scanf("%d", &he);  // 接收用户输入的16进制数，不含0x前缀
    while(he != 0)
    {
        re += (he%10)*n;  // 取出各位位码值，并乘以对应的位权值
        he /= 10;   // 去掉16进制数的最低位，次低位变为最低位
        n *= k;     // 位权乘以16
    }
    printf("ll%d",re); // 输出转换后的结果

}


///十进制转十六进制
//+(NSString *)hexStrFromDeciStr:(NSString *)deci
//{
//    return deci;
//}

///十进制转二进制
//+(NSString *)binStrFromDeciStr:(NSString *)deci
//{
//    NSString * hexStr =  [self hexStrFromDeciStr:deci];
//    NSString * binStr =[self binStrFromHexStr:hexStr];
//    return binStr;
//}

///二进制转十进制
//+(NSString *)deciStrFromBinStr:(NSString *)bin
//{
//    NSString * hexStr = [self hexStrFromBinStr:bin];
//    NSString * deciStr = [self decisStrFromHexStr:hexStr];
//    return deciStr;
//}

@end
