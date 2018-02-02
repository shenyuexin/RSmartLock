//
//  RMessageViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/15.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RMessageViewController.h"
#import "RMessageCell.h"

@interface RMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";
    [self.tableView registerClass:[RMessageCell class] forCellReuseIdentifier:RMessageCellIdentifier];
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

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 140;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(RMessageCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.date = @"2018-01-19 16:06:11";
    cell.content = @"新消息新消息新消息新消息新消息新消息新消息新消息新消息新消息新消息新消息新消息新消息新消息新消息";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:RMessageCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
