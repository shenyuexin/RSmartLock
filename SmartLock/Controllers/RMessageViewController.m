//
//  RMessageViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/15.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RMessageViewController.h"
#import "RMessageCell.h"
#import "WBAPIManager+Bussiness.h"

@interface RMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation RMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";
    [self.tableView registerClass:[RMessageCell class] forCellReuseIdentifier:RMessageCellIdentifier];
    [self fetchData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data
- (void)fetchData
{
    [[WBAPIManager getMessagesWithPage:0] subscribeNext:^(NSArray *array) {
        self.dataList = array.mutableCopy;
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    RMessageInfo *message = self.dataList[indexPath.row];
    CGFloat contentHeight = [message.content sizeWithFont:[UIFont systemFontOfSize:13] byWidth:SCREEN_WIDTH-30].height;
    NSInteger height = 42 + 35 + 20 + contentHeight;
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(RMessageCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMessageInfo *message = self.dataList[indexPath.row];
    cell.message = message;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:RMessageCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
