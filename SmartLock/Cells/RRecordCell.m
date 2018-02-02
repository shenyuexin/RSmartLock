//
//  RRecordCell.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/19.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RRecordCell.h"

NSString * const RRecordCellIdentifier = @"RRecordCellIdentifier";

@interface RRecordCell()

@end

@implementation RRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Getter
- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (self.height-16)/2, 160, 16)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = HEX_RGB(0x555555);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)rightLabel
{
    if(!_rightLabel){
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-120, (self.height-16)/2, 100, 16)];
        _rightLabel.font = [UIFont systemFontOfSize:15];
        _rightLabel.textColor = HEX_RGB(0x999999);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_rightLabel];
    }
    return _rightLabel;
}
@end
