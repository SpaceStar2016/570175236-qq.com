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
    self.view.layer.backgroundColor = SPSRandomColor.CGColor;
    self.indexLabel.textColor = [NSColor blackColor];
//    self.indexLabel.backgroundColor = SPSRandomColor;

}

-(void)setCModel:(DashBoardSubCModel *)cModel
{
    _cModel = cModel;
    if (cModel.isSingle) {
        [self.numberLabel setStringValue:cModel.numberStr];
        [self.indexLabel setStringValue:cModel.index];
//
    }
    else{
        [self.numberLabel setStringValue:cModel.numberStr];
        [self.indexLabel setStringValue:cModel.index];
//        [self.indexLabel setStringValue:cModel.index];
    }
    
}


-(void)viewDidLayout
{
    [super viewDidLayout];
    CGFloat numScale = 0;
    if (self.cModel.isSingle) {
        numScale = 1.0;
    }else{
        numScale = 0.7;
    }
    CGFloat viewHeight = self.view.height;
    CGFloat indexScale = 1 - numScale;
    
    self.numberLabelHeight.constant = viewHeight * numScale;
    self.numberLabel.font = [NSFont systemFontOfSize:5];
   
    self.indexLabelHeight.constant = viewHeight * indexScale;
    self.indexLabel.font = [NSFont systemFontOfSize:5];
}

@end
