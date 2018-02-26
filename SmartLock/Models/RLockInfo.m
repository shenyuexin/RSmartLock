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
    return @{@"lid":@"serialNo",
             @"usage_count":@"unlockTimes",
             @"users":@"useTimes",
             @"timestamp":@"nextDetectionTime",
             @"rate":@"frequency",
             @"rateMode":@"frequencyMode",
             };
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

- (NSString *)rateString
{
    if(_rateMode > 0 && _rate > 0){
        switch (_rateMode) {
            case 10:
                _rateString = [NSString stringWithFormat:@"%ld天1次",_rate];
                break;
            case 20:
                _rateString = [NSString stringWithFormat:@"%ld周1次",_rate];
                break;
            case 30:
                _rateString = [NSString stringWithFormat:@"%ld月1次",_rate];
                break;
            default:
                break;
        }
    }
    return _rateString;
}
@end
