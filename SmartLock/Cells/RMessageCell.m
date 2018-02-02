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
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSMutableParagraphStyle *labelStyle;
@end

@implementation RMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDate:(NSString *)date
{
    _date = date;
    
    CGFloat width = [_date sizeWithFont:self.dateLabel.font byHeight:self.dateLabel.height].width;
    self.dateLabel.text = _date;
    self.dateLabel.width = width + 20;
    self.dateLabel.left = (self.width - width -20)/2;
}

- (void)setContent:(NSString *)content
{
    _content = content;
    
    CGFloat height = [_content sizeWithFont:self.contentLabel.font byWidth:self.contentLabel.width-20].height;
    self.contentLabel.height = height + 30;
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:_content attributes:@{ NSParagraphStyleAttributeName : self.labelStyle}];
    _contentLabel.attributedText = attrText;
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
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (UILabel *)contentLabel
{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 42, self.width-30, 15)];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = HEX_RGB(0x333333);
        _contentLabel.backgroundColor = [UIColor whiteColor];
        _contentLabel.layer.cornerRadius = 4;
        _contentLabel.layer.masksToBounds = YES;
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
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
