//
//  DashBoardSubItem.m
//  进制工具
//
//  Created by aqara on 2020/4/3.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "DashBoardSubItem.h"
#import "DashBoardSubCModel.h"
@interface DashBoardSubItem()
@property(nonatomic,strong)NSTextField * numberText;
@property(nonatomic,strong)NSTextField * indexText;
@end

@implementation DashBoardSubItem


-(instancetype)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect]) {
        
        self.wantsLayer = YES;
//        self.layer.backgroundColor = [NSColor redColor].CGColor;
        self.indexText = [[NSTextField alloc] init];
        self.indexText.wantsLayer = YES;
        self.indexText.textColor = [NSColor blackColor];
//        self.indexText.layer.backgroundColor = SPSRandomColor.CGColor;
        [self.indexText setAlignment:NSTextAlignmentCenter];
        [self addSubview:self.indexText];
        
        self.numberText = [[NSTextField alloc] init];
        self.numberText.wantsLayer = YES;
        self.numberText.textColor = [NSColor blackColor];
//        self.numberText.layer.backgroundColor = SPSRandomColor.CGColor;
        [self.numberText setAlignment:NSTextAlignmentCenter];
        [self addSubview:self.numberText];
    }
    return self;
}

-(void)setCModel:(DashBoardSubCModel *)cModel
{
    _cModel = cModel;
    NSRect frameRect = self.frame;
    CGFloat numScale = 0.0;
    if (cModel.isExtend) {
        numScale = 0.8;
        [self.numberText setFont:[NSFont systemFontOfSize:DB_SMALL_NUMFONT]];
        self.numberText.stringValue = cModel.numberStr;
        self.indexText.stringValue = cModel.index;
        [self.indexText setFont:[NSFont systemFontOfSize:DB_SMALL_INDEXFONT]];
        
    }else{
        numScale = 1.0;
        self.numberText.stringValue = cModel.numberStr;
        [self.numberText setFont:[NSFont systemFontOfSize:DB_BIG_NUMFONT]];
    }
    
    CGFloat viewHeight = frameRect.size.height;
    CGFloat indexScale = 1 - numScale;
    CGFloat numHeight = viewHeight * numScale;
    self.indexText.frame = CGRectMake(0,0,frameRect.size.width,viewHeight * indexScale);
    self.numberText.frame = CGRectMake(0,CGRectGetMaxY(self.indexText.frame),frameRect.size.width,numHeight);
    
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
}


@end
