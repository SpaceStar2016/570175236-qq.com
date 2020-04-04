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
#import "DashBoardSubItem.h"
#import "DBViewModel.h"
static NSString * const DashBoardSubCItemID = @"DashBoardSubCItem";

@interface DashBoardCViewItem ()<NSCollectionViewDelegate,NSCollectionViewDataSource>
@property (weak) IBOutlet NSCollectionView *subCollectionView;
@property (nonatomic,strong) IBOutlet NSTextField *indexTextField;
@property(nonatomic,strong)NSMutableArray * subData;
@property (weak) IBOutlet NSLayoutConstraint *subCollHeight;
@property (weak) IBOutlet NSLayoutConstraint *indexHeight;
@property (weak) IBOutlet NSTextField *numLabel;
@property (weak) IBOutlet NSLayoutConstraint *numbelHeight;
@property(nonatomic,strong)NSCollectionViewFlowLayout * layout;
@property (weak) IBOutlet NSScroller *scrollerOne;
@property (weak) IBOutlet NSScroller *scrollerTwo;
@property(nonatomic,strong)NSMutableArray * items;
@property(nonatomic,strong)NSMutableArray * indexItems;
@end

@implementation DashBoardCViewItem


-(void)awakeFromNib
{
    [super awakeFromNib];
    //必须在wantsLayer 后才能设置颜色
    self.view.wantsLayer = YES;
//    self.view.layer.backgroundColor = [NSColor yellowColor].CGColor;
    self.indexTextField.wantsLayer = YES;
    self.indexTextField.layer.backgroundColor = [NSColor greenColor].CGColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //让collectionView有layer
    self.subCollectionView.dataSource = self;
    self.subCollectionView.delegate = self;
    [self.subCollectionView registerClass:[DashBoardSubCItem class] forItemWithIdentifier:DashBoardSubCItemID];
//    self.subCollectionView.

    self.scrollerOne.hidden = YES;
    self.scrollerTwo.hidden = YES;
//    self.subCollectionView.scroll
    self.layout = self.subCollectionView.collectionViewLayout;
    self.layout.minimumInteritemSpacing = 0;
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
    for (NSView * view in self.indexItems) {
        [view removeFromSuperview];
    }
    for (NSView * view in self.items) {
        [view removeFromSuperview];
    }
    [self.items removeAllObjects];
    [self.indexItems removeAllObjects];
    CGFloat viewHeight = self.view.height;
    CGFloat viewWidth = self.view.width;
    CGFloat scale = 0.7;
    if (cModel.isExtend)
    {
        self.indexTextField = [[NSTextField alloc] initWithFrame:CGRectMake(0,0,self.view.width,self.view.height * (1 - scale))];
        self.indexTextField.font = [NSFont systemFontOfSize:DB_BIG_INDEXFONT];
        self.indexTextField.stringValue = [NSString stringWithFormat:@"%@",cModel.index];
        [self.indexTextField setAlignment:NSTextAlignmentCenter];
        self.indexTextField.editable = NO;
        [self.view addSubview:self.indexTextField];
        [self.indexItems addObject:self.indexTextField];
        
        NSInteger numCount = cModel.numberStr.length;
        for (int i = 0;i < cModel.numberStr.length;i++) {
            CGFloat itemH = viewHeight * scale;
            CGFloat itemW = viewWidth / numCount;
            CGFloat itemX = i * itemW;
            CGFloat itemY = CGRectGetMaxY(self.indexTextField.frame);
            DashBoardSubItem * item = [[DashBoardSubItem alloc] initWithFrame:CGRectMake(itemX,itemY,itemW,itemH)];
            NSString * n = [cModel.numberStr substringWithRange:NSMakeRange(i,1)];
            DashBoardSubCModel * mm = [[DashBoardSubCModel alloc] init];
            mm.index = [NSString stringWithFormat:@"%d",i];
            mm.numberStr = n;
            mm.isExtend = cModel.isExtend;
            item.cModel = mm;
            
            [self.view addSubview:item];
            [self.items addObject:item];
            [[DBViewModel viewModel].subCmodels addObject:mm];
        }
    }
    else
    {
        
        self.indexTextField = [[NSTextField alloc] initWithFrame:CGRectMake(0,0,self.view.width,self.view.height * (1 - scale))];
        self.indexTextField.font = [NSFont systemFontOfSize:DB_BIG_INDEXFONT];
        [self.indexTextField setAlignment:NSTextAlignmentCenter];
        self.indexTextField.stringValue = [NSString stringWithFormat:@"%@",cModel.index];
        [self.view addSubview:self.indexTextField];
        

        CGFloat itemH = self.view.height * scale;
        CGFloat itemW = self.view.width;
        CGFloat itemX = 0;
        CGFloat itemY = CGRectGetMaxY(self.indexTextField.frame);
        DashBoardSubItem * item = [[DashBoardSubItem alloc] initWithFrame:CGRectMake(itemX,itemY,itemW,itemH)];
        
        DashBoardSubCModel * mm = [[DashBoardSubCModel alloc] init];
        mm.isExtend = cModel.isExtend;
        mm.numberStr = cModel.numberStr;
        mm.index = @"";
        item.cModel = mm;
        
        [self.view addSubview:item];
        [self.items addObject:item];
        [[DBViewModel viewModel].subCmodels addObject:mm];
        [self.indexItems addObject:self.indexTextField];
        
    }
   
    
}
-(NSMutableArray *)subData
{
    if (_subData == nil) {
        _subData = [NSMutableArray array];
    }
    return _subData;
}
-(NSMutableArray *)indexItems
{
    if (_indexItems == nil) {
        _indexItems = [NSMutableArray array];
    }
    return _indexItems;
}

-(NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

-(void)viewDidLayout
{
    [super viewDidLayout];
    
     
}

@end
