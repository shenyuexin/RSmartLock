//
//  RMessageInfo.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/12.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RMessageInfo.h"
#import "NSDate+BeeExtension.h"


@implementation RMessageInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"mid":@"id",
             @"timestamp":@"releaseTime"};
}

- (NSString *)dateString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_timestamp/1000];
    _dateString = [date stringWithDateFormat:@"yyyy-MM-dd hh:mm"];
    return _dateString;
}
@end
