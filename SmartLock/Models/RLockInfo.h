//
//  RLockInfo.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/2.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RBaseInfo.h"

@interface RLockInfo : RBaseInfo

@property (nonatomic, strong) NSString *lid;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) long usage_count;
@property (nonatomic, assign) long users;
@property (nonatomic, assign) long long timestamp;
@property (nonatomic, strong) NSString *dateString;

@property (nonatomic, strong) NSString *address;
@end
