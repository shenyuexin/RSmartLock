//
//  RPersonCell.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/5.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPersonInfo.h"

FOUNDATION_EXTERN NSString * const RPersonCellIdentifier;

@interface RPersonCell : UITableViewCell

@property (nonatomic, strong) RPersonInfo *person;
@end
