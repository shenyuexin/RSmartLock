//
//  RReportViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/17.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RReportViewController.h"
#import "RReportCell.h"
#import "UIImage+Color.h"

@interface RReportViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation RReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"申报异常";
    self.dataList = @[@"输入密码无法开锁",
                      @"IC磁卡无法开锁",
                      @"电池过期",
                      @"锁键位损坏",
                      @"人脸验证失败"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 45, 0, 0);
    self.tableView.separatorColor = HEX_RGB(0xdddddd);
    [self.tableView registerClass:[RReportCell class] forCellReuseIdentifier:RReportCellIdentifier];
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

- (void)submitClick
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
    return self.dataList.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RReportCell *cell = [tableView dequeueReusableCellWithIdentifier:RReportCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == self.dataList.count) {
        
    }
    else{
        cell.txtLabel.text = self.dataList[indexPath.row];
    }
    return cell;
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
        _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, 40)];
        _submitBtn.layer.cornerRadius = 4;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_submitBtn setBackgroundImage:[UIImage imageWithColor:HEX_RGB(0x5f9ff3)] forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
@end
