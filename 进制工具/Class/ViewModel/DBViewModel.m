//
//  DBViewModel.m
//  进制工具
//
//  Created by Space Zhong on 2020/4/4.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "DBViewModel.h"
@interface DBViewModel()
@end
@implementation DBViewModel
+(instancetype)viewModel
{
    static DBViewModel * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DBViewModel alloc] init];
    });
    return instance;
}

-(void)cleanModels
{
    [self.subCmodels removeAllObjects];
}


-(NSMutableArray<DashBoardSubCModel *> *)subCmodels
{
    if (_subCmodels == nil) {
        _subCmodels = [NSMutableArray array];
    }
    return _subCmodels;
}

-(void)addDelegates:(NSArray<DBViewModelDelegate >*)delegates
{
    for (id delegate in delegates) {
        [self.delegates addObject:delegate];
    }
}
-(NSHashTable *)delegates
{
    if (_delegates == nil) {
        _delegates = [[NSHashTable alloc] initWithOptions:NSHashTableWeakMemory capacity:0];
    }
    return _delegates;
}

@end
