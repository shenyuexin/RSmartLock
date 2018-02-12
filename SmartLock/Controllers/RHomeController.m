//
//  RHomeController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/9.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RHomeController.h"
#import "RHomeBottomView.h"
#import "WBAPIManager.h"
#import "RConfigureView.h"
#import "RHomeContentView.h"
#import "RAuthorizedManager.h"
#import "RHomeCell.h"
#import "WBSearchBar.h"
#import "WBAPIManager+Bussiness.h"

@interface RHomeController ()<UISearchBarDelegate>

@property (nonatomic, strong) UIImageView *launchImgView;
@property (nonatomic, strong) UIButton *scanBtn;
@property (nonatomic, strong) UIButton *msgBtn;
@property (nonatomic, strong) UIView *badgeView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *topLabela;
@property (nonatomic, strong) UILabel *topLabelb;
@property (nonatomic, strong) UILabel *topLabelc;
@property (nonatomic, strong) WBSearchBar *searchBar;

@property (nonatomic, assign) BOOL isConfigured;
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation RHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.msgBtn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.scanBtn];
    self.view.backgroundColor = COLOR_BAR;
    self.navigationItem.title = @"智能锁查询管理系统";
    
    UIWindow *widow = [[UIApplication sharedApplication] keyWindow];
    [widow addSubview:self.launchImgView];
    
    self.tableView.frame = CGRectMake(0, self.headView.bottom, SCREEN_WIDTH, self.view.height-self.headView.bottom-self.navigationController.navigationBar.bottom);
    self.tableView.rowHeight = 119;
    [self.tableView registerClass:[RHomeCell class] forCellReuseIdentifier:RHomeCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(![WBAPIManager isLogin]){
        [[WBMediator sharedManager] gotoLoginControllerWithAnimate:NO];
    }
    else{
        [self fetchData];
    }
    [_launchImgView removeFromSuperview];_launchImgView = nil;
}

#pragma mark - Data
- (void)fetchData
{
    RACSignal *bannerSignal = [WBAPIManager getHomeBanner];
    [bannerSignal subscribeNext:^(NSDictionary *data) {
        [self updateTopNum:data];
    }];
    
    RACSignal *listSignal = [WBAPIManager getHomeList:0];
    [listSignal subscribeNext:^(NSArray *list) {
        self.dataList = list.mutableCopy;
        [self.tableView reloadData];
    }];
}

#pragma mark - Event
- (void)scanClick
{
    [[WBMediator sharedManager] gotoQRCodeController];
}

- (void)msgClick
{
    [[WBMediator sharedManager] gotoMessageController];
}

- (void)updateTopNum:(NSDictionary *)dic
{
    UIFont *font = [UIFont systemFontOfSize:20];
    UIFont *sfont = [UIFont systemFontOfSize:12];
    NSMutableAttributedString *stringa = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld\n全部",[dic[@"totalQuantity"] longValue]] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:HEX_RGB(0X3DBA9C)}];
    [stringa addAttributes:@{NSFontAttributeName:sfont, NSForegroundColorAttributeName:HEX_RGB(0X777777)} range:NSMakeRange(stringa.length-2, 2)];
    self.topLabela.attributedText = stringa;
    
    NSMutableAttributedString *stringb = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld\n使用中",[dic[@"usedQuantity"] longValue]] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:HEX_RGB(0X3DBA9C)}];
    [stringb addAttributes:@{NSFontAttributeName:sfont, NSForegroundColorAttributeName:HEX_RGB(0X777777)} range:NSMakeRange(stringb.length-3, 3)];
    self.topLabelb.attributedText = stringb;
    
    NSMutableAttributedString *stringc = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld\n已停用",[dic[@"disableQuantity"] longValue]] attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:HEX_RGB(0X999999)}];
    [stringc addAttributes:@{NSFontAttributeName:sfont, NSForegroundColorAttributeName:HEX_RGB(0X777777)} range:NSMakeRange(stringc.length-3, 3)];
    self.topLabelc.attributedText = stringc;
}

#pragma mark - UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == self.dataList.count-1){
        return 10;
    }
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:RHomeCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lock = self.dataList[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    RLockInfo *lock = self.dataList[indexPath.section];
    [[WBMediator sharedManager] gotoLockInfoController:lock];
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
- (UIImageView *)launchImgView
{
    if(!_launchImgView){
        CGSize viewSize = self.view.bounds.size;
        NSString *launchImage = nil;
        NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
        for (NSDictionary* dict in imagesDict){
            CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
            if (CGSizeEqualToSize(imageSize, viewSize)){
                launchImage = dict[@"UILaunchImageName"];
            }
        }
        _launchImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _launchImgView.image = [UIImage imageNamed:launchImage];
    }
    return _launchImgView;
}

- (UIButton *)scanBtn
{
    if(!_scanBtn){
        _scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _scanBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 24);
        [_scanBtn setImage:[UIImage imageNamed:@"saoyisao2"] forState:UIControlStateNormal];
        [_scanBtn addTarget:self action:@selector(scanClick) forControlEvents:UIControlEventTouchDown];
    }
    return _scanBtn;
}

- (UIButton *)msgBtn
{
    if(!_msgBtn){
        _msgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _msgBtn.imageEdgeInsets = UIEdgeInsetsMake(14, 20, 14, 3);
        [_msgBtn setImage:[UIImage imageNamed:@"icon_xiaoxi"] forState:UIControlStateNormal];
        [_msgBtn addTarget:self action:@selector(msgClick) forControlEvents:UIControlEventTouchDown];
    }
    return _msgBtn;
}

- (UIView *)badgeView
{
    if(!_badgeView){
        _badgeView = [[UIView alloc] initWithFrame:CGRectMake(32, 12, 2, 2)];
        _badgeView.backgroundColor = HEX_RGB(0xf45252);
        _badgeView.layer.cornerRadius = _badgeView.width/2;
        _badgeView.layer.masksToBounds = YES;
    }
    return _badgeView;
}

- (UIView *)headView
{
    if(!_headView){
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 122)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        [_headView addSubview:self.topLabela];
        [_headView addSubview:self.topLabelb];
        [_headView addSubview:self.topLabelc];
        [_headView addSubview:self.searchBar];
    }
    return _headView;
}

- (UILabel *)topLabela
{
    if(!_topLabela){
        _topLabela = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, (SCREEN_WIDTH-30)/3, 74)];
        _topLabela.numberOfLines = 2;
        _topLabela.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabela;
}

- (UILabel *)topLabelb
{
    if(!_topLabelb){
        _topLabelb = [[UILabel alloc] initWithFrame:CGRectMake(_topLabela.right, 0, (SCREEN_WIDTH-30)/3, 74)];
        _topLabelb.numberOfLines = 2;
        _topLabelb.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabelb;
}

- (UILabel *)topLabelc
{
    if(!_topLabelc){
        _topLabelc = [[UILabel alloc] initWithFrame:CGRectMake(_topLabelb.right, 0, (SCREEN_WIDTH-30)/3, 74)];
        _topLabelc.numberOfLines = 2;
        _topLabelc.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabelc;
}

- (WBSearchBar *)searchBar
{
    if(!_searchBar){
        _searchBar = [[WBSearchBar alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, 48)];
        _searchBar.placeholder = @"输入锁序号查找锁";
        _searchBar.delegate = self;
        _searchBar.backgroundColor = HEX_RGB(0xeaeaf0);
    }
    return _searchBar;
}
@end
