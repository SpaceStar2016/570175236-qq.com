//
//  DashBoardCViewItem.m
//  进制工具
//
//  Created by Space Zhong on 2020/3/22.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "DashBoardCViewItem.h"
#import "DashBoardCModel.h"
#import "DashBoardSubCModel.h"
#import "DashBoardSubItem.h"
#import "DBViewModel.h"
static NSString * const DashBoardSubCItemID = @"DashBoardSubCItem";

@interface DashBoardCViewItem ()<NSCollectionViewDelegate,NSCollectionViewDataSource>
@property (nonatomic,strong)NSTextField *indexTextField;
//@property(nonatomic,strong)NSMutableArray * subData;
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
//        self.indexTextField.editable = NO;
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

//-(void)dealloc
//{
//    NSLog(@"%s",__func__);
//}

@end
