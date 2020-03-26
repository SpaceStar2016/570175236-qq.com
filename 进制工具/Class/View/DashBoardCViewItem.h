//
//  DashBoardCViewItem.h
//  进制工具
//
//  Created by Space Zhong on 2020/3/22.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DashBoardCModel;
NS_ASSUME_NONNULL_BEGIN

@interface DashBoardCViewItem : NSCollectionViewItem
@property(nonatomic,strong)DashBoardCModel * cModel;
@end

NS_ASSUME_NONNULL_END
