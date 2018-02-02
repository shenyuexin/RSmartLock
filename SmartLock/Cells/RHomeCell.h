//
//  RHomeCell.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/2.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLockInfo.h"

FOUNDATION_EXTERN NSString * const RHomeCellIdentifier;

@interface RHomeCell : UITableViewCell


@property (nonatomic, strong) RLockInfo *lock;
@end
