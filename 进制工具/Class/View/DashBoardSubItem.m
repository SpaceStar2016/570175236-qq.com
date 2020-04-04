//
//  DashBoardSubItem.m
//  进制工具
//
//  Created by aqara on 2020/4/3.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "DashBoardSubItem.h"
#import "DashBoardSubCModel.h"
#import "DBViewModel.h"
@interface DashBoardSubItem()
@property(nonatomic,strong)NSTextField * numberText;
@property(nonatomic,strong)NSTextField * indexText;
@property(nonatomic,strong)DBViewModel * viewModel;
@end

@implementation DashBoardSubItem


-(instancetype)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect]) {
        self.viewModel = [DBViewModel viewModel];
        self.wantsLayer = YES;
//        self.layer.backgroundColor = [NSColor redColor].CGColor;
        self.indexText = [[NSTextField alloc] init];
        self.indexText.wantsLayer = YES;
        self.indexText.textColor = [NSColor blackColor];
        self.indexText.layer.backgroundColor = SPSRandomColor.CGColor;
        self.indexText.editable = NO;
        [self.indexText setAlignment:NSTextAlignmentCenter];
        [self addSubview:self.indexText];
        
        self.numberText = [[NSTextField alloc] init];
        self.numberText.wantsLayer = YES;
        self.numberText.textColor = [NSColor blackColor];
        [self.numberText setAlignment:NSTextAlignmentCenter];
        [self addSubview:self.numberText];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEdit:) name:NSControlTextDidEndEditingNotification object:self.numberText];
    }
    return self;
}

-(void)setCModel:(DashBoardSubCModel *)cModel
{
    _cModel = cModel;
    NSRect frameRect = self.frame;
    CGFloat numScale = 0.0;
    if (cModel.isExtend) {
        numScale = 0.7;
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

-(void)textFieldDidEndEdit:(NSNotification*)noti
{
    NSTextField * textField = noti.object;
    self.cModel.numberStr = textField.stringValue;
    NSMutableString * str =[NSMutableString string];
    //分割的
    for (DashBoardSubCModel * model in self.viewModel.subCmodels) {
        [str appendString:model.numberStr];
    }
    for (id delegete in self.viewModel.delegates) {
        if ([delegete respondsToSelector:@selector(dbViewModel:strDidChange:)]) {
            [delegete dbViewModel:self.viewModel strDidChange:str];
        }
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
}

//-(void)dealloc
//{
//    NSLog(@"%s",__func__);
//}


@end
