//
//  DashBoardSubCItem.m
//  进制工具
//
//  Created by aqara on 2020/3/24.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "DashBoardSubCItem.h"
#import "DashBoardSubCModel.h"
@interface DashBoardSubCItem ()
@property (weak) IBOutlet NSTextField *numberLabel;
@property (weak) IBOutlet NSTextField *indexLabel;
@property (weak) IBOutlet NSLayoutConstraint *numberLabelHeight;
@property (weak) IBOutlet NSLayoutConstraint *indexLabelHeight;

@end

@implementation DashBoardSubCItem

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor  redColor].CGColor;

    self.indexLabel.layer.backgroundColor = SPSRandomColor.CGColor;
    self.indexLabel.textColor = [NSColor blackColor];
    self.numberLabel.backgroundColor = SPSRandomColor;
    self.numberLabel.font = [NSFont systemFontOfSize:SUB_COLLECT_NUM_FONT];
    self.indexLabel.font = [NSFont systemFontOfSize:SUB_COLLECT_INDEX_FONT];

}

-(void)setCModel:(DashBoardSubCModel *)cModel
{
    _cModel = cModel;
    
    [self.numberLabel setStringValue:cModel.numberStr];
    [self.indexLabel setStringValue:cModel.index];
    
    CGFloat numScale = 0.7;
    CGFloat viewHeight = self.view.height - SUB_COLLECT_GAP;
    CGFloat indexScale = 1 - numScale;
    self.numberLabelHeight.constant = viewHeight * numScale;
    self.indexLabelHeight.constant = viewHeight * indexScale;
}

-(void)viewWillLayout
{
    [super viewWillLayout];
    
}

-(void)viewDidLayout
{
    [super viewDidLayout];

    
}

@end
