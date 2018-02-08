//
//  RLoginViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/12.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RLoginViewController.h"
#import "WBLoginTextField.h"
#import "WBLoginButton.h"
#import "WBAPIManager+Bussiness.h"

@interface RLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *topBgImgView;
@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) WBPhoneTextField *phoneTextField;
@property (nonatomic, strong) WBCodeTextField *codeTextField;
@property (nonatomic, strong) WBLoginButton *loginBtn;
@end

@implementation RLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.topBgImgView];
    [self.view addSubview:self.logoImgView];
    [self.view addSubview:self.nameLabel];
    
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.loginBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event
- (void)hideKeyBoard
{
//    self.logoImgView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.top = 0;
        [self.view endEditing:YES];
    }];
}

- (void)loginClick:(UIButton *)sender
{
//    if(![self.phoneTextField.text isTelephone]){
//        [WBLoadingView showErrorStatus:@"请输入11位有效手机号码"];
//        return;
//    }
//
//    if(![self.codeTextField.text isVerifyCode]){
//        [WBLoadingView showErrorStatus:@"请输入6位验证码"];
//        return;
//    }
    
    [self hideKeyBoard];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    if(textField == _phoneTextField){
//        [_pwdTextField becomeFirstResponder];
        return YES;
//    }
//    else{
//        if([_phoneTextField.text isNotEmpty] && [_pwdTextField.text isNotEmpty]){
//            [self loginClick:nil];
//            return YES;
//        }
//        else{
//            return NO;
//        }
//    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.view.top = - 130;
//        self.bottomView.top = SCREEN_HEIGHT - 270 + 130;
//    } completion:^(BOOL finished) {
//        self.logoImgView.hidden = YES;
//    }];
    return YES;
}

#pragma mark - Getter
- (UIImageView *)topBgImgView
{
    if(!_topBgImgView){
        _topBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375*224)];
        _topBgImgView.image = [UIImage imageNamed:@"background"];
    }
    return _topBgImgView;
}

- (UIImageView *)logoImgView
{
    if(!_logoImgView){
        _logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2, self.topBgImgView.top+100, 70, 70)];
        _logoImgView.image = [UIImage imageNamed:@"logosmall"];
    }
    return _logoImgView;
}

- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.logoImgView.bottom+13, SCREEN_WIDTH, 14)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = HEX_RGB(0x333333);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"智能锁管理系统(管理端)";
    }
    return _nameLabel;
}

- (WBPhoneTextField *)phoneTextField
{
    if(!_phoneTextField){
        _phoneTextField = [[WBPhoneTextField alloc] initWithFrame:CGRectMake(25, self.nameLabel.bottom+79, SCREEN_WIDTH-50, 48)];
        _phoneTextField.placeholder = @"手机号";
        _phoneTextField.returnKeyType = UIReturnKeyNext;
        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}

- (WBCodeTextField *)codeTextField
{
    if(!_codeTextField){
        _codeTextField = [[WBCodeTextField alloc] initWithFrame:CGRectMake(self.phoneTextField.left, self.phoneTextField.bottom+10, self.phoneTextField.width-85, self.phoneTextField.height)];
        _codeTextField.placeholder = @"验证码";
        _codeTextField.rightPresentView = self.view;
        _codeTextField.phoneTextfield = _phoneTextField;
        _codeTextField.needRegister = YES;
    }
    return _codeTextField;
}

- (WBLoginButton *)loginBtn
{
    if(!_loginBtn){
        _loginBtn = [[WBLoginButton alloc] initWithFrame:CGRectMake(self.phoneTextField.left, self.codeTextField.bottom+24, self.phoneTextField.width, 40)];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
@end
