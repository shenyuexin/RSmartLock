//
//  RSettingViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/18.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RSettingViewController.h"
#import "UIImage+Color.h"

@interface RSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) NSArray *dataList;

@end

static NSString *RSettingCellIdentifier = @"RSettingCellIdentifier";
@implementation RSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    self.dataList = @[@"修改开锁密码",@"锁指纹录入"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.tableView.separatorColor = HEX_RGB(0xdddddd);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:RSettingCellIdentifier];
    self.tableView.tableFooterView = self.footerView;
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

#pragma mark - UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RSettingCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = HEX_RGB(0x333333);
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *text = self.dataList[indexPath.row];
    if([text isEqualToString:@"修改开锁密码"]){
        [[WBMediator sharedManager] gotoModifyPasswordController];
    }
    else if([text isEqualToString:@"锁指纹录入"]){
        [[WBMediator sharedManager] gotoFingerPrintController];
    }
}

#pragma mark - Getter
- (UIView *)footerView
{
    if(!_footerView){
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _footerView.backgroundColor = [UIColor clearColor];
        [_footerView addSubview:self.submitBtn];
    }
    return _footerView;
}

- (UIButton *)submitBtn
{
    if(!_submitBtn){
        _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 40)];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_submitBtn setTitleColor:HEX_RGB(0xf26464) forState:UIControlStateNormal];
        [_submitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
@end
