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

- (NSString *)rateString
{
    if(_rateMode > 0 && _rate > 0){
        switch (_rateMode) {
            case 0:
                _rateString = [NSString stringWithFormat:@"%ld天1次",_rate];
                break;
            case 1:
                _rateString = [NSString stringWithFormat:@"%ld周1次",_rate];
                break;
            case 2:
                _rateString = [NSString stringWithFormat:@"%ld月1次",_rate];
                break;
            default:
                break;
        }
    }
    return _rateString;
}

@end
