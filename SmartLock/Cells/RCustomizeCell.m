//
//  RCustomizeCell.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/6.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RCustomizeCell.h"

NSString * const RCustomizeCellIdentifier = @"RCustomizeCellIdentifier";

@interface RCustomizeCell ()<UITextFieldDelegate>
@end


@implementation RCustomizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Getter
- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 17, 100, 17)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = HEX_RGB(0x555555);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)txtField
{
    if(!_txtField){
        _txtField = [[UITextField alloc] initWithFrame:CGRectMake(115, 17, SCREEN_WIDTH-130, 17)];
        _txtField.textColor = HEX_RGB(0x000000);
        _txtField.font = [UIFont systemFontOfSize:15];
        _txtField.textAlignment = NSTextAlignmentRight;
        _txtField.placeholder = @"请输入";
        _txtField.delegate = self;
        _txtField.returnKeyType = UIReturnKeyDone;
        [self addSubview:_txtField];
    }
    return _txtField;
}

- (UISwitch *)rswitch
{
    if(!_rswitch){
        _rswitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-66, 10, 51, 31)];
        _rswitch.onTintColor = COLOR_BAR;
        _rswitch.thumbTintColor = HEX_RGB(0xffffff);
        [self addSubview:_rswitch];
    }
    return _rswitch;
}
@end
