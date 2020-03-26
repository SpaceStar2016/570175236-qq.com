//
//  NSColor+Hex.h
//  NvSellerShow
//
//  Created by Meicam on 2017/1/10.
//  Copyright © 2017年 Meicam. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define RGBA_COLOR(R, G, B, A) [NSColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [NSColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

#define NSColorRGBA(_red, _green, _blue, _alpha) [NSColor colorWithRed:((_red)/255.0) \
green:((_green)/255.0) blue:((_blue)/255.0) alpha:(_alpha)]

#define NSColorRGB(red, green, blue) NSColorRGBA(red, green, blue, 1)

#define NSColorHexRGB(rgbString) [NSColor colorWithHexRGB:(rgbString)]

#define NSColorHexRGBA(rgbaString) [NSColor colorWithHexRGBA:(rgbaString)]

@interface NSColor (Hex)

+ (NSColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (NSColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (instancetype)colorWithHexRGBA:(NSString *)rgba;

+ (instancetype)colorWithHexRGB:(NSString *)rgb;

+ (instancetype)colorWithHexARGB:(NSString *)argb;

+ (NSColor *)randomColor;

+ (NSColor *)randomColorWithAlpha:(CGFloat)alpha;

+ (NSString *)hexFromRGBAColorR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;

+ (NSString *)hexFromNSColor: (NSColor*) color;

@end
