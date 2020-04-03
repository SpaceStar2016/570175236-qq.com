//
//  DashBoardScaleModel.h
//  进制工具
//
//  Created by aqara on 2020/4/3.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    DB_SCALE_HEX,
    DB_SCALE_BIN,
    DB_SCALE_DECI,
    DB_SCALE_BUT,
}DB_SCALE_TYPE;


NS_ASSUME_NONNULL_BEGIN

@interface DashBoardScaleModel : NSObject
@property(nonatomic,copy)NSString * scaleStr;
@property(nonatomic,assign)DB_SCALE_TYPE type;
@end

NS_ASSUME_NONNULL_END
