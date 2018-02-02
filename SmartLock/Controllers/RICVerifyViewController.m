//
//  RICVerfyViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/23.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RICVerifyViewController.h"

@interface RICVerifyViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@end

@implementation RICVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"身份验证";
    self.view.backgroundColor = COLOR_BAR;
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:[WBMediator sharedManager] selector:@selector(gotoFaceController) userInfo:nil repeats:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.imgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter
- (UIImageView *)imgView
{
    if(!_imgView){
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width-200)/2, 50, 200, 272)];
        _imgView.image = [UIImage imageNamed:@"shuaka"];
    }
    return _imgView;
}

- (UILabel *)tipLabel
{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgView.bottom+69, self.view.width, 22)];
        _tipLabel.font = [UIFont systemFontOfSize:20];
        _tipLabel.textColor = HEX_RGB(0xffffff);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"请用身份证贴靠门锁";
    }
    return _tipLabel;
}

- (UILabel *)infoLabel
{
    if(!_infoLabel){
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tipLabel.bottom+10, self.view.width, 20)];
        _infoLabel.font = [UIFont systemFontOfSize:17];
        _infoLabel.textColor = HEX_RGB(0xffffff);
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.text = @"识别的过程中请不要移动身份证";
    }
    return _infoLabel;
}
@end
