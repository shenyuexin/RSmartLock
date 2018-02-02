//
//  RReportCell.h
//  SmartLock
//
//  Created by Richard Shen on 2018/1/17.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString * const RReportCellIdentifier;

@interface RReportCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *txtLabel;
@end
