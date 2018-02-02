//
//  RFingerPrintCell.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/22.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RFingerPrintCell.h"

NSString * const RFingerPrintCellIdentifier = @"RFingerPrintCellIdentifier";

@interface RFingerPrintCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *actionLabel;
@end

@implementation RFingerPrintCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.actionLabel.textColor = _enabled?HEX_RGB(0x297ce5):HEX_RGB(0xaaaaaa);
}

- (void)setRecord:(BOOL)record
{
    _record = record;
    self.stateLabel.text = _record?@"(已录制)":@"(未录制)";
    self.actionLabel.text = _record?@"更改":@"录制";
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.nameLabel.text = _title;
    [self.nameLabel sizeToFit];
    self.stateLabel.left = self.nameLabel.right + 10;
}

#pragma mark - Getter
- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (self.height-16)/2, 50, 16)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = HEX_RGB(0x333333);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)stateLabel
{
    if(!_stateLabel){
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, (self.height-16)/2, 100, 16)];
        _stateLabel.font = [UIFont systemFontOfSize:15];
        _stateLabel.textColor = HEX_RGB(0xaaaaaa);
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_stateLabel];
    }
    return _stateLabel;
}

- (UILabel *)actionLabel
{
    if(!_actionLabel){
        _actionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-130, (self.height-16)/2, 100, 16)];
        _actionLabel.font = [UIFont systemFontOfSize:15];
        _actionLabel.textColor = HEX_RGB(0x297ce5);
        _actionLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_actionLabel];
    }
    return _actionLabel;
}
@end
