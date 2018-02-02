//
//  RHomeContentView.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/19.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RHomeContentView.h"
#import "RHomeContentCell.h"
#import "WBMediator.h"
#import "UIView+BorderLine.h"

@interface RHomeContentView()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) RHomeContentCell *pwdCell;
@property (nonatomic, strong) RHomeContentCell *fingerCell;
@property (nonatomic, strong) RHomeContentCell *icCell;

@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, strong) UILabel *recordLabel;
@property (nonatomic, strong) UIImageView *indicatorImgView;
@end

@implementation RHomeContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.imgView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.lineLabel];
        
        [self addSubview:self.pwdCell];
        [self addSubview:self.fingerCell];
        [self addSubview:self.icCell];
        
        [self addSubview:self.bottomBtn];
    }
    return self;
}

#pragma mark - Event
- (void)pwdClick
{
    
}

- (void)fingerClick
{
    [[WBMediator sharedManager] gotoFingerPrintController];
}

- (void)icClick
{
    [[WBMediator sharedManager] gotoICController];
}

- (void)bottomClick
{
    [[WBMediator sharedManager] gotoRecordsController];
}

#pragma mark - Getter
- (UIImageView *)imgView
{
    if(!_imgView){
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-45)/2, 20, 45, 45)];
        _imgView.image = [UIImage imageNamed:@"suo"];
    }
    return _imgView;
}

- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgView.bottom+10, self.width, 17)];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = HEX_RGB(0x333333);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"智能便携锁";
    }
    return _nameLabel;
}

- (UILabel *)dateLabel
{
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.bottom+2, self.width, 16)];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textColor = HEX_RGB(0x999999);
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.text = @"2018-01-19 至 2018-12-31";
    }
    return _dateLabel;
}

- (UILabel *)lineLabel
{
    if(!_lineLabel){
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.nameLabel.bottom+37, self.width-30, 2)];
        _lineLabel.font = [UIFont systemFontOfSize:12];
        _lineLabel.textColor = HEX_RGB(0x979797);
        _lineLabel.lineBreakMode = NSLineBreakByClipping;
        _lineLabel.text = @"---------------------------------------------------------------------------";
    }
    return _lineLabel;
}

- (RHomeContentCell *)pwdCell
{
    if(!_pwdCell){
        _pwdCell = [[RHomeContentCell alloc] initWithFrame:CGRectMake(0, self.lineLabel.bottom+34, self.width, 84)];
        _pwdCell.txtLabel.text = @"密码开锁";
        _pwdCell.subTitleLabel.text = @"超时更改密码需要验证人脸";
        _pwdCell.rightLabel.text = @"123456";
        [_pwdCell addTarget:self action:@selector(pwdClick) forControlEvents:UIControlEventTouchDown];
    }
    return _pwdCell;
}

- (RHomeContentCell *)fingerCell
{
    if(!_fingerCell){
        _fingerCell = [[RHomeContentCell alloc] initWithFrame:CGRectMake(0, self.pwdCell.bottom, self.width, 84)];
        _fingerCell.txtLabel.text = @"指纹开锁";
        _fingerCell.subTitleLabel.text = @"超时更改指纹需要验证人脸";
        [_fingerCell setRightImage:[UIImage imageNamed:@"icon_greenfinprint"] disableImage:[UIImage imageNamed:@"icon_grayfinprint"]];
        [_fingerCell addTarget:self action:@selector(fingerClick) forControlEvents:UIControlEventTouchDown];
        [_fingerCell addBorderLine:BorderTop withWidth:self.width-38];
        _fingerCell.imgView.frame = CGRectMake(self.width-97, 23.5, 55, 37);
    }
    return _fingerCell;
}

- (RHomeContentCell *)icCell
{
    if(!_icCell){
        _icCell = [[RHomeContentCell alloc] initWithFrame:CGRectMake(0, self.fingerCell.bottom, self.width, 84)];
        _icCell.txtLabel.text = @"IC卡开锁";
        _icCell.subTitleLabel.text = @"将身份证靠在门锁上即可开锁";
        [_icCell setRightImage:[UIImage imageNamed:@"icon_greencard"] disableImage:[UIImage imageNamed:@"icon_graycard"]];
        [_icCell addTarget:self action:@selector(icClick) forControlEvents:UIControlEventTouchDown];
        [_icCell addBorderLine:BorderTop withWidth:self.width-38];
        _icCell.imgView.frame = CGRectMake(self.width-97, 23.5, 55, 37);
    }
    return _icCell;
}

- (UIButton *)bottomBtn
{
    if(!_bottomBtn){
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height-55, self.width, 55)];
        _bottomBtn.backgroundColor = HEX_RGB(0xfafafa);
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _bottomBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_bottomBtn setTitle:@"开锁记录" forState:UIControlStateNormal];
        [_bottomBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [_bottomBtn setTitleColor:HEX_RGB(0x333333) forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(bottomClick) forControlEvents:UIControlEventTouchDown];
        
        [_bottomBtn addSubview:self.recordLabel];
        [_bottomBtn addSubview:self.indicatorImgView];
    }
    return _bottomBtn;
}

- (UILabel *)recordLabel
{
    if(!_recordLabel){
        _recordLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-200, 20, 170, 14)];
        _recordLabel.font = [UIFont systemFontOfSize:13];
        _recordLabel.textColor = HEX_RGB(0x999999);
        _recordLabel.textAlignment = NSTextAlignmentRight;
        _recordLabel.text = @"今天 17:56 手动开锁";
    }
    return _recordLabel;
}

- (UIImageView *)indicatorImgView
{
    if(!_indicatorImgView){
        _indicatorImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-25, 21.5, 7, 12)];
        _indicatorImgView.image = [UIImage imageNamed:@"more"];
    }
    return _indicatorImgView;
}
@end
