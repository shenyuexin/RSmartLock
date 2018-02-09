//
//  RLockInfo.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/2.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RLockInfo.h"
#import "NSDate+BeeExtension.h"

@implementation RLockInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"rid":@"serialNo",
             @"usage_count":@"unlockTimes",
             @"users":@"useTimes",
             @"timestamp":@"nextDetectionTime"};
}

- (NSString *)dateString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_timestamp/1000];
    _dateString = [date stringWithDateFormat:@"yyyy-MM-dd"];
    return _dateString;
}

- (BOOL)enable
{
    _enable = (_status == 20)?YES:NO;
    return _enable;
}
@end
