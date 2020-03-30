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
#import "DashBoardSubCModel.h"
static NSString * const DashBoardSubCItemID = @"DashBoardSubCItem";

@interface DashBoardCViewItem ()<NSCollectionViewDelegate,NSCollectionViewDataSource>
@property (weak) IBOutlet NSCollectionView *subCollectionView;
@property (weak) IBOutlet NSTextField *indexTextField;
@property(nonatomic,strong)NSMutableArray * subData;
@property (weak) IBOutlet NSLayoutConstraint *subCollHeight;
@property (weak) IBOutlet NSLayoutConstraint *indexHeight;
@property (weak) IBOutlet NSTextField *numLabel;
@property (weak) IBOutlet NSLayoutConstraint *numbelHeight;


@end

@implementation DashBoardCViewItem


-(void)awakeFromNib
{
    
    [super awakeFromNib];
    self.view.layer.backgroundColor = SPSRandomColor.CGColor;
    self.indexTextField.textColor = [NSColor blackColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //让collectionView有layer
    self.view.wantsLayer = YES;    
    self.subCollectionView.dataSource = self;
    self.subCollectionView.delegate = self;
    [self.subCollectionView registerClass:[DashBoardSubCItem class] forItemWithIdentifier:DashBoardSubCItemID];

    NSCollectionViewFlowLayout * layout = self.subCollectionView.collectionViewLayout;
    layout.estimatedItemSize = CGSizeMake(20,40);
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
    DashBoardSubCModel * model = self.subData[indexPath.item];
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
    CGFloat viewHeight = self.view.height;
    if (cModel.isExtend)
    {
        self.subCollHeight.constant = viewHeight * 0.8;
        self.indexHeight.constant = viewHeight * 0.2;
         CGFloat indexFont = self.indexHeight.constant - 1;
        self.indexTextField.font = [NSFont systemFontOfSize:indexFont];
        self.subCollectionView.hidden = NO;
        self.indexTextField.hidden = YES;
        for (int i = 0;i < cModel.numberStr.length;i++) {
           NSString * n = [cModel.numberStr substringWithRange:NSMakeRange(i,1)];
           DashBoardSubCModel * mm = [[DashBoardSubCModel alloc] init];
           mm.index = [NSString stringWithFormat:@"%d",i];
           mm.numberStr = n;
           mm.isSingle = YES;
           [self.subData addObject:mm];
        }
        self.indexTextField.stringValue = [NSString stringWithFormat:@"%@",cModel.index];
    }
    else
    {
        self.subCollectionView.hidden = YES;
        self.indexTextField.hidden = NO;
        
        self.numbelHeight.constant = viewHeight * 0.7;
        
        CGFloat numFont = self.numbelHeight.constant - 1;
        self.numLabel.font = [NSFont systemFontOfSize:numFont];
        self.numLabel.stringValue = cModel.numberStr;

        self.indexHeight.constant = viewHeight * 0.3;
         CGFloat indexFont = self.indexHeight.constant - 1;
        self.indexTextField.font = [NSFont systemFontOfSize:indexFont];
        self.indexTextField.stringValue = cModel.index;
    }
   
    
}
-(NSMutableArray *)subData
{
    if (_subData == nil) {
        _subData = [NSMutableArray array];
    }
    return _subData;
}

-(void)viewDidLayout
{
    [super viewDidLayout];
    
     
}

@end
