//
//  RMessageCell.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/19.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RMessageCell.h"

NSString * const RMessageCellIdentifier = @"RMessageCellIdentifier";

@interface RMessageCell()
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSMutableParagraphStyle *labelStyle;
@end

@implementation RMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self addSubview:self.dateLabel];
        [self addSubview:self.labelView];
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

- (void)setMessage:(RMessageInfo *)message
{
    _message = message;
    
    CGFloat width = [_message.dateString sizeWithFont:self.dateLabel.font byHeight:self.dateLabel.height].width;
    self.dateLabel.text = _message.dateString;
    self.dateLabel.width = width + 20;
    self.dateLabel.left = (self.width - width -20)/2;
    
    self.titleLabel.text = _message.title;

    CGFloat height = [_message.content sizeWithFont:self.contentLabel.font byWidth:self.contentLabel.width-20].height;
    self.contentLabel.height = height;

    self.labelView.height = self.contentLabel.bottom + 20;
}

#pragma mark - Getter
- (UILabel *)dateLabel
{
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.width, 22)];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.backgroundColor = HEX_RGB(0xD4D4D4);
        _dateLabel.layer.cornerRadius = 4;
        _dateLabel.layer.masksToBounds = YES;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}

- (UIView *)labelView
{
    if(!_labelView){
        _labelView = [[UIView alloc] initWithFrame:CGRectMake(15, 42, self.width-30, 30)];
        _labelView.backgroundColor = [UIColor whiteColor];
        _labelView.layer.cornerRadius = 4;
        _labelView.layer.masksToBounds = YES;
        
        [_labelView addSubview:_titleLabel];
        [_labelView addSubview:_contentLabel];
    }
    return _labelView;
}

- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, self.width-30, 17)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HEX_RGB(0x333333);
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, self.width-30, 14)];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textColor = HEX_RGB(0x666666);
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (NSMutableParagraphStyle *)labelStyle
{
    if(!_labelStyle){
        _labelStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        _labelStyle.alignment = NSTextAlignmentJustified;
        _labelStyle.firstLineHeadIndent = 10.0f;
        _labelStyle.headIndent = 10.0f;
        _labelStyle.tailIndent = -10.0f;
    }
    return _labelStyle;
}
@end
