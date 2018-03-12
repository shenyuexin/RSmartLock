//
//  RConfigureView.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/15.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RConfigureView.h"
#import "UIImage+Color.h"
#import "WBMediator.h"
#import "RBlueToothManager.h"


@interface RConfigureTextField : UITextField
@end

@implementation RConfigureTextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    bounds.origin.x +=  10;
    bounds.size.width -= 60;
    return bounds;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    bounds.origin.x +=  10;
    bounds.size.width -= 60;
    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    bounds.origin.x +=  10;
    bounds.size.width -= 60;
    return bounds;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    return CGRectMake(self.width - 70, (self.height-14)/2, 14, 14);
}

@end


@interface RConfigureView ()

@property (nonatomic, strong) UIImageView *stateImgView;

@property (nonatomic, strong) UIButton *tipBtn;
@property (nonatomic, strong) RConfigureTextField *txtField;
@property (nonatomic, strong) UIButton *scanBtn;
@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation RConfigureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.stateImgView];
        [self addSubview:self.tipBtn];
        [self addSubview:self.txtField];
        [self addSubview:self.submitBtn];
        [self addSubview:self.tipLabel];
        
        [self updateBlueToothState];
    }
    return self;
}

- (void)updateBlueToothState
{
    BOOL isConnected = NO;
    NSMutableAttributedString *title = nil;
    UIImage *stateImg = nil;
    if(isConnected){
        title = [[NSMutableAttributedString alloc] initWithString:@"请先确保蓝牙已打开>" attributes:@{NSForegroundColorAttributeName : HEX_RGB(0Xe95050),
                                                                                      NSFontAttributeName : [UIFont systemFontOfSize:16]}];
        stateImg = [UIImage imageNamed:@"lanya"];
    }
    else{
        title = [[NSMutableAttributedString alloc] initWithString:@" 蓝牙已打开" attributes:@{NSForegroundColorAttributeName : HEX_RGB(0X333333),
                                                                                      NSFontAttributeName : [UIFont systemFontOfSize:16]}];

        NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
        attachment.bounds = CGRectMake(0, -2, 17, 17);
        attachment.image = [UIImage imageNamed:@"right_lv"];
        [title insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
        
        stateImg = [UIImage imageNamed:@"lanya_lv"];
    }
    [_tipBtn setAttributedTitle:title forState:UIControlStateNormal];
    self.stateImgView.image = stateImg;
}

#pragma mark - Event
- (void)tipClick
{
    
}

- (void)scanClick
{
    [[WBMediator sharedManager] gotoQRCodeController];
}

- (void)submitClick
{
    [RBlueToothManager manager].isConnected = YES;
}

#pragma mark - Getter
- (UIImageView *)stateImgView
{
    if(!_stateImgView){
        _stateImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-45)/2, 50, 45, 59)];
    }
    return _stateImgView;
}

- (UIButton *)tipBtn
{
    if(!_tipBtn){
        _tipBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.stateImgView.bottom+25, self.width, 20)];
        _tipBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_tipBtn addTarget:self action:@selector(tipClick) forControlEvents:UIControlEventTouchDown];
    }
    return _tipBtn;
}

- (UITextField *)txtField
{
    if(!_txtField){
        _txtField = [[RConfigureTextField alloc] initWithFrame:CGRectMake(28, self.tipBtn.bottom+31, self.width-56, 35)];
        _txtField.layer.cornerRadius = 4;
        _txtField.layer.borderColor = HEX_RGB(0x5ebdb3).CGColor;
        _txtField.layer.borderWidth = 1;
        _txtField.clipsToBounds = YES;
        _txtField.rightViewMode = UITextFieldViewModeAlways;
        _txtField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入锁序号认证" attributes:@{NSForegroundColorAttributeName : HEX_RGB(0X73bab0),
                                                                                                      NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        
        [_txtField addSubview:self.scanBtn];
    }
    return _txtField;
}

- (UIButton *)scanBtn
{
    if(!_scanBtn){
        _scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-56-45, 0, 45, 35)];
        _scanBtn.backgroundColor = HEX_RGB(0x12c6b3);
        [_scanBtn setImage:[UIImage imageNamed:@"saoyisao"] forState:UIControlStateNormal];
        [_scanBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
        [_scanBtn addTarget:self action:@selector(scanClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanBtn;
}

- (UIButton *)submitBtn
{
    if(!_submitBtn){
        _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 240, self.width-52, 35)];
        _submitBtn.layer.cornerRadius = 4;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_submitBtn setBackgroundImage:[UIImage imageWithColor:HEX_RGB(0x12c6b3)] forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"立即认证" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (UILabel *)tipLabel
{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-55, self.width, 55)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = HEX_RGB(0X999999);
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.backgroundColor = HEX_RGB(0XF6F6F6);
        _tipLabel.text = @"输入锁序号或者扫码完成认证过程";
    }
    return _tipLabel;
}
@end
