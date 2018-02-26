//
//  WBOrderViewCell.m
//  Weimai
//
//  Created by Richard Shen on 16/9/8.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import "WBOrderViewCell.h"
#import "RPersonCell.h"
#import "WBAPIManager+Bussiness.h"

NSString * const WBOrderViewCellIdentifier = @"WBOrderViewCellIdentifier";

@interface WBOrderViewCell ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *noResultsView;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSString *searchKey;
@end

@implementation WBOrderViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusChange:) name:kNotificationPersonCellUpdate object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData) name:kNotificationPersonListUpdate object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchUpdate:) name:kNotificationPersonSearchUpdate object:nil];
        [self.tableView registerClass:[RPersonCell class] forCellReuseIdentifier:RPersonCellIdentifier];

    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setData:(NSMutableDictionary *)data
{
    [self.noResultsView removeFromSuperview];
    
    _data = data;
    if(!_data[@(_index)]){
        self.dataList = nil;
        [self.tableView reloadData];
        [self fetchData];
    }
    else{
        NSArray *array = _data[@(_index)];
        self.dataList = array.mutableCopy;
        [self.tableView reloadData];
    }
}

- (void)updateData
{
    [self fetchData];
}

- (void)searchUpdate:(NSNotification *)notification
{
    self.searchKey = notification.object;
    [self fetchData];
}

#pragma mark - Data
- (void)fetchData
{
    RACSignal *dataSignal = [WBAPIManager getLockUsers:_lockId searchKey:self.searchKey enable:(_index==0?YES:NO) page:0];
    [[dataSignal takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSArray *orders) {
        self.dataList = orders.mutableCopy;
        if(self.dataList.count > 0){
            [self.data setObject:self.dataList forKey:@(_index)];
        }

        [self.tableView reloadData];
        [self updateFooterByReceiveCount:orders.count];
//        [self.tableView.mj_header endRefreshing];

        if(self.dataList.count == 0){
            [self.tableView addSubview:self.noResultsView];
        }
        else{
            [self.noResultsView removeFromSuperview];
        }
    } error:^(NSError *error) {
//        [self.tableView.mj_header endRefreshing];
        [WBLoadingView showErrorStatus:error.domain];
        [self.tableView addSubview:self.noResultsView];
    }];
}

- (void)fetchMoreData
{
//    NSInteger page = self.dataList.count/kDefaultPageNum + 1;
//
//    RACSignal *dataSignal = nil;
//    if(_listType == OrderListSell){
//        dataSignal = [WBAPIManager getOrdersWithPage:page type:_index];
//    }
//    else{
//        dataSignal = [WBAPIManager ordersWithStatus:_index page:page];
//    }
//
//    [[dataSignal takeUntil:self.rac_prepareForReuseSignal]subscribeNext:^(NSArray *orders) {
//        [self.dataList addObjectsFromArray:orders];
//        [self.data setObject:self.dataList forKey:@(_index)];
//
//        [self.tableView reloadData];
//        [self updateFooterByReceiveCount:orders.count];
//        [self.tableView.mj_footer endRefreshing];
//    } error:^(NSError *error) {
//        [self.tableView.mj_footer endRefreshing];
//        [WBLoadingView showErrorStatus:error.domain];
//    }];
}

- (void)updateFooterByReceiveCount:(NSInteger)count
{
//    if(count < kDefaultPageNum){
//        if(count < kDefaultPageMinNum){
//            //数据少于一屏时，不显示上拉加载更多
//            _tableView.mj_footer = nil;
//        }
//        else{
//            [_tableView.mj_footer endRefreshingWithNoMoreData];
//        }
//    }
//    else{
//        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(fetchMoreData)];
//    }
}

#pragma mark - Event
- (void)statusChange:(NSNotification *)notification
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        RPersonCell *cell = notification.object;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

        if(cell.type == _index && indexPath.section >=0 && indexPath.section < self.dataList.count){
            [self.dataList removeObjectAtIndex:indexPath.section];

            [self.tableView beginUpdates];
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:(_index==0)? UITableViewRowAnimationRight:UITableViewRowAnimationLeft];
            [self.tableView endUpdates];

            if(self.dataList.count == 0){
                [self.tableView addSubview:self.noResultsView];
            }
        }
    });
}

#pragma mark - UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 142;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:RPersonCellIdentifier forIndexPath:indexPath];
    cell.person = self.dataList[indexPath.section];
    cell.type = _index;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Getter and Setter
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStyleGrouped];
        _tableView.scrollsToTop = YES;
        _tableView.sectionHeaderHeight = CGFLOAT_MIN;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.backgroundColor = RGB(235, 235, 241);
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
//        _tableView.mj_header = [WBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(fetchData)];
    }
    return _tableView;
}

//- (UIView *)noResultsView
//{
//    if(!_noResultsView){
//        _noResultsView = [[UIView alloc] initWithFrame:CGRectMake(0, (HEIGHT_SCREEN -64)/2-158, WIDTH_SCREEN, 158)];
//        _noResultsView.backgroundColor = [UIColor clearColor];
//
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_SCREEN-149)/2, 0, 149, 125)];
//        imgView.image = [UIImage imageNamed:@"还没有订单哦"];
//        [_noResultsView addSubview:imgView];
//
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom+10, WIDTH_SCREEN, 16)];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.text = @"还没有订单哦~";
//        label.font = [UIFont systemFontOfSize:15];
//        label.textColor = HEX_RGB(0x6f727b);
//        [_noResultsView addSubview:label];
//    }
//    return _noResultsView;
//}
@end
