//
//  DashBoardSubCItem.m
//  进制工具
//
//  Created by aqara on 2020/3/24.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "DashBoardSubCItem.h"
#import "DashBoardCModel.h"
@interface DashBoardSubCItem ()
@property (weak) IBOutlet NSTextField *numberLabel;
@property (weak) IBOutlet NSTextField *indexLabel;

@end

@implementation DashBoardSubCItem

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = SPSRandomColor.CGColor;
    self.indexLabel.textColor = SPSRandomColor;
    self.indexLabel.backgroundColor = SPSRandomColor;
}

-(void)setCModel:(DashBoardCModel *)cModel
{
    _cModel = cModel;
//    NSString * str = cModel.numberStr;
//    self.numberLabel.stringValue =  cModel.numberStr;
    [self.numberLabel setStringValue:cModel.numberStr];
    [self.indexLabel setStringValue:cModel.index];
    
}

@end
