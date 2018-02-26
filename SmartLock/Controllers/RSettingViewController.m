//
//  RSettingViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/18.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RSettingViewController.h"
#import "UIImage+Color.h"
#import "WBAPIManager+Bussiness.h"
#import "RRatePickerView.h"

@interface RSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) RRatePickerView *pickerView;
@property (nonatomic, strong) UILabel *rateLabel;
@end

static NSString *RSettingCellIdentifier = @"RSettingCellIdentifier";
@implementation RSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
    
    self.dataList = @[@[@"认证频度"],@[@"设定开锁许可人员"],
                      @[@"设置临时密码",@"设置IC卡开锁",@"设置指纹开锁"],
                      @[@"停用"],@[@"重置智能锁"]];
    
    self.tableView.rowHeight = 51;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.tableView.separatorColor = HEX_RGB(0xdddddd);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:RSettingCellIdentifier];
    
    @weakify(self);
    RACSignal *rateSignal = RACObserve(self.pickerView, rateString);
    [rateSignal subscribeNext:^(id x) {
        @strongify(self);
        self.rateLabel.text = self.pickerView.rateString;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event
- (void)logoutClick
{
    
}

//- (void)saveClick
//{
//
//}

#pragma mark - UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 43;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 3 || section == 4){
        return 43;
    }
    return CGFLOAT_MIN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, SCREEN_WIDTH, 14)];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = HEX_RGB(0x666666);

        NSMutableParagraphStyle *_labelStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        _labelStyle.alignment = NSTextAlignmentJustified;
        _labelStyle.firstLineHeadIndent = 15;
        _labelStyle.headIndent = 15;
        
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:@"认证的时候需要扫码锁二维码刷脸认证" attributes:@{ NSParagraphStyleAttributeName : _labelStyle}];
        label.attributedText = attrText;
        return label;
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == 3 || section == 4){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-30, 14)];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = HEX_RGB(0xaaaaaa);
        label.textAlignment = NSTextAlignmentCenter;
        if(section == 3){
            label.text = @"停用后用户将无法开锁";
        }
        else{
            label.text = @"重置后将清除全部使用记录";
        }
        return label;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataList[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RSettingCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = HEX_RGB(0x555555);
    
    NSArray *array = self.dataList[indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    if(indexPath.section == 3 || indexPath.section == 4){
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        
        if(indexPath.section == 3){
            cell.textLabel.textColor = HEX_RGB(0x333333);
        }
        else{
            cell.textLabel.textColor = HEX_RGB(0xec5b5b);
        }
    }
    else{
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    if(indexPath.section == 0){
        [cell addSubview:self.rateLabel];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{

    if(indexPath.section == 0)
    {
        [self.pickerView showInView:[UIApplication sharedApplication].keyWindow];
    }
    else if(indexPath.section == 1)
    {
        [[WBMediator sharedManager] gotoSetPersonController:_lock];
    }
    else if(indexPath.section == 2)
    {
        if(indexPath.row == 0){
            [[WBMediator sharedManager] gotoModifyPasswordController];
        }
        else if(indexPath.row == 1){
            [[WBMediator sharedManager] gotoICController];
        }
        else if(indexPath.row == 2){
            [[WBMediator sharedManager] gotoFingerPrintController];
        }
    }
    else if(indexPath.section == 3)
    {
        [[WBAPIManager stopLock:_lock.lid] subscribeNext:^(id x) {
            [WBLoadingView showSuccessStatus:@"停用成功"];
            _lock.status = 90;
        }];
    }
    else if(indexPath.section == 4)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要重置智能锁吗?"
                                                                       message:@"重置后将清空所有个人记录及设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[WBAPIManager resetLock:_lock.lid] subscribeNext:^(id x) {
                [WBLoadingView showSuccessStatus:@"重置成功"];
                [self.tableView reloadData];
            }];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Getter
- (RRatePickerView *)pickerView
{
    if(!_pickerView){
        _pickerView = [[RRatePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _pickerView;
}

- (UILabel *)rateLabel
{
    if(!_rateLabel){
        _rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 17, SCREEN_WIDTH-150, 17)];
        _rateLabel.font = [UIFont systemFontOfSize:15];
        _rateLabel.textColor = HEX_RGB(0x000000);
        _rateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rateLabel;
}
@end
