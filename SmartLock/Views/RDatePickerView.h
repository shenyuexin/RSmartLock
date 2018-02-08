//
//  RDatePickerView.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/7.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDatePickerView : UIView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSDate *beginDate;
@property (nonatomic, strong) NSDate *endDate;


- (void)show;
@end
