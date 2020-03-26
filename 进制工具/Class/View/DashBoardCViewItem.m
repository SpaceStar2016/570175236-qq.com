//
//  DashBoardCViewItem.m
//  进制工具
//
//  Created by Space Zhong on 2020/3/22.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "DashBoardCViewItem.h"
#import "DashBoardSubCItem.h"
#import "DashBoardCModel.h"
static NSString * const DashBoardSubCItemID = @"DashBoardSubCItem";

@interface DashBoardCViewItem ()<NSCollectionViewDelegate,NSCollectionViewDataSource>
@property (weak) IBOutlet NSButton *testB;
@property (weak) IBOutlet NSCollectionView *subCollectionView;
@property(nonatomic,strong)NSMutableArray * subData;

@end

@implementation DashBoardCViewItem


-(void)awakeFromNib
{
    
    [super awakeFromNib];
    self.view.layer.backgroundColor = SPSRandomColor.CGColor;
    self.testB.layer.backgroundColor = SPSRandomColor.CGColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //让collectionView有layer
    self.view.wantsLayer = YES;    
    self.subCollectionView.dataSource = self;
    self.subCollectionView.delegate = self;
    [self.subCollectionView registerClass:[DashBoardSubCItem class] forItemWithIdentifier:DashBoardSubCItemID];

    NSCollectionViewFlowLayout * layout = self.subCollectionView.collectionViewLayout;
    layout.estimatedItemSize = CGSizeMake(10,20);
//    layout.minimumLineSpacing = 0;
//    layout.minimumInteritemSpacing = 0;
    // Do view setup here.
}

#pragma mark NSCollectionViewDelegate
#pragma mark NSCollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.subData.count;
}

-(NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    DashBoardSubCItem *item = [collectionView makeItemWithIdentifier:DashBoardSubCItemID forIndexPath:indexPath];
    DashBoardCModel * model = self.subData[indexPath.item];
    if (!item) {
        item = [[DashBoardSubCItem alloc] initWithNibName:@"DashBoardSubCItem" bundle:nil];
    }
    item.cModel = model;
    return item;
}

-(void)setCModel:(DashBoardCModel *)cModel
{
    _cModel = cModel;
    [self.subData removeAllObjects];
    for (int i = 0;i < cModel.numberStr.length;i++) {
        NSString * n = [cModel.numberStr substringWithRange:NSMakeRange(i,1)];
        DashBoardCModel * mm = [[DashBoardCModel alloc] init];
        mm.index = [NSString stringWithFormat:@"%d",i];
        mm.numberStr = n;
        [self.subData addObject:mm];
    }
    
}
-(NSMutableArray *)subData
{
    if (_subData == nil) {
        _subData = [NSMutableArray array];
    }
    return _subData;
}

@end
