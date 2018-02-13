//
//  RDatePickerView.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/7.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPickerView.h"

@interface RDatePickerView : RPickerView


@property (nonatomic, strong) NSString *beginDateString;
@property (nonatomic, strong) NSString *endDateString;

- (void)showInView:(UIView *)superview;
@end
