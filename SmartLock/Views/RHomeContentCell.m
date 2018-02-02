//
//  RHomeContentCell.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/17.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RHomeContentCell.h"

@interface RHomeContentCell ()
@property (nonatomic, strong) UIImage *rightImg;
@property (nonatomic, strong) UIImage *disRightImg;
@property (nonatomic, strong) UIImageView *indicatorImgView;
@end

@implementation RHomeContentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.txtLabel];
        [self addSubview:self.subTitleLabel];
        [self addSubview:self.indicatorImgView];
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if(enabled){
        _txtLabel.textColor = HEX_RGB(0x4fb1a7);
        _rightLabel.textColor = HEX_RGB(0x333333);
        
        _imgView.image = _rightImg;

    }
    else{
        _txtLabel.textColor = HEX_RGB(0xaaaaaa);
        _rightLabel.textColor = HEX_RGB(0xaaaaaa);
        
        _imgView.image = _disRightImg;
    }
}

- (void)setRightImage:(UIImage *)image disableImage:(UIImage *)disableImg
{
    self.imgView.image = image;
    
    self.rightImg = image;
    self.disRightImg = disableImg;
    
    [self addSubview:self.imgView];
}

#pragma mark - Getter
- (UILabel *)txtLabel
{
    if(!_txtLabel){
        _txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, 21, 200, 20)];
        _txtLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    }
    return _txtLabel;
}

- (UILabel *)subTitleLabel
{
    if(!_subTitleLabel){
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, self.txtLabel.bottom+2, 200, 20)];
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        _subTitleLabel.textColor = HEX_RGB(0xaaaaaa);
    }
    return _subTitleLabel;
}

- (UILabel *)rightLabel
{
    if(!_rightLabel){
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-125, (self.height-28)/2, 100, 28)];
        _rightLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightMedium];
        [self addSubview:_rightLabel];
    }
    return _rightLabel;
}

- (UIImageView *)imgView
{
    if(!_imgView){
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(19, 0, 100, 20)];
    }
    return _imgView;
}

- (UIImageView *)indicatorImgView
{
    if(!_indicatorImgView){
        _indicatorImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-25, (self.height-12)/2, 7, 12)];
        _indicatorImgView.image = [UIImage imageNamed:@"more"];
    }
    return _indicatorImgView;
}
@end
