//
//  DashBoardVC.m
//  进制工具
//
//  Created by Space Zhong on 2020/3/22.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "DashBoardVC.h"
#import "DashBoardCViewItem.h"
#import "DashBoardCModel.h"
@interface DashBoardVC ()<NSCollectionViewDelegate,NSCollectionViewDataSource,NSTextFieldDelegate>
@property (weak) IBOutlet NSTextField *numTextField;
@property(nonatomic,strong)NSMutableArray * cellData;

@property (weak) IBOutlet NSCollectionView *sbCollectionView;

@property(nonatomic,strong)NSCollectionView* collectionView;


@end

@implementation DashBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.sbCollectionView.dataSource = self;
    self.sbCollectionView.delegate = self;
    [self.sbCollectionView registerClass:[DashBoardCViewItem class] forItemWithIdentifier:@"DashBoardCViewItem"];
    NSCollectionViewFlowLayout * layout = self.sbCollectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(100, 100);
    datasource = [[NSMutableArray alloc] init];
    
    [self.sbCollectionView setSelectable:YES];
    
    self.numTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:NSControlTextDidChangeNotification object:self.numTextField];
    self.numTextField.stringValue = @"2314256789";
    

    [self genData];
    
    [self.sbCollectionView reloadData];
}

-(void)genData
{
    for (int i = 0; i < 2; i++) {
        DashBoardCModel * cModel = [[DashBoardCModel alloc] init];
        cModel.index = [NSString stringWithFormat:@"%d",i];
        cModel.numberStr = @"123567890";
        [self.cellData addObject:cModel];
    }
    [self.sbCollectionView reloadData];
}

#pragma mark textFieldDidChange

-(void)textFieldDidChange:(NSNotification *)nofi
{
    NSLog(@"textFieldDidChange");
//    NSTextField * t
}

#pragma mark NSCollectionViewDelegate
#pragma mark NSCollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellData.count;
}

-(NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"indexPath==%ld",(long)indexPath.item);
    DashBoardCModel * model = self.cellData[indexPath.item];
    DashBoardCViewItem *item = [collectionView makeItemWithIdentifier:@"DashBoardCViewItem" forIndexPath:indexPath];
    item.cModel = model;
    if (!item) {
        item = [[DashBoardCViewItem alloc] initWithNibName:@"DashBoardCViewItem" bundle:nil];
    }
    return item;
}

//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    LHImageTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LHImageTitleCollectionViewCell class]) forIndexPath:indexPath];
//    [cell updateCellWithData:self.alertList[indexPath.item]];
//    return cell;
//}




-(NSMutableArray *)cellData
{
    if (_cellData == nil) {
        _cellData = [NSMutableArray array];
    }
    return _cellData;
}

@end
