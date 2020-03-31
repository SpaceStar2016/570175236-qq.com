//
//  En_Const.h
//  EnDICTATION
//
//  Created by Space Zhong on 2019/4/20.
//  Copyright © 2019年 Space Zhong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//weakSelf
#define WEAKSELF __weak typeof(self) weakSelf = self

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height


#define SPSColor(r,g,b)  [NSColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define SPSRandomColor   SPSColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define SPSColorMaker(r, g, b, a) [NSColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define NumTextHeight (30)
#define IndexTextHeight (10)
#define NumTextWidth (15)
#define NumGap (2)
#define IndexTextFont (10)

NS_ASSUME_NONNULL_END
