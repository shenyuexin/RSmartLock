//
//  RRatePickerView.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/13.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RPickerView.h"

@interface RRatePickerView : RPickerView

@property (nonatomic, assign) NSInteger rate;       //数
@property (nonatomic, assign) NSInteger rateMode;   //天：10,周：20，月：30

@property (nonatomic, strong) NSString *rateString;   //天：10,周：20，月：30
@end
