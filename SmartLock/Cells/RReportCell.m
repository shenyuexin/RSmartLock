//
//  RReportCell.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/17.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RReportCell.h"

NSString * const RReportCellIdentifier = @"RReportCellIdentifier";

@interface RReportCell()
@end

@implementation RReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    self.imgView.hidden = !selected;
}


#pragma mark - Getter
- (UIImageView *)imgView
{
    if(!_imgView){
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14.5, 20, 14)];
        _imgView.image = [UIImage imageNamed:@"selected"];
        _imgView.hidden = YES;
        [self addSubview:_imgView];
    }
    return _imgView;
}

- (UILabel *)txtLabel
{
    if(!_txtLabel){
        _txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, (self.height-15)/2, self.width-45, 15)];
        _txtLabel.font = [UIFont systemFontOfSize:15];
        _txtLabel.textColor = HEX_RGB(0x333333);
        [self addSubview:_txtLabel];
    }
    return _txtLabel;
}

@end
