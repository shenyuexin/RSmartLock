//
//  RMessageCell.h
//  SmartLock
//
//  Created by Richard Shen on 2018/1/19.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString * const RMessageCellIdentifier;

@interface RMessageCell : UITableViewCell

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *content;
@end
