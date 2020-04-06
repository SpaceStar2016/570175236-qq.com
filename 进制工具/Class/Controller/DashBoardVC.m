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
#import "DashBoardScaleModel.h"
#import "DBAsynSocket.h"
#import "DBViewModel.h"
static int separateCount = 1;
@interface DashBoardVC ()<NSCollectionViewDelegate,NSCollectionViewDataSource,NSTextFieldDelegate,DBViewModelDelegate,NSTabViewDelegate,NSTableViewDataSource>

@property (weak) IBOutlet NSTextField *numTextField;
@property(nonatomic,strong)NSMutableArray * sbCData;
@property (weak) IBOutlet NSCollectionView *sbCollectionView;
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
@property(nonatomic,strong)NNButton * selectedButton;
@property (weak) IBOutlet NNButton *sender00;
@property (weak) IBOutlet NSTextField *lenTextField;
@property (weak) IBOutlet NNButton *sender01;
@property(nonatomic,strong)DBViewModel * dbViewModel;

@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSTableView *tableView;

@property(nonatomic,strong)NSMutableArray * tAllData;
@property (weak) IBOutlet NSView *searchContainer;
@property(nonatomic,strong)NSArray * tData;
@property(nonatomic,strong)DBAsynSocket * dbSocket;
@end

@implementation DashBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SpaceByteConvert test];
    self.dbViewModel = [DBViewModel viewModel];
    [self.dbViewModel addDelegates:@[self]];
    self.smallsize = CGSizeMake(DB_SINGLE_ITEMW,DB_SINGLE_ITEMH);
    self.isExtend = YES;
    separateCount = 2;
    
    [self.binaryButton setTitleColor:[NSColor blackColor] forState:NNControlStateNormal];
    [self decorateButton:_binaryButton];
    self.binaryButton.tag = DB_SCALE_BIN;
    [self.binaryButton setTitleColor:[NSColor redColor] forState:NNControlStateSelected];
    [self.scaleBtnArray addObject:self.binaryButton];
    
    [self.decimaButton setTitleColor:[NSColor blackColor] forState:NNControlStateNormal];
    [self decorateButton:_decimaButton];
    self.decimaButton.tag = DB_SCALE_DECI;
    [self.decimaButton setTitleColor:[NSColor redColor] forState:NNControlStateSelected];
    [self.scaleBtnArray addObject:self.decimaButton];
    self.decimaButton.hidden = YES;
    
    [self.hexButton setTitleColor:[NSColor blackColor] forState:NNControlStateNormal];
    [self decorateButton:_hexButton];
    self.hexButton.tag = DB_SCALE_HEX;
    [self.hexButton setTitleColor:[NSColor redColor] forState:NNControlStateSelected];
    [self.scaleBtnArray addObject:self.hexButton];
    self.hexButton.selected = YES;
    

    [self.separateBtn setTitle:@"合并" forState:NNControlStateNormal];
    [self.separateBtn setTitle:@"分割" forState:NNControlStateSelected];
    [self decorateButton:_separateBtn];
    
    self.sbCollectionView.dataSource = self;
    self.sbCollectionView.delegate = self;
    [self.sbCollectionView registerClass:[DashBoardCViewItem class] forItemWithIdentifier:@"DashBoardCViewItem"];
    self.layout = self.sbCollectionView.collectionViewLayout;
    self.layout.itemSize = self.smallsize;
    [self.sbCollectionView setSelectable:YES];
    
    self.tableView.delegate = (id<NSTableViewDelegate>)self;
    self.tableView.dataSource = self;
    
    self.numTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:NSControlTextDidChangeNotification object:self.numTextField];
    self.numTextField.stringValue = @"2314256789";
    
    [self.sender00 setTitleColor:[NSColor systemBlueColor]];
    [self.sender00 setTitle:@"发送" forState:NNControlStateNormal];
    [self decorateButton:_sender00];
    
    [self.sender01 setTitleColor:[NSColor systemBlueColor]];
    [self.sender01 setTitle:@"发送" forState:NNControlStateNormal];
    [self decorateButton:_sender01];
    
    self.searchContainer.wantsLayer = YES;
    self.searchContainer.layer.borderWidth = 0.5;
    self.searchContainer.layer.borderColor = [NSColor systemBlueColor].CGColor;
    //data for text
    for (int i = 0; i < 100; i++) {
        [self.tAllData addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self fontSearchFieldIsChanged:self.searchField];
    
    self.dbSocket = [DBAsynSocket asynSocket];

}

-(void)genDataWithText:(NSString *)str
{
    [self.sbCData removeAllObjects];
    //16进制
    if (self.selectedButton.tag == DB_SCALE_HEX) {
        self.lenTextField.stringValue = [NSString stringWithFormat:@"%.1f bytes",(float)str.length / (float)2];
    }
    if (self.selectedButton.tag == DB_SCALE_BIN) {
        self.lenTextField.stringValue = [NSString stringWithFormat:@"%.1f bytes",(float)str.length / (float)8];
    }
    if (self.isExtend)
    {
        //根据字体大小计算item的宽带
        self.layout.itemSize = CGSizeMake(DB_SINGLE_ITEMW * separateCount, DB_SINGLE_ITEMH);
        int strLen = (int)str.length;
        int count = strLen / separateCount + 1;
        for (int i = 0; i < count; i++)
        {
            int len = 0;
            if (separateCount * (i+1) > strLen) {
                len = strLen % separateCount;
            }else{
                len = separateCount;
            }
            if (len == 0) break;
            DashBoardCModel * cModel = [[DashBoardCModel alloc] init];
            cModel.isExtend = self.isExtend;
            cModel.index = [NSString stringWithFormat:@"%d",i];
            cModel.numberStr = [str substringWithRange:NSMakeRange(i * separateCount, len)];
            [self.sbCData addObject:cModel];

        }
    }
    else
    {
        self.layout.itemSize = self.smallsize;
        for (int i = 0; i < str.length; i++) {
            DashBoardCModel * cModel = [[DashBoardCModel alloc] init];
            cModel.index = [NSString stringWithFormat:@"%d",i];
            cModel.numberStr = [str substringWithRange:NSMakeRange(i, 1)];
            [self.sbCData addObject:cModel];
        }
    }
    [self reloadData];
}



-(void)reloadData
{
    [self.dbViewModel cleanModels];
    [self.sbCollectionView reloadData];
}

#pragma mark textFieldDidChange

-(void)textFieldDidChange:(NSNotification *)nofi
{
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
    return self.sbCData.count;
}

-(NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath{
    
    DashBoardCModel * model = self.sbCData[indexPath.item];
    DashBoardCViewItem *item = [collectionView makeItemWithIdentifier:@"DashBoardCViewItem" forIndexPath:indexPath];
    item.cModel = model;
    if (!item) {
        item = [[DashBoardCViewItem alloc] initWithNibName:@"DashBoardCViewItem" bundle:nil];
    }
    return item;
}

#pragma mark NSTabViewDelegate
#pragma mark NSTableViewDataSource
- (IBAction)fontSearchFieldIsChanged:(NSSearchField *)sender {
    self.tData = [self createListWithSearchWord:sender.stringValue list:self.tAllData];
    [self.tableView reloadData];
}
- (NSArray *)createListWithSearchWord:(NSString *)searchWord list:(NSArray<NSString *> *)oldList {
    if (!searchWord.length) {
        return oldList;
    }
    NSMutableArray *newList = [NSMutableArray array];
    [oldList enumerateObjectsUsingBlock:^(NSString *fixedElement, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange searchResult = [fixedElement rangeOfString:searchWord];
        if (searchResult.location != NSNotFound) {
            [newList addObject:fixedElement];
        }
    }];
    return newList;
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.tData.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row{
    NSString        *identifier = tableColumn.identifier;
    NSTableCellView *cellView   = [tableView makeViewWithIdentifier:identifier owner:self];
    cellView.textField.editable = YES;
    cellView.textField.stringValue = self.tData[row];
    return cellView;
}


#pragma mark DBViewModelDelegate
-(void)dbViewModel:(DBViewModel *)vm strDidChange:(NSString *)totalStr
{
    self.numTextField.stringValue = totalStr;
}

#pragma mark action

- (IBAction)sender00Cli:(NNButton *)sender {
}
- (IBAction)sender01Cli:(NNButton *)sender {
}

//- (IBAction)decimaCli:(NNButton *)sender {
//    if (sender.selected) return;
//    [self.scaleBtnArray removeObject:sender];
//    for (NNButton * nb in self.scaleBtnArray) {
//        nb.selected = NO;
//    }
//    [self.scaleBtnArray addObject:sender];
//    sender.selected = !sender.selected;
//    self.selectedButton = sender;
//
//}

- (IBAction)binaryCli:(NNButton *)sender {
    if (sender.selected) return;
    [self.scaleBtnArray removeObject:sender];
    for (NNButton * nb in self.scaleBtnArray) {
        nb.selected = NO;
    }
    [self.scaleBtnArray addObject:sender];
    sender.selected = !sender.selected;
    self.selectedButton = sender;
    separateCount = 8;
    if (sender.selected) {
        DashBoardScaleModel * scaleModel = [[DashBoardScaleModel alloc] init];
        scaleModel.type = DB_SCALE_HEX;
        scaleModel.scaleStr = self.numTextField.stringValue;
        DashBoardScaleModel * desModel = [self transferScaleFrom:scaleModel to:DB_SCALE_BIN];
        [self genDataWithText:desModel.scaleStr];
        self.numTextField.stringValue = desModel.scaleStr;
    }
    
    
//    NSString * binaryStr = [SpaceByteConvert binaryStrFromHexStr:self.numTextField.stringValue];
//    [self genDataWithText:binaryStr];
    
}
- (IBAction)hexCli:(NNButton *)sender {
    if (sender.selected) return;
    [self.scaleBtnArray removeObject:sender];
    for (NNButton * nb in self.scaleBtnArray) {
        nb.selected = NO;
    }
    [self.scaleBtnArray addObject:sender];
    sender.selected = !sender.selected;
    self.selectedButton = sender;
    separateCount = 2;
    if (sender.selected) {
        DashBoardScaleModel * scaleModel = [[DashBoardScaleModel alloc] init];
        scaleModel.type = DB_SCALE_BIN;
        scaleModel.scaleStr = self.numTextField.stringValue;
        DashBoardScaleModel * desModel = [self transferScaleFrom:scaleModel to:DB_SCALE_HEX];
        [self genDataWithText:desModel.scaleStr];
        self.numTextField.stringValue = desModel.scaleStr;
    }
    
}
- (IBAction)serpaCli:(NNButton *)sender {
    separateCount = self.separateTextF.stringValue.intValue;
    if (!separateCount)
    {
        if (self.selectedButton.tag == DB_SCALE_BIN) {
            separateCount = 8;
        }
        if (self.selectedButton.tag == DB_SCALE_HEX) {
            separateCount = 2;
        }
    }
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

///字符串进制转换
-(DashBoardScaleModel *)transferScaleFrom:(DashBoardScaleModel *)typeFrom to:(DB_SCALE_TYPE)typeTo
{
    DashBoardScaleModel * scModel = [[DashBoardScaleModel alloc] init];
    scModel.type = typeTo;
    if (typeFrom.type == DB_SCALE_HEX) {
        switch (typeTo) {
            case DB_SCALE_BIN:
            {
                scModel.scaleStr = [SpaceByteConvert binStrFromHexStr:typeFrom.scaleStr];
            }
                break;
            case DB_SCALE_DECI:
                break;
            default:
                break;
        }
    }
    if (typeFrom.type == DB_SCALE_BIN) {
        switch (typeTo) {
            case DB_SCALE_HEX:
            {
                scModel.scaleStr = [SpaceByteConvert hexStrFromBinStr:typeFrom.scaleStr];
            }
                break;
            case DB_SCALE_DECI:
                break;
            default:
                break;
        }
    }
    return scModel;
}

-(NSMutableArray *)scaleBtnArray
{
    if (_scaleBtnArray == nil) {
        _scaleBtnArray = [NSMutableArray array];
    }
    return _scaleBtnArray;
}

-(NSMutableArray *)sbCData
{
    if (_sbCData == nil) {
        _sbCData = [NSMutableArray array];
    }
    return _sbCData;
}

-(NSMutableArray *)tAllData
{
    if (!_tAllData) {
        _tAllData = [NSMutableArray array];
    }
    return _tAllData;
}

-(void)decorateButton:(NNButton *)btn
{
//    btn.wantsLayer = YES;
    

    btn.wantsLayer = YES;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 8;
    btn.layer.borderWidth = 2;
}

@end
