//
//  RUsageCell.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/2.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRecordInfo.h"

FOUNDATION_EXTERN NSString * const RUsageCellIdentifier;

@interface RUsageCell : UITableViewCell

@property (nonatomic, strong) RRecordInfo *record;
@end
