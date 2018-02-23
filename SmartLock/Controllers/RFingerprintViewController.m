//
//  RFingerprintViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/22.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RFingerprintViewController.h"
#import "RFingerPrintCell.h"

@interface RFingerprintViewController ()<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@end

@implementation RFingerprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置指纹";
    self.tableView.tableHeaderView = self.headerView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.tableView];
    [self setBluetoothConnect:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBluetoothConnect:(BOOL)connect
{
    UIImage *img = nil;
    NSMutableAttributedString *tipString = nil;
    NSString *infoString = nil;
    if(connect){
        self.imgView.frame = CGRectMake((self.view.width-107)/2, 20, 107, 34);
        img = [UIImage imageNamed:@"lanyalianjie"];
        infoString = @"在听到提示音后将手指放置在门锁的指纹识别区域录制指纹";
        
        tipString = [[NSMutableAttributedString alloc] initWithString:@"连接成功"];
        NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
        attachment.bounds = CGRectMake(0, -2, 17, 17);
        attachment.image = [UIImage imageNamed:@"right_lv"];
        [tipString insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
    }
    else{
        self.imgView.frame = CGRectMake((self.view.width-41)/2, 20, 41, 41);
        img = [UIImage imageNamed:@"sao_black"];
        infoString = @"连接蓝牙后，在听到提示音后将手指放置在门锁的指纹识别区域录制指纹";
        tipString = [[NSMutableAttributedString alloc] initWithString:@"扫码连接蓝牙"];
    }
    self.imgView.image = img;
    self.tipLabel.attributedText = tipString;
    self.tipLabel.top = self.imgView.bottom + 10;
    self.infoLabel.text = infoString;
    [self.infoLabel sizeToFit];
    self.infoLabel.top = _headerView.height - self.infoLabel.height - 10;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 51;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(RFingerPrintCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.enabled = (indexPath.row==0)?YES:NO;
    cell.record = (indexPath.row==0)?YES:NO;
    cell.title = [NSString stringWithFormat:@"指纹%ld",(long)indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RFingerPrintCell *cell = [tableView dequeueReusableCellWithIdentifier:RFingerPrintCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        [[WBMediator sharedManager] gotoPrintingController];
    }
}
#pragma mark - Getter
//- (UITableView *)tableView
//{
//    if(!_tableView){
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
//        _tableView.scrollsToTop = YES;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
//        _tableView.separatorColor = HEX_RGB(0xdddddd);
//        _tableView.rowHeight = 51;
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        _tableView.backgroundColor = RGB(235, 235, 241);
//        _tableView.estimatedRowHeight = 0;
//        _tableView.estimatedSectionHeaderHeight = 0;
//        _tableView.estimatedSectionFooterHeight = 0;
//        [_tableView registerClass:[RFingerPrintCell class] forCellReuseIdentifier:RFingerPrintCellIdentifier];
//    }
//    return _tableView;
//}

- (UIView *)headerView
{
    if(!_headerView){
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 170)];
        [_headerView addSubview:self.imgView];
        [_headerView addSubview:self.tipLabel];
        [_headerView addSubview:self.infoLabel];
    }
    return _headerView;
}

- (UIImageView *)imgView
{
    if(!_imgView){
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imgView;
}

- (UILabel *)tipLabel
{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 16)];
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = HEX_RGB(0x333333);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UILabel *)infoLabel
{
    if(!_infoLabel){
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _headerView.height-40, self.view.width-30, 30)];
        _infoLabel.font = [UIFont systemFontOfSize:13];
        _infoLabel.textColor = HEX_RGB(0x666666);
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        _infoLabel.numberOfLines = 0;
    }
    return _infoLabel;
}
@end
