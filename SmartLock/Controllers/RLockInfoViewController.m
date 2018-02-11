//
//  RLockInfoViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/2.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RLockInfoViewController.h"
#import "RUsageCell.h"
#import "UIImage+Color.h"
#import "WBSearchBar.h"

@interface RLockInfoViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *usageLabel;
@property (nonatomic, strong) UILabel *usersLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *addressBtn;
@property (nonatomic, strong) WBSearchBar *searchBar;
@property (nonatomic, strong) UIButton *datePickBtn;

@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIButton *uploadBtn;
@end

@implementation RLockInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"智能便携锁智";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.settingBtn];
    
    self.tableView.rowHeight = 74;
    [self.tableView registerClass:[RUsageCell class] forCellReuseIdentifier:RUsageCellIdentifier];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    self.footView.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.tableView];
}

- (void)setLock:(RLockInfo *)lock
{
    _lock = lock;
    
    UIColor *tColor = HEX_RGB(0X3DBA9C);
    UIFont *font = [UIFont systemFontOfSize:16];
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
    
    NSMutableAttributedString *btnTitle = nil;
    if(_lock.address.isNotEmpty){
        btnTitle = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",_lock.address] attributes:@{NSForegroundColorAttributeName:HEX_RGB(0xe999999),NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    }
    else{
        btnTitle = [[NSMutableAttributedString alloc] initWithString:@"请完善该锁地址 " attributes:@{NSForegroundColorAttributeName:HEX_RGB(0xe86868),NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    }
    NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
    attachment.bounds = CGRectMake(0, -2, 15, 15);
    attachment.image = [UIImage imageNamed:@"icon_bianji"];
    [btnTitle appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    [self.addressBtn setAttributedTitle:btnTitle forState:UIControlStateNormal];
}


#pragma mark - Event
- (void)settingClick
{
    [[WBMediator sharedManager] gotoSettingController];
}

- (void)addressClick
{
    [[WBMediator sharedManager] gotoAddressController:_lock];
}

- (void)uploadClick
{
    NSLog(@"11123");
}

- (void)datePickClick
{
    
}

#pragma mark - UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RUsageCell *cell = [tableView dequeueReusableCellWithIdentifier:RUsageCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = self.tableView.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.record = nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

#pragma mark - Getter
- (UIButton *)settingBtn
{
    if(!_settingBtn){
        _settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _settingBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 24, 12, 0);
        [_settingBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchDown];
    }
    return _settingBtn;
}

- (UIView *)headView
{
    if(!_headView){
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 246)];
        _headView.backgroundColor = [UIColor whiteColor];
        _headView.userInteractionEnabled = YES;
        
        [_headView addSubview:self.imgView];
        [_headView addSubview:self.stateLabel];
        [_headView addSubview:self.nameLabel];
        
        [_headView addSubview:self.usageLabel];
        [_headView addSubview:self.usersLabel];
        [_headView addSubview:self.dateLabel];
        [_headView addSubview:self.addressBtn];
        
        [_headView addSubview:self.searchBar];
        [_headView addSubview:self.datePickBtn];
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
        _usageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 104.5, (SCREEN_WIDTH-20)/3, 44)];
        _usageLabel.textAlignment = NSTextAlignmentLeft;
        _usageLabel.numberOfLines = 2;
    }
    return _usageLabel;
}

- (UILabel *)usersLabel
{
    if(!_usersLabel){
        _usersLabel = [[UILabel alloc] initWithFrame:CGRectMake(_usageLabel.right, 104.5, (SCREEN_WIDTH-20)/3, 44)];
        _usersLabel.textAlignment = NSTextAlignmentCenter;
        _usersLabel.numberOfLines = 2;
    }
    return _usersLabel;
}

- (UILabel *)dateLabel
{
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_usersLabel.right, 104.5, (SCREEN_WIDTH-20)/3, 44)];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.numberOfLines = 2;
    }
    return _dateLabel;
}

- (UIButton *)addressBtn
{
    if(!_addressBtn){
        _addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 158.5, SCREEN_WIDTH, 40)];
        _addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _addressBtn.backgroundColor = HEX_RGB(0xf7f7f7);
        _addressBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_addressBtn addTarget:self action:@selector(addressClick) forControlEvents:UIControlEventTouchDown];
    }
    return _addressBtn;
}

- (WBSearchBar *)searchBar
{
    if(!_searchBar){
        _searchBar = [[WBSearchBar alloc] initWithFrame:CGRectMake(0, 198.5, SCREEN_WIDTH-44, 48)];
        _searchBar.placeholder = @"输入姓名或手机号查找开锁记录";
        _searchBar.delegate = self;
        _searchBar.backgroundColor = HEX_RGB(0xeaeaf0);
    }
    return _searchBar;
}

- (UIButton *)datePickBtn
{
    if(!_datePickBtn){
        _datePickBtn = [[UIButton alloc] initWithFrame:CGRectMake( SCREEN_WIDTH-44, 198.5, 44, 48)];
        _datePickBtn.imageEdgeInsets = UIEdgeInsetsMake(15.5, 13, 15.5, 13);
        [_datePickBtn setImage:[UIImage imageNamed:@"icon_rili"] forState:UIControlStateNormal];
        [_datePickBtn addTarget:self action:@selector(datePickClick) forControlEvents:UIControlEventTouchDown];
        _datePickBtn.backgroundColor = HEX_RGB(0xeaeaf0);
    }
    return _datePickBtn;
}

- (UIView *)footView
{
    if(!_footView){
        _footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _footView.backgroundColor = self.tableView.backgroundColor;
        [_footView addSubview:self.uploadBtn];
    }
    return _footView;
}

- (UIButton *)uploadBtn
{
    if(!_uploadBtn){
        _uploadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, 35)];
        _uploadBtn.layer.cornerRadius = 4;
        _uploadBtn.layer.masksToBounds = YES;
        _uploadBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_uploadBtn setBackgroundImage:[UIImage imageWithColor:HEX_RGB(0x3684b5)] forState:UIControlStateNormal];
        [_uploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_uploadBtn setTitle:@"上传开锁记录" forState:UIControlStateNormal];
        [_uploadBtn addTarget:self action:@selector(uploadClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _uploadBtn;
}
@end
