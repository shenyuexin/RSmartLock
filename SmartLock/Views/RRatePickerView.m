//
//  RRatePickerView.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/13.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RRatePickerView.h"

@interface RRatePickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@end

@implementation RRatePickerView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _cancelBtn.height = SCREEN_HEIGHT - 207;
        _contentView.height = 207;
        [_contentView addSubview:self.pickerView];
    
        _titleLabel.text = @"请选择认证频度";
        [_resetBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];

    }
    return self;
}

#pragma mark - Event
- (void)cancelClick
{
    [self dismissClick];
}

- (void)confirmClick
{
    self.rate = [self.pickerView selectedRowInComponent:0]+1;
    self.rateMode = ([self.pickerView selectedRowInComponent:1] + 1)*10;
    
    NSDictionary *dic = @{@(10):@"天",@(20):@"周",@(30):@"月"};
    self.rateString = [NSString stringWithFormat:@"%ld%@1次",self.rate,dic[@(self.rateMode)]];
    [self dismissClick];
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 31;
        case 1:
            return 3;
        case 2:
            return 1;
        default:
            return 0;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%ld",(long)(row+1)];
        case 1:{
            switch (row) {
                case 0:
                    return @"天";
                case 1:
                    return @"周";
                case 2:
                    return @"月";
                default:
                    return nil;
            }
        }
        case 2:
            return @"1次";
        default:
            return nil;
    }
}

#pragma mark - Getter
- (UIPickerView *)pickerView
{
    if(!_pickerView){
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _titleLabel.bottom, SCREEN_WIDTH, 165)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
@end
