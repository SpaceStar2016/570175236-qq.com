//
//  DashBoardCInnerView.m
//  进制工具
//
//  Created by Space Zhong on 2020/3/22.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "DashBoardCInnerView.h"

@implementation DashBoardCInnerView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)setFrame:(NSRect)frame
{
    [super setFrame:frame];
    NSLog(@"----%@",NSStringFromRect(frame));
}

@end
