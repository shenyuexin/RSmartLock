//
//  RMessageCell.h
//  SmartLock
//
//  Created by Richard Shen on 2018/1/19.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMessageInfo.h"

FOUNDATION_EXTERN NSString * const RMessageCellIdentifier;

@interface RMessageCell : UITableViewCell

@property (nonatomic, strong) RMessageInfo *message;
@end
