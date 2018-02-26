//
//  RPersonInfo.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/5.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RPersonInfo.h"
#import "NSDate+BeeExtension.h"

@interface RPersonInfo ()

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) long long useStartTime;
@property (nonatomic, assign) long long useEndTime;

@end

@implementation RPersonInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"pid":@"id",
             @"name":@"realName",
             @"idNum":@"identityCard",
             @"phone":@"mobile",
             @"rate":@"frequency",
             @"rateMode":@"frequencyMode",
             @"lockid":@"serialNo"
             };
}

- (NSString *)beginDate
{
    if(!_beginDate && _useStartTime>0){
        _beginDate = [[NSDate dateWithTimeIntervalSince1970:_useStartTime/1000] stringWithDateFormat:@"yyyy-MM-dd"];
    }
    return _beginDate;
}

- (NSString *)endDate
{
    if(!_endDate && _useEndTime>0){
        _endDate = [[NSDate dateWithTimeIntervalSince1970:_useEndTime/1000] stringWithDateFormat:@"yyyy-MM-dd"];
    }
    return _endDate;
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

- (BOOL)enable
{
    _enable = (_status == 10)?YES:NO;
    return _enable;
}

- (BOOL)pwdEnable
{
    _pwdEnable = (_isPinCode == 10)?YES:NO;
    return _pwdEnable;
}

- (BOOL)fgpEnable
{
    _fgpEnable = (_isFingerprintCode == 10)?YES:NO;
    return _fgpEnable;
}

- (BOOL)icEnable
{
    _icEnable = (_isIcCode == 10)?YES:NO;
    return _icEnable;
}

- (NSString *)lockModeString
{
    if(!_lockModeString){
        NSMutableString *type = [NSMutableString string];
        if(_pwdEnable){
            [type appendString:@"密码锁"];
        }
        if(_fgpEnable){
            if(type.length > 0){
                [type appendString:@"+"];
            }
            [type appendString:@"指纹锁"];
        }
        if(_icEnable){
            if(type.length > 0){
                [type appendString:@"+"];
            }
            [type appendString:@"IC卡开锁"];
        }
        _lockModeString = type;
    }
    return _lockModeString;
}
@end
