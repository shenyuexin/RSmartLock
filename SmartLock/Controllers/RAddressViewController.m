//
//  RAddressViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/4.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RAddressViewController.h"
#import "UIImage+Color.h"
#import "WBAPIManager+Bussiness.h"

@interface RAddressViewController ()

@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UITextView *txtView;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation RAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"详细地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.locationBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.txtView];
    [self.view addSubview:self.submitBtn];
    self.txtView.text = self.lock.address;
}

#pragma mark - Event
- (void)locationClick
{
    
}

- (void)submitClick
{
    if(self.txtView.text.isNotEmpty && ![self.txtView.text isEqualToString:self.lock.address]){
        [[WBAPIManager setLockAddress:self.txtView.text serialNum:self.lock.lid] subscribeNext:^(id x) {
            self.lock.address = self.txtView.text;
            [WBLoadingView showSuccessStatus:@"修改锁地址成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } error:^(NSError *error) {
            [WBLoadingView showErrorStatus:error.domain];
        }];
    }
}


#pragma mark - Geeter
- (UIButton *)locationBtn
{
    if(!_locationBtn){
        _locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _locationBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 26, 12, 3);
        [_locationBtn setImage:[UIImage imageNamed:@"icon_dingwei"] forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchDown];
    }
    return _locationBtn;
}

- (UILabel *)tipLabel
{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 15)];
        _tipLabel.font = [UIFont systemFontOfSize:13];
        _tipLabel.textColor = HEX_RGB(0x999999);
        _tipLabel.text = @"连接锁蓝牙后点击一下定位图标可获取锁地址";
    }
    return _tipLabel;
}

- (UITextView *)txtView
{
    if(!_txtView){
        _txtView = [[UITextView alloc] initWithFrame:CGRectMake(15, _tipLabel.bottom+7, SCREEN_WIDTH-30, 100)];
        _txtView.backgroundColor = HEX_RGB(0xF1F1F1);
        _txtView.font = [UIFont systemFontOfSize:15];
        _txtView.textColor = [UIColor blackColor];
    }
    return _txtView;
}

- (UIButton *)submitBtn
{
    if(!_submitBtn){
        _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, _txtView.bottom+34, SCREEN_WIDTH-20, 40)];
        _submitBtn.layer.cornerRadius = 4;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_submitBtn setBackgroundImage:[UIImage imageWithColor:HEX_RGB(0x3684b5)] forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
@end
