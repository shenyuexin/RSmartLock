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
        [_contentView addSubview:self.tipLabel];
        [_contentView addSubview:self.beginTextField];
        [_contentView addSubview:self.endTextField];
        
        _titleLabel.text = @"请选择开锁有效期";
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    return self;
}

- (void)showInView:(UIView *)superview
{    
    [super showInView:superview];
    if(self.beginDateString){
        self.datePicker.date = [NSDate dateWithYYYYMMDDString:self.beginDateString];
        [_contentView addSubview:self.datePicker];
    }
}

#pragma mark - Event
- (void)cancelClick
{
    self.beginTextField.text = nil;
    self.endTextField.text = nil;
}

- (void)confirmClick
{
    NSDate *beginDate = [NSDate dateWithString:self.beginTextField.text];
    NSDate *endDate = [NSDate dateWithString:self.endTextField.text];
    if([beginDate compare:endDate] == NSOrderedDescending){
        [WBLoadingView showErrorStatus:@"开始时间不能大于结束时间"];
        return;
    }
    
    self.beginDateString = self.beginTextField.text;
    self.endDateString = self.endTextField.text;
    [self dismissClick];
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
        if(self.beginDateString){
            self.datePicker.date = [NSDate dateWithYYYYMMDDString:self.beginDateString];
        }
        else{
            self.beginTextField.text = [[NSDate date] stringWithDateFormat:@"yyyy-MM-dd"];
        }
    }
    else{
        [self.beginTextField setLineColor:HEX_RGB(0xdddddd)];
        
        if(self.endDateString){
            self.datePicker.date = [NSDate dateWithYYYYMMDDString:self.endDateString];
        }
        else{
            self.endTextField.text = [[NSDate date] stringWithDateFormat:@"yyyy-MM-dd"];
        }
    }
    
    if(!self.datePicker.superview){
        [_contentView addSubview:self.datePicker];
    }

    return NO;
}

#pragma mark - Getter
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
