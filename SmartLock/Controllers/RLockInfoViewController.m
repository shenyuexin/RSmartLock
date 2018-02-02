//
//  RLockInfoViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/2.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RLockInfoViewController.h"

@interface RLockInfoViewController ()

@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *usageLabel;
@property (nonatomic, strong) UILabel *usersLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *addressBtn;
@end

@implementation RLockInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"智能便携锁智";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.settingBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLock:(RLockInfo *)lock
{
    _lock = lock;
    
    UIColor *tColor = HEX_RGB(0X3DBA9C);
    
    UIFont *font = [UIFont systemFontOfSize:16];
    UIFont *sfont = [UIFont systemFontOfSize:12];
    NSMutableAttributedString *stringa = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d\n累计开锁次数",1000] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:tColor}];
    [stringa addAttributes:@{NSFontAttributeName:sfont, NSForegroundColorAttributeName:HEX_RGB(0x777777)} range:NSMakeRange(stringa.length-6, 6)];
    self.usageLabel.attributedText = stringa;
    
    NSMutableAttributedString *stringb = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d\n当前使用人数",1000] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:tColor}];
    [stringb addAttributes:@{NSFontAttributeName:sfont, NSForegroundColorAttributeName:HEX_RGB(0x777777)} range:NSMakeRange(stringb.length-6, 6)];
    self.usersLabel.attributedText = stringb;
    
    NSMutableAttributedString *stringc = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d\n下次自检时间",1000] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:tColor}];
    [stringc addAttributes:@{NSFontAttributeName:sfont, NSForegroundColorAttributeName:HEX_RGB(0x777777)} range:NSMakeRange(stringc.length-6, 6)];
    self.dateLabel.attributedText = stringc;
}


#pragma mark - Event
- (void)settingClick
{
    
}

- (void)addressClick
{
    
}

#pragma mark - Getter
- (UIButton *)settingBtn
{
    if(!_settingBtn){
        _settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 44)];
        _settingBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 15, 12, 3);
        [_settingBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchDown];
    }
    return _settingBtn;
}

- (UIView *)headView
{
    if(!_headView){
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 198)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        [_headView addSubview:self.imgView];
        [_headView addSubview:self.nameLabel];
        [_headView addSubview:self.stateLabel];
        [_headView addSubview:self.usageLabel];
        [_headView addSubview:self.usersLabel];
        [_headView addSubview:self.dateLabel];
        [_headView addSubview:self.addressBtn];
    }
    return _headView;
}

- (UIImageView *)imgView
{
    if(!_imgView){
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-45)/2, 15, 45, 45)];
        _imgView.image = [UIImage imageNamed:@"icon_greenfangsuo"];
    }
    return _imgView;
}

- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _imgView.bottom+7, SCREEN_WIDTH-20, 17)];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"SHP0022134";
    }
    return _nameLabel;
}

- (UILabel *)stateLabel
{
    if(!_stateLabel){
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width-75, 15, 60, 16)];
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@" 使用中" attributes:@{NSForegroundColorAttributeName : HEX_RGB(0X4cc9b0),
                                                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:13]}];
        NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
        attachment.bounds = CGRectMake(0, -2, 13, 16);
        attachment.image = [UIImage imageNamed:@"icon_safe"];
        [title insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
        _stateLabel.attributedText = title;
    }
    return _stateLabel;
}

- (UILabel *)usageLabel
{
    if(!_usageLabel){
        _usageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _nameLabel.bottom+15, (SCREEN_WIDTH-20)/3, 44)];
        _usageLabel.textAlignment = NSTextAlignmentLeft;
        _usageLabel.numberOfLines = 2;
    }
    return _usageLabel;
}

- (UILabel *)usersLabel
{
    if(!_usersLabel){
        _usersLabel = [[UILabel alloc] initWithFrame:CGRectMake(_usageLabel.right, _nameLabel.bottom+15, (SCREEN_WIDTH-20)/3, 44)];
        _usersLabel.textAlignment = NSTextAlignmentCenter;
        _usersLabel.numberOfLines = 2;
    }
    return _usersLabel;
}

- (UILabel *)dateLabel
{
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_usersLabel.right, _nameLabel.bottom+15, (SCREEN_WIDTH-20)/3, 44)];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.numberOfLines = 2;
    }
    return _dateLabel;
}

- (UIButton *)addressBtn
{
    if(!_addressBtn){
        _addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 108.5, SCREEN_WIDTH, 40)];
        _addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _addressBtn.backgroundColor = HEX_RGB(0xf7f7f7);
        _addressBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_addressBtn addTarget:self action:@selector(addressClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressBtn;
}
@end
