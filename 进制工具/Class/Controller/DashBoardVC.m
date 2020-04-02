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
#import "SWSTAnswerButton.h"
#import "NNButton.h"

@interface DashBoardVC ()<NSCollectionViewDelegate,NSCollectionViewDataSource,NSTextFieldDelegate>
@property (weak) IBOutlet NSTextField *numTextField;
@property(nonatomic,strong)NSMutableArray * cellData;

@property (weak) IBOutlet NSCollectionView *sbCollectionView;

@property(nonatomic,strong)NSCollectionView* collectionView;
@property (weak) IBOutlet NNButton *decimaButton;

@property (weak) IBOutlet NNButton *binaryButton;

@property (weak) IBOutlet NNButton *hexButton;
@property (weak) IBOutlet NNButton *separateBtn;


@property (weak) IBOutlet NSTextField *separateTextF;
@property(nonatomic,assign)NSSize smallsize;
@property(nonatomic,assign)NSSize bigSize;
@property(nonatomic,strong)NSCollectionViewFlowLayout * layout;
@property(nonatomic,assign)BOOL isExtend;
@property(nonatomic,strong)NSMutableArray * scaleBtnArray;

@end

@implementation DashBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.smallsize = CGSizeMake(SUB_COLLECT_NUM_WIDTH + SUB_COLLECT_GAP * 2,SUB_COLLECT_NUM_HEIGHT);
    self.isExtend = NO;
    
    [self.binaryButton setTitleColor:[NSColor blackColor] forState:NNControlStateNormal];
    [self.binaryButton setTitleColor:[NSColor redColor] forState:NNControlStateSelected];
    [self.scaleBtnArray addObject:self.binaryButton];
    
    [self.decimaButton setTitleColor:[NSColor blackColor] forState:NNControlStateNormal];
    [self.decimaButton setTitleColor:[NSColor redColor] forState:NNControlStateSelected];
    [self.scaleBtnArray addObject:self.decimaButton];
    
    [self.hexButton setTitleColor:[NSColor blackColor] forState:NNControlStateNormal];
    [self.hexButton setTitleColor:[NSColor redColor] forState:NNControlStateSelected];
    [self.scaleBtnArray addObject:self.hexButton];
    self.hexButton.selected = YES;
    

    [self.separateBtn setTitle:@"分割" forState:NNControlStateNormal];
    [self.separateBtn setTitle:@"取消分割" forState:NNControlStateSelected];
    
    self.sbCollectionView.dataSource = self;
    self.sbCollectionView.delegate = self;
    [self.sbCollectionView registerClass:[DashBoardCViewItem class] forItemWithIdentifier:@"DashBoardCViewItem"];
    self.layout = self.sbCollectionView.collectionViewLayout;
    
    self.layout.itemSize = self.smallsize;
    datasource = [[NSMutableArray alloc] init];
    
    [self.sbCollectionView setSelectable:YES];
    
    self.numTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:NSControlTextDidChangeNotification object:self.numTextField];
    self.numTextField.stringValue = @"2314256789";
    
    
    [self.sbCollectionView reloadData];
    
    NSLog(@"bigCView==%@",self.sbCollectionView);
    
}

-(void)genDataWithText:(NSString *)str
{
    int separateCount = 2;
    [self.cellData removeAllObjects];
    if (self.isExtend)
    {
        //根据字体大小计算item的宽带
        self.layout.itemSize = CGSizeMake((SUB_COLLECT_NUM_WIDTH + SUB_COLLECT_GAP) * separateCount + 50, SUB_COLLECT_NUM_HEIGHT+50);
        int strLen = (int)str.length;
        int count = strLen / separateCount + 1;
        for (int i = 0; i < count; i++)
        {
//            NSLog(@"i======%d",i);
            int len = 0;
            if (separateCount * (i+1) > strLen) {
                len = strLen % separateCount;
            }else{
                len = separateCount;
            }
            DashBoardCModel * cModel = [[DashBoardCModel alloc] init];
            cModel.isExtend = self.isExtend;
            cModel.index = [NSString stringWithFormat:@"%d",i];
            
            cModel.numberStr = [str substringWithRange:NSMakeRange(i * separateCount, len)];
            [self.cellData addObject:cModel];
        }
        [self.sbCollectionView reloadData];
    }
    else
    {
        self.layout.itemSize = self.smallsize;
        for (int i = 0; i < str.length; i++) {
            DashBoardCModel * cModel = [[DashBoardCModel alloc] init];
            cModel.index = [NSString stringWithFormat:@"%d",i];
            cModel.numberStr = [str substringWithRange:NSMakeRange(i, 1)];
            [self.cellData addObject:cModel];
        }
        [self.sbCollectionView reloadData];
    }
    
}

-(void)separateWithInt:(int)num
{
    
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
- (IBAction)decimaCli:(NNButton *)sender {
    [self.scaleBtnArray removeObject:sender];
    for (NNButton * nb in self.scaleBtnArray) {
        nb.selected = NO;
    }
    [self.scaleBtnArray addObject:sender];
    sender.selected = !sender.selected;
    
}
- (IBAction)binaryCli:(NNButton *)sender {
    [self.scaleBtnArray removeObject:sender];
    for (NNButton * nb in self.scaleBtnArray) {
        nb.selected = NO;
    }
    [self.scaleBtnArray addObject:sender];
    sender.selected = !sender.selected;
    NSString * binaryStr = [SpaceByteConvert binaryWithHexadecimal:self.numTextField.stringValue];
    [self genDataWithText:binaryStr];
    
}
- (IBAction)hexCli:(NNButton *)sender {
    [self.scaleBtnArray removeObject:sender];
    for (NNButton * nb in self.scaleBtnArray) {
        nb.selected = NO;
    }
    [self.scaleBtnArray addObject:sender];
    sender.selected = !sender.selected;
    
}
- (IBAction)serpaCli:(NNButton *)sender {
    sender.selected = !sender.selected;
    self.isExtend = !self.isExtend;
    [self genDataWithText:self.numTextField.stringValue];
    //分割数据
    int num = self.separateTextF.stringValue.intValue;
    if (num <= 1) {
        
    }
    else{
        
    }
    
}


-(NSMutableArray *)scaleBtnArray
{
    if (_scaleBtnArray == nil) {
        _scaleBtnArray = [NSMutableArray array];
    }
    return _scaleBtnArray;
}

-(NSMutableArray *)cellData
{
    if (_cellData == nil) {
        _cellData = [NSMutableArray array];
    }
    return _cellData;
}

@end
