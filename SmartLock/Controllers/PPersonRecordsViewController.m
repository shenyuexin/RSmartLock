//
//  PPersonRecordsViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/23.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "PPersonRecordsViewController.h"
#import "RUsageCell.h"

@interface PPersonRecordsViewController ()

@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation PPersonRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"使用记录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data
- (void)fetchData
{
//    [[WBAPIManager getLockRecords:_lock.lid keyWord:nil beginDate:nil endDate:nil page:0] subscribeNext:^(NSArray *array) {
//        self.dataList = array.mutableCopy;
//        [self.tableView reloadData];
//    }];
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
    return self.dataList.count;
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
    cell.record = self.dataList[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}
@end
