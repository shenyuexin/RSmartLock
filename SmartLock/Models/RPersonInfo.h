//
//  RPersonInfo.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/5.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RBaseInfo.h"

@interface RPersonInfo : RBaseInfo

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *idNum;

@property (nonatomic, strong) NSString *beginDate;
@property (nonatomic, strong) NSString *endDate;

@property (nonatomic, assign) BOOL enable;

@property (nonatomic, assign) BOOL pwdEnable;
@property (nonatomic, assign) BOOL icEnable;
@property (nonatomic, assign) BOOL fgpEnable;
@property (nonatomic, strong) NSString *lockModeString;

@property (nonatomic, assign) NSInteger rate;       //数
@property (nonatomic, assign) NSInteger rateMode;   //天：10,周：20，月：30
@property (nonatomic, strong) NSString *rateString; 
@end
