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
#import "SpaceByteConvert.h"
@interface DashBoardVC ()<NSCollectionViewDelegate,NSCollectionViewDataSource,NSTextFieldDelegate>
@property (weak) IBOutlet NSTextField *numTextField;
@property(nonatomic,strong)NSMutableArray * cellData;

@property (weak) IBOutlet NSCollectionView *sbCollectionView;

@property(nonatomic,strong)NSCollectionView* collectionView;
@property (weak) IBOutlet NSButton *decimaButton;

@property (weak) IBOutlet NSButton *binaryButton;

@property (weak) IBOutlet NSButton *hexButton;

@property (weak) IBOutlet NSButton *separateBtn;
@property (weak) IBOutlet NSTextField *separateTextF;

@property(nonatomic,assign)NSSize smallsize;
@property(nonatomic,assign)NSSize bigSize;
@property(nonatomic,assign)BOOL isExtend;
@end

@implementation DashBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.smallsize = CGSizeMake(15,30);
    self.bigSize = CGSizeMake(200, 100);
    self.isExtend = NO;
    
    self.sbCollectionView.dataSource = self;
    self.sbCollectionView.delegate = self;
    [self.sbCollectionView registerClass:[DashBoardCViewItem class] forItemWithIdentifier:@"DashBoardCViewItem"];
    NSCollectionViewFlowLayout * layout = self.sbCollectionView.collectionViewLayout;
    
    layout.itemSize = self.smallsize;
    datasource = [[NSMutableArray alloc] init];
    
    [self.sbCollectionView setSelectable:YES];
    
    self.numTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:NSControlTextDidChangeNotification object:self.numTextField];
    self.numTextField.stringValue = @"2314256789";
    
//    [self genData];
    [self.sbCollectionView reloadData];
    
}

-(void)genDataWithText:(NSString *)str
{
    [self.cellData removeAllObjects];
    if (self.isExtend) {
        for (int i = 0; i < 2; i++) {
            DashBoardCModel * cModel = [[DashBoardCModel alloc] init];
            cModel.index = [NSString stringWithFormat:@"%d",i];
            cModel.numberStr = @"123567890";
            [self.cellData addObject:cModel];
        }
        [self.sbCollectionView reloadData];
    }
    else{
        for (int i = 0; i < str.length; i++) {
            DashBoardCModel * cModel = [[DashBoardCModel alloc] init];
            cModel.index = [NSString stringWithFormat:@"%d",i];
            cModel.numberStr = [str substringWithRange:NSMakeRange(i, 1)];
            [self.cellData addObject:cModel];
        }
        [self.sbCollectionView reloadData];
    }
    
}

#pragma mark textFieldDidChange

-(void)textFieldDidChange:(NSNotification *)nofi
{
    NSLog(@"textFieldDidChange");
    NSTextField * textField = nofi.object;
    [self genDataWithText:textField.stringValue];
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

#pragma mark action
- (IBAction)decimaCli:(id)sender {
    
    
}
- (IBAction)binaryCli:(id)sender {
    NSString * binaryStr = [SpaceByteConvert binaryWithHexadecimal:self.numTextField.stringValue];
    [self genDataWithText:binaryStr];
    
}
- (IBAction)hexCli:(id)sender {
    
    
}
- (IBAction)serpaCli:(NSButton *)sender {
    self.isExtend = !self.isExtend;
    //分割数据
    int num = self.separateTextF.stringValue.intValue;
    if (num <= 1) {
        
    }
    else{
        
    }
    
}




-(NSMutableArray *)cellData
{
    if (_cellData == nil) {
        _cellData = [NSMutableArray array];
    }
    return _cellData;
}

@end
