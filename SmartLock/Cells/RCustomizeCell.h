//
//  RCustomizeCell.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/6.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString * const RCustomizeCellIdentifier;

@interface RCustomizeCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *txtField;
@property (nonatomic, strong) UISwitch *rswitch;
@end
