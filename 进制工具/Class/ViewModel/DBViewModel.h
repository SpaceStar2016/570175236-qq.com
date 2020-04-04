//
//  DBViewModel.h
//  进制工具
//
//  Created by Space Zhong on 2020/4/4.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class DashBoardCModel;
@class DashBoardSubCModel;
@class DBViewModel;
@protocol DBViewModelDelegate <NSObject>

-(void)dbViewModel:(DBViewModel *)vm strDidChange:(NSString *)totalStr;

@end

@interface DBViewModel : NSObject
@property(nonatomic,assign)BOOL isSeparate;
//@property(nonatomic,strong)NSMutableArray <DashBoardCModel *> * cModels;
@property(nonatomic,strong)NSMutableArray <DashBoardSubCModel *> * subCmodels;
@property(nonatomic,strong)NSHashTable * delegates;
+(instancetype)viewModel;
-(void)cleanModels;
-(void)addDelegates:(NSArray<DBViewModelDelegate >*)delegates;
-(NSString *)totalStr;

@end

NS_ASSUME_NONNULL_END
