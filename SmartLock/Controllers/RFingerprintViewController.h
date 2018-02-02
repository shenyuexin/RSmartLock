//
//  RFingerprintViewController.h
//  SmartLock
//
//  Created by Richard Shen on 2018/1/22.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RBaseViewController.h"

@interface RFingerprintViewController : RBaseViewController
{
    UITableView *_tableView;
    UIView *_headerView;
    UILabel *_infoLabel;
}

- (void)setBluetoothConnect:(BOOL)connect;
@end
