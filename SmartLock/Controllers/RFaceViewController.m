//
//  RFaceViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/24.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RFaceViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface RFaceViewController ()

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@end

@implementation RFaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fd_prefersNavigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.backBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter
- (UIButton *)backBtn
{
    if(!_backBtn){
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, __IPHONEX_?44:30, 32, 32)];
        [_backBtn setImage:[UIImage imageNamed:@"return_yuan"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIImageView *)imgView
{
    if(!_imgView){
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        CGFloat scale = [UIScreen mainScreen].scale;
        NSString *imgName = [NSString stringWithFormat:@"image_facerecogbg_%ld*%ld",(long)(SCREEN_WIDTH*scale),(long)(SCREEN_HEIGHT*scale)];
        _imgView.image = [UIImage imageNamed:imgName];
    }
    return _imgView;
}

- (UILabel *)tipLabel
{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, __IPHONEX_?50:32, self.view.width-30, 20)];
        _tipLabel.font = [UIFont systemFontOfSize:18];
        _tipLabel.textColor = HEX_RGB(0xffffff);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"张三";
    }
    return _tipLabel;
}

- (UILabel *)infoLabel
{
    if(!_infoLabel){
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tipLabel.bottom+5, self.view.width, 20)];
        _infoLabel.font = [UIFont systemFontOfSize:18];
        _infoLabel.textColor = HEX_RGB(0xcdcdcd);
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.text = @"身份证号：330331199311151033";
    }
    return _infoLabel;
}
@end
