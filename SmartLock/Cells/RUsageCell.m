//
//  RUsageCell.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/2.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RUsageCell.h"

NSString * const RUsageCellIdentifier = @"RUsageCellIdentifier";

@interface RUsageCell ()

@property (nonatomic, strong) UIView *conView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@end

@implementation RUsageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self addSubview:self.conView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecord:(RRecordInfo *)record
{
    _record = record;
    
    self.nameLabel.text = @"张三 2018-02-02 18:17:11";
    self.typeLabel.text = @"IC开锁";
    self.idLabel.text = @"身份证号: 331223388933311223333";
    self.phoneLabel.text = @"联系方式: 159575488004";
}


#pragma mark - Getter
- (UIView *)conView
{
    if(!_conView){
        _conView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 74)];
        _conView.backgroundColor = [UIColor whiteColor];
        _conView.layer.masksToBounds = YES;
        _conView.layer.cornerRadius = 4;
        
        [_conView addSubview:self.nameLabel];
        [_conView addSubview:self.typeLabel];
        [_conView addSubview:self.idLabel];
        [_conView addSubview:self.phoneLabel];
    }
    return _conView;
}

- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 10, _conView.width-100, 14)];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = HEX_RGB(0x222222);
    }
    return _nameLabel;
}

- (UILabel *)typeLabel
{
    if(!_typeLabel){
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_conView.width-90, 10, 80, 14)];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.textAlignment = NSTextAlignmentRight;
        _typeLabel.textColor = HEX_RGB(0x999999);
    }
    return _typeLabel;
}

- (UILabel *)idLabel
{
    if(!_idLabel){
        _idLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, _nameLabel.bottom+10, _conView.width-100, 14)];
        _idLabel.font = [UIFont systemFontOfSize:12];
        _idLabel.textAlignment = NSTextAlignmentLeft;
        _idLabel.textColor = HEX_RGB(0x999999);
    }
    return _idLabel;
}

- (UILabel *)phoneLabel
{
    if(!_phoneLabel){
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, _idLabel.bottom+3, _conView.width-100, 14)];
        _phoneLabel.font = [UIFont systemFontOfSize:12];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.textColor = HEX_RGB(0x999999);
    }
    return _phoneLabel;
}

@end
