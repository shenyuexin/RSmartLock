//
//  RPersonInfo.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/5.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RPersonInfo.h"
#import "NSDate+BeeExtension.h"

@implementation RPersonInfo

- (NSString *)validDate
{
//    NSDate *bDate = [NSDate dateWithTimeIntervalSince1970:_beginDate];
//    NSDate *eDate = [NSDate dateWithTimeIntervalSince1970:_endDate];
//    return [NSString stringWithFormat:@"%@ 至 %@",[bDate stringWithDateFormat:@"yyyy-MM-dd"],[eDate stringWithDateFormat:@"yyyy-MM-dd"]];
    return [NSString stringWithFormat:@"%@ 至 %@", _beginDate,_endDate];
}

@end
