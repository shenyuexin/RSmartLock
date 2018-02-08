//
//  WBAPIManager+Bussiness.m
//  Weimai
//
//  Created by Richard Shen on 16/1/14.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import "WBAPIManager+Bussiness.h"



@implementation WBAPIManager (Bussiness)

+ (RACSignal *)getSmsCode:(NSString *)phone
{
    WBAPIManager *manager = [self sharedManager];
    NSString *method = [NSString stringWithFormat:@"/sms/sendLoginSmsCode/%@",phone];
    NSURLRequest *request = [manager requestWithMethod:method params:nil uploadImages:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)loginWithPhone:(NSString *)phone code:(NSString *)code
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"mobile":phone, @"code":code};
    NSURLRequest *request = [manager requestWithMethod:@"/merchant/login" params:params uploadImages:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getHomeBanner
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/home/banner" params:nil uploadImages:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)stopLock:(NSString *)serialNum
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"serialNo":serialNum};
    NSURLRequest *request = [manager requestWithMethod:@"/smartlock/stop" params:params uploadImages:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)resetLock:(NSString *)serialNum
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"serialNo":serialNum};
    NSURLRequest *request = [manager requestWithMethod:@"/merchant/smartlock/unBinding" params:params uploadImages:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)addPerson:(RPersonInfo *)person toLock:(NSString *)serialNum
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"serialNo":serialNum,
                             @"mobile":person.phone,
                             @"realName":person.name,
                             @"identityCard":person.idNum,
                             @"useStartTime":person.beginDate,
                             @"useEndTime":person.endDate,
                             @"isPinCode":@(person.pwdEnable),
                             @"isIcCode":@(person.icEnable),
                             @"isFingerprintCode":@(person.fgpEnable),
                             @"frequency":@(person.rate),
                             @"frequencyMode":@(person.rateMode),
                             };
    NSURLRequest *request = [manager requestWithMethod:@"/member/smartlock/add" params:params uploadImages:nil];
    return [manager signalWithRequest:request];
}
@end
