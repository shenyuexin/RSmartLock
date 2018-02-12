//
//  RRecordInfo.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/2.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RRecordInfo.h"
#import "NSDate+BeeExtension.h"

@implementation RRecordInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"name":@"realName",
             @"idNum":@"identityCard",
             @"phone":@"mobile",
             @"timestamp":@"unlockTime",
             @"mode":@"unlockMode"
             };
}


- (NSString *)dateString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_timestamp/1000];
    _dateString = [date stringWithDateFormat:@"yyyy-MM-dd"];
    return _dateString;
}

- (NSString *)type
{
    if(_mode == 10){
        _type = @"密码开锁";
    }
    else if(_mode == 20){
        _type = @"指纹开锁";
    }
    else if(_mode == 30){
        _type = @"IC卡开锁";
    }
    return _type;
}

@end
