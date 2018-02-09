//
//  RHomeCell.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/2.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RHomeCell.h"


NSString * const RHomeCellIdentifier = @"RHomeCellIdentifier";

@interface RHomeCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIImageView *stateImgView;
@property (nonatomic, strong) UILabel *usageLabel;
@property (nonatomic, strong) UILabel *usersLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation RHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLock:(RLockInfo *)lock
{
    _lock = lock;
    
    UIColor *tColor = nil;
    UIColor *nameColor = nil;
    if(_lock.enable){
        [_stateImgView removeFromSuperview];
        [self addSubview:self.stateLabel];
        
        self.imgView.image = [UIImage imageNamed:@"suo"];
        tColor = HEX_RGB(0X3DBA9C);
        nameColor = HEX_RGB(0X333333);
    }
    else{
        [_stateLabel removeFromSuperview];
        [self addSubview:self.stateImgView];

        self.imgView.image = [UIImage imageNamed:@"suo_hui"];
        tColor = HEX_RGB(0X999999);
        nameColor = HEX_RGB(0X333333);
    }
    
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n智能便携锁智",_lock.rid] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:nameColor}];
    [name addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13], NSForegroundColorAttributeName:HEX_RGB(0x777777)} range:NSMakeRange(name.length-6, 6)];
    self.nameLabel.attributedText = name;
    
    UIFont *font = [UIFont systemFontOfSize:14];
    UIFont *sfont = [UIFont systemFontOfSize:12];
    NSMutableAttributedString *stringa = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld\n累计开锁次数",_lock.usage_count] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:tColor}];
    [stringa addAttributes:@{NSFontAttributeName:sfont, NSForegroundColorAttributeName:HEX_RGB(0x777777)} range:NSMakeRange(stringa.length-6, 6)];
    self.usageLabel.attributedText = stringa;
    
    NSMutableAttributedString *stringb = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld\n当前使用人数",_lock.users] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:tColor}];
    [stringb addAttributes:@{NSFontAttributeName:sfont, NSForegroundColorAttributeName:HEX_RGB(0x777777)} range:NSMakeRange(stringb.length-6, 6)];
    self.usersLabel.attributedText = stringb;
    
    NSMutableAttributedString *stringc = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n下次自检时间",_lock.dateString] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:tColor}];
    [stringc addAttributes:@{NSFontAttributeName:sfont, NSForegroundColorAttributeName:HEX_RGB(0x777777)} range:NSMakeRange(stringc.length-6, 6)];
    self.dateLabel.attributedText = stringc;
}


#pragma mark - Getter
- (UIImageView *)imgView
{
    if(!_imgView){
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
        _imgView.image = [UIImage imageNamed:@"suo"];
        [self addSubview:_imgView];
    }
    return _imgView;
}

- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 150, 38)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.numberOfLines = 2;
        [self addSubview:_nameLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(65, 58.5, self.width-80, PX1)];
        line.backgroundColor = HEX_RGB(0xdddddd);
        [self addSubview:line];
    }
    return _nameLabel;
}

- (UILabel *)stateLabel
{
    if(!_stateLabel){
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-75, 15, 60, 16)];
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@" 使用中" attributes:@{NSForegroundColorAttributeName : HEX_RGB(0X4cc9b0),
                                                                                         NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
        attachment.bounds = CGRectMake(0, -2, 13, 16);
        attachment.image = [UIImage imageNamed:@"icon_safe"];
        [title insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
        _stateLabel.attributedText = title;
        [self addSubview:_stateLabel];
    }
    return _stateLabel;
}

- (UIImageView *)stateImgView
{
    if(!_stateImgView){
        _stateImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-66, 0, 66, 54)];
        _stateImgView.image = [UIImage imageNamed:@"icon_tingyong"];
    }
    return _stateImgView;
}

- (UILabel *)usageLabel
{
    if(!_usageLabel){
        _usageLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 67, (self.width-80)/3, 44)];
        _usageLabel.textAlignment = NSTextAlignmentLeft;
        _usageLabel.numberOfLines = 2;
        [self addSubview:_usageLabel];
    }
    return _usageLabel;
}

- (UILabel *)usersLabel
{
    if(!_usersLabel){
        _usersLabel = [[UILabel alloc] initWithFrame:CGRectMake(_usageLabel.right, 67, (self.width-80)/3, 44)];
        _usersLabel.textAlignment = NSTextAlignmentCenter;
        _usersLabel.numberOfLines = 2;
        [self addSubview:_usersLabel];
    }
    return _usersLabel;
}

- (UILabel *)dateLabel
{
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_usersLabel.right, 67, (self.width-80)/3, 44)];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.numberOfLines = 2;
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}
@end
