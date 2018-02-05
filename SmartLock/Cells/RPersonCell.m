//
//  RPersonCell.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/5.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RPersonCell.h"
#import "UIView+BorderLine.h"

NSString * const RPersonCellIdentifier = @"RPersonCellIdentifier";

@interface RPersonCell ()

@property (nonatomic, strong) UIView *conView;
@property (nonatomic, strong) UIView *topBgView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UIButton *enableBtn;
@property (nonatomic, strong) UIButton *disableBtn;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *recordsBtn;
@end

@implementation RPersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor =  RGB(235, 235, 241);
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

- (void)setPerson:(RPersonInfo *)person
{
    _person = person;
    
    if(_person.enable){
        [self.conView addSubview:self.disableBtn];
        [self.conView addSubview:self.editBtn];
        [self.conView addSubview:self.recordsBtn];
        
        self.disableBtn.frame = CGRectMake(0, 103, (SCREEN_WIDTH-20)/3, 39);
        self.editBtn.frame = CGRectMake(self.disableBtn.right, 103, (SCREEN_WIDTH-20)/3, 39);
        self.recordsBtn.frame = CGRectMake(self.editBtn.right, 103, (SCREEN_WIDTH-20)/3, 39);
    }
    else{
        [self.conView addSubview:self.enableBtn];
        [self.conView addSubview:self.recordsBtn];
        
        self.enableBtn.frame = CGRectMake(0, 103, (SCREEN_WIDTH-20)/2, 39);
        self.recordsBtn.frame = CGRectMake(self.editBtn.right, 103, (SCREEN_WIDTH-20)/2, 39);
    }
    
    self.dateLabel.text = @"2018-02-05 至 2019-02-05";
    [self.dateLabel sizeToFit];
    self.nameLabel.text = @"张三";
    self.typeLabel.text = @"IC开锁";
    self.idLabel.text = @"身份证号: 331223388933311223333";
    self.phoneLabel.text = @"联系方式: 159575488004";
}

#pragma mark - Event
- (void)enableClick
{
    
}

- (void)disableClick
{
    
}

- (void)editClick
{
    
}

- (void)recordsClick
{
    
}

#pragma mark - Getter
- (UIView *)conView
{
    if(!_conView){
        _conView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 142)];
        _conView.backgroundColor = [UIColor whiteColor];
        _conView.layer.masksToBounds = YES;
        _conView.layer.cornerRadius = 4;
        
        [_conView addSubview:self.topBgView];
        [_conView addSubview:self.dateLabel];
        [_conView addSubview:self.nameLabel];
        [_conView addSubview:self.typeLabel];
        [_conView addSubview:self.idLabel];
        [_conView addSubview:self.phoneLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 103-PX1, SCREEN_WIDTH-50, PX1)];
        lineView.backgroundColor = HEX_RGB(0xdddddd);
        [_conView addSubview:lineView];
    }
    return _conView;
}

- (UIView *)topBgView
{
    if(!_topBgView){
        _topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 33)];
        _topBgView.backgroundColor = HEX_RGB(0xf9f9f9);
    }
    return _topBgView;
}

- (UILabel *)dateLabel
{
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 8, 100, 14)];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.textColor = HEX_RGB(0x999999);
    }
    return _dateLabel;
}

- (UILabel *)typeLabel
{
    if(!_typeLabel){
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_conView.width-114, 8, 100, 14)];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.textAlignment = NSTextAlignmentRight;
        _typeLabel.textColor = HEX_RGB(0x999999);
    }
    return _typeLabel;
}

- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _topBgView.bottom+10, 49, 49)];
        _nameLabel.layer.cornerRadius = 24.5;
        _nameLabel.layer.masksToBounds = YES;
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = HEX_RGB(0x333333);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _nameLabel.backgroundColor = HEX_RGB(0xeeeeee);
    }
    return _nameLabel;
}

- (UILabel *)idLabel
{
    if(!_idLabel){
        _idLabel = [[UILabel alloc] initWithFrame:CGRectMake(79, _topBgView.bottom+12, _conView.width-100, 14)];
        _idLabel.font = [UIFont systemFontOfSize:13];
        _idLabel.textAlignment = NSTextAlignmentLeft;
        _idLabel.textColor = HEX_RGB(0x666666);
    }
    return _idLabel;
}

- (UILabel *)phoneLabel
{
    if(!_phoneLabel){
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(79, _idLabel.bottom+3, _conView.width-100, 14)];
        _phoneLabel.font = [UIFont systemFontOfSize:13];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.textColor = HEX_RGB(0x666666);
    }
    return _phoneLabel;
}

- (UIButton *)enableBtn
{
    if(!_enableBtn){
        _enableBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width/2, 39)];
        [_enableBtn setTitle:@"启用" forState:UIControlStateNormal];
        [_enableBtn setTitleColor:HEX_RGB(0x53aca9) forState:UIControlStateNormal];
        _enableBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_enableBtn addTarget:self action:@selector(enableClick) forControlEvents:UIControlEventTouchDown];
    }
    return _enableBtn;
}

- (UIButton *)disableBtn
{
    if(!_disableBtn){
        _disableBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width/2, 39)];
        [_disableBtn setTitle:@"禁用" forState:UIControlStateNormal];
        [_disableBtn setTitleColor:HEX_RGB(0xe97777) forState:UIControlStateNormal];
        _disableBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_disableBtn addTarget:self action:@selector(disableClick) forControlEvents:UIControlEventTouchDown];
    }
    return _disableBtn;
}

- (UIButton *)editBtn
{
    if(!_editBtn){
        _editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width/2, 39)];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:HEX_RGB(0x53aca9) forState:UIControlStateNormal];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_editBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchDown];
        [_editBtn addBorderLine:BorderLeft withHeight:17];
    }
    return _editBtn;
}

- (UIButton *)recordsBtn
{
    if(!_recordsBtn){
        _recordsBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width/2, 39)];
        [_recordsBtn setTitle:@"使用记录" forState:UIControlStateNormal];
        [_recordsBtn setTitleColor:HEX_RGB(0x53aca9) forState:UIControlStateNormal];
        _recordsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_recordsBtn addTarget:self action:@selector(recordsClick) forControlEvents:UIControlEventTouchDown];
        [_recordsBtn addBorderLine:BorderLeft withHeight:17];
    }
    return _recordsBtn;
}
@end
