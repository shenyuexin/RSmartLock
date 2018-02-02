//
//  RICViewController.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/22.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RICViewController.h"
#import "RICCell.h"

@interface RICViewController ()

@end

@implementation RICViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"IC卡开锁";
    [_tableView registerClass:[RICCell class] forCellReuseIdentifier:RICCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBluetoothConnect:(BOOL)connect
{
    [super setBluetoothConnect:connect];
    if(connect){
        _infoLabel.text = @"在听到提示音后将IC卡放置在门锁的识别区域";
    }
    else{
        _infoLabel.text = @"连接蓝牙后，在听到提示音后将IC卡放置在门锁的识别区域";
    }
    [_infoLabel sizeToFit];
    _infoLabel.top = _headerView.height - _infoLabel.height - 10;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 51;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(RICCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.enabled = YES;
    cell.record = (indexPath.row==0)?YES:NO;
    cell.title = [NSString stringWithFormat:@"IC卡开锁%ld",(long)indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RICCell *cell = [tableView dequeueReusableCellWithIdentifier:RICCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    RICCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.enabled && !cell.record){
        [[WBMediator sharedManager] gotoICVerifyController];
    }
}
@end
