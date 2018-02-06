//
//  RPersonInfo.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/5.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPersonInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *idNum;

@property (nonatomic, assign) long long beginDate;
@property (nonatomic, assign) long long endDate;
@property (nonatomic, strong) NSString *validDate;

@property (nonatomic, assign) BOOL enable;

@property (nonatomic, assign) BOOL pwdEnable;
@property (nonatomic, assign) BOOL icEnable;
@property (nonatomic, assign) BOOL fgpEnable;

@property (nonatomic, assign) NSInteger rate;       //单位为天
@end
