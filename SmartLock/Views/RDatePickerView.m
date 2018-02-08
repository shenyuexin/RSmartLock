//
//  RDatePickerView.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/7.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RDatePickerView.h"
#import "UIView+BorderLine.h"
#import "NSDate+BeeExtension.h"

@interface RDatePickerView ()<UITextFieldDelegate>
{
    UITextField *_curTextField;
}
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextField *beginTextField;
@property (nonatomic, strong) UITextField *endTextField;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation RDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)show
{
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.top = SCREEN_HEIGHT - 356;
    } completion:^(BOOL finished) {
        [self addSubview:self.cancelBtn];
    }];
}

#pragma mark - Event
- (void)resetClick
{
    
}

- (void)confirmClick
{
    
}

- (void)cancelClick
{
    [self.cancelBtn removeFromSuperview];
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dateChange:(UIDatePicker *)picker
{
    NSDate *date = picker.date;
    _curTextField.text = [date stringWithDateFormat:@"yyyy-MM-dd"];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _curTextField = textField;
    [_curTextField setLineColor:HEX_RGB(0x3dba9c)];
    
    if(_curTextField == self.beginTextField){
        [self.endTextField setLineColor:HEX_RGB(0xdddddd)];
    }
    else{
        [self.beginTextField setLineColor:HEX_RGB(0xdddddd)];
    }
    return NO;
}

#pragma mark - Getter
- (UIButton *)cancelBtn
{
    if(!_cancelBtn){
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-356)];
        _cancelBtn.backgroundColor = HEX_RGBA(0x000000, 0.5);
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIView *)contentView
{
    if(!_contentView){
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 356)];
        _contentView.backgroundColor = [UIColor whiteColor];
        
        [_contentView addSubview:self.titleLabel];
        [_contentView addSubview:self.resetBtn];
        [_contentView addSubview:self.confirmBtn];
        
        [_contentView addSubview:self.tipLabel];
        [_contentView addSubview:self.beginTextField];
        [_contentView addSubview:self.endTextField];
        [_contentView addSubview:self.datePicker];
    }
    return _contentView;
}

- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = HEX_RGB(0x666666);
        _titleLabel.text = @"请选择开锁有效期";
        [_titleLabel addBorderLine:BorderBottom];
    }
    return _titleLabel;
}

- (UIButton *)resetBtn
{
    if(!_resetBtn){
        _resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 44, 46)];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:HEX_RGB(0x666666) forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_resetBtn addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

- (UIButton *)confirmBtn
{
    if(!_confirmBtn){
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-54, 0, 44, 46)];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:HEX_RGB(0x3dba9c) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UILabel *)tipLabel
{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 35)];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = HEX_RGB(0x666666);
        _tipLabel.text = @"至";
    }
    return _tipLabel;
}

- (UITextField *)beginTextField
{
    if(!_beginTextField){
        _beginTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 70, (SCREEN_WIDTH-30-50)/2, 35)];
        _beginTextField.font = [UIFont systemFontOfSize:15];
        _beginTextField.textColor = HEX_RGB(0x3dba9c);
        _beginTextField.borderStyle = UITextBorderStyleNone;
        _beginTextField.placeholder = @"开始时间";
        _beginTextField.delegate = self;
        _beginTextField.textAlignment = NSTextAlignmentCenter;
        [_beginTextField addBorderLine:BorderBottom];
    }
    return _beginTextField;
}

- (UITextField *)endTextField
{
    if(!_endTextField){
        _endTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - (SCREEN_WIDTH-30-50)/2 -15, 70, (SCREEN_WIDTH-30-50)/2, 35)];
        _endTextField.font = [UIFont systemFontOfSize:15];
        _endTextField.textColor = HEX_RGB(0x3dba9c);
        _endTextField.borderStyle = UITextBorderStyleNone;
        _endTextField.placeholder = @"结束时间";
        _endTextField.delegate = self;
        _endTextField.textAlignment = NSTextAlignmentCenter;
        [_endTextField addBorderLine:BorderBottom];
    }
    return _endTextField;
}

- (UIDatePicker *)datePicker
{
    if(!_datePicker){
        _datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 216)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}
@end
