//
//  DashBoardSubCItem.h
//  进制工具
//
//  Created by aqara on 2020/3/24.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DashBoardSubCModel;
NS_ASSUME_NONNULL_BEGIN

@interface DashBoardSubCItem : NSCollectionViewItem
@property(nonatomic,strong)DashBoardSubCModel * cModel;
@end

NS_ASSUME_NONNULL_END
