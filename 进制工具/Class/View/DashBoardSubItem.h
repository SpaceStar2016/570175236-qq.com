//
//  DashBoardSubItem.h
//  进制工具
//
//  Created by aqara on 2020/4/3.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DashBoardSubCModel;
NS_ASSUME_NONNULL_BEGIN

@interface DashBoardSubItem : NSView
@property(nonatomic,strong)DashBoardSubCModel * cModel;
@end

NS_ASSUME_NONNULL_END
