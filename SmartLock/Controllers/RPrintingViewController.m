//
//  RPrintingViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/23.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RPrintingViewController.h"

@interface RPrintingViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIButton *cancelBtn;
@end

@implementation RPrintingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.imgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event
- (void)cancelClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter
- (UIImageView *)imgView
{
    if(!_imgView){
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width-80)/2, (self.view.height-81)/2+81, 80, 81)];
        _imgView.image = [UIImage imageNamed:@"zhiwen_big"];
    }
    return _imgView;
}

- (UILabel *)tipLabel
{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90+(__IPHONEX_?44:0), self.view.width, 24)];
        _tipLabel.font = [UIFont systemFontOfSize:24];
        _tipLabel.textColor = HEX_RGB(0x000000);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"指纹录制中";
    }
    return _tipLabel;
}

- (UILabel *)infoLabel
{
    if(!_infoLabel){
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tipLabel.bottom+15, self.view.width, 40)];
        _infoLabel.font = [UIFont systemFontOfSize:16];
        _infoLabel.textColor = HEX_RGB(0x333333);
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.numberOfLines = 2;
        _infoLabel.text = @"请将手指放置在门锁的指纹识别区域\n待门锁识别结束后再移开手指";
    }
    return _infoLabel;
}

- (UIButton *)cancelBtn
{
    if(!_cancelBtn){
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width-70, 20, 70, 44)];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:HEX_RGB(0x297ce5) forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
@end
