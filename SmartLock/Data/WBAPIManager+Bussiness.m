//
//  WBAPIManager+Bussiness.m
//  Weimai
//
//  Created by Richard Shen on 16/1/14.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import "WBAPIManager+Bussiness.h"
#import "RLockInfo.h"
#import "RRecordInfo.h"
#import "RMessageInfo.h"

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
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        return data[@"banner"];
    }];
}

+ (RACSignal *)getHomeList:(NSInteger)page
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"offset":@(page*kDefaultPageNum),
                             @"limit":@(kDefaultPageNum)};
    NSURLRequest *request = [manager requestWithMethod:@"/home/smartlock/page" params:params uploadImages:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *array = [RLockInfo mj_objectArrayWithKeyValuesArray:data[@"rows"]];
        return array;
    }];
}

+ (RACSignal *)getLockInfo:(NSString *)serialNum
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"serialNo":serialNum};
    NSURLRequest *request = [manager requestWithMethod:@"/smartlock/banner" params:params uploadImages:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getLockRecords:(NSString *)serialNum
                      keyWord:(NSString *)keyword
                    beginDate:(NSString *)begin
                      endDate:(NSString *)end
                         page:(NSInteger)page
{
    WBAPIManager *manager = [self sharedManager];
    NSMutableDictionary *params = @{@"serialNo":serialNum,
                                    @"offset":@(page*kDefaultPageNum),
                                    @"limit":@(kDefaultPageNum)}.mutableCopy;
    if(keyword.isNotEmpty){
        [params setObject:keyword forKey:@"param"];
    }
    if(begin.isNotEmpty && end.isNotEmpty){
        [params setObject:begin forKey:@"startUnlockTime"];
        [params setObject:end forKey:@"endUnlockTime"];
    }
    NSURLRequest *request = [manager requestWithMethod:@"/unlockrecord/search" params:params uploadImages:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *array = [RRecordInfo mj_objectArrayWithKeyValuesArray:data[@"rows"]];
        return array;
    }];
}

+ (RACSignal *)getLockRecords:(NSString *)serialNum
                       userid:(NSString *)userid
                         page:(NSInteger)page
{
    WBAPIManager *manager = [self sharedManager];
    NSMutableDictionary *params = @{@"serialNo":serialNum,
                                    @"memberId":userid,
                                    @"offset":@(page*kDefaultPageNum),
                                    @"limit":@(kDefaultPageNum)}.mutableCopy;
    NSURLRequest *request = [manager requestWithMethod:@"/unlockrecord/search" params:params uploadImages:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *array = [RRecordInfo mj_objectArrayWithKeyValuesArray:data[@"rows"]];
        return array;
    }];
    
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

+ (RACSignal *)setLockAddress:(NSString *)address serialNum:(NSString *)serialNum
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"serialNo":serialNum,
                             @"address":address};
    NSURLRequest *request = [manager requestWithMethod:@"/merchant/smartlock/changeInfo" params:params uploadImages:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)setLockPassword:(NSString *)password serialNum:(NSString *)serialNum
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"serialNo":serialNum,
                             @"pinCode":password};
    NSURLRequest *request = [manager requestWithMethod:@"/merchant/smartlock/changeInfo" params:params uploadImages:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)setLockRate:(NSInteger )rate
                  rateMode:(NSInteger)rateMode
                 serialNum:(NSString *)serialNum
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"serialNo":serialNum,
                             @"frequency":@(rate),
                             @"frequencyMode":@(rateMode)};
    NSURLRequest *request = [manager requestWithMethod:@"/merchant/smartlock/changeInfo" params:params uploadImages:nil];
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
                             @"isPinCode":@(person.isPinCode),
                             @"isIcCode":@(person.isIcCode),
                             @"isFingerprintCode":@(person.isFingerprintCode),
                             @"frequency":@(person.rate),
                             @"frequencyMode":@(person.rateMode),
                             };
    NSURLRequest *request = [manager requestWithMethod:@"/member/smartlock/add" params:params uploadImages:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)editPerson:(RPersonInfo *)person toLock:(NSString *)serialNum
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"id":person.mid,
                             @"serialNo":serialNum,
                             @"mobile":person.phone,
                             @"realName":person.name,
                             @"identityCard":person.idNum,
                             @"useStartTime":person.beginDate,
                             @"useEndTime":person.endDate,
                             @"isPinCode":@(person.isPinCode),
                             @"isIcCode":@(person.isIcCode),
                             @"isFingerprintCode":@(person.isFingerprintCode),
                             @"frequency":@(person.rate),
                             @"frequencyMode":@(person.rateMode),
                             };
    NSURLRequest *request = [manager requestWithMethod:@"/member/smartlock/edit" params:params uploadImages:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getMessagesWithPage:(NSInteger)page
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"offset":@(page*kDefaultPageNum),
                             @"limit":@(kDefaultPageNum)};
    NSURLRequest *request = [manager requestWithMethod:@"/notice/search" params:params uploadImages:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *array = [RMessageInfo mj_objectArrayWithKeyValuesArray:data[@"rows"]];
        return array;
    }];
}

+ (RACSignal *)getLockUsers:(NSString *)serialNum
                  searchKey:(NSString *)key
                     enable:(BOOL)enable
                       page:(NSInteger)page
{
    WBAPIManager *manager = [self sharedManager];
    NSMutableDictionary *params = @{@"serialNo":serialNum,
                                    @"offset":@(page*kDefaultPageNum),
                                    @"limit":@(kDefaultPageNum),
                                    @"status":(enable?@(10):@(20))
                                    }.mutableCopy;
    if(key.isNotEmpty){
        [params setObject:key forKey:@"param"];
    }
    NSURLRequest *request = [manager requestWithMethod:@"/member/smartlock/search" params:params uploadImages:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *array = [RPersonInfo mj_objectArrayWithKeyValuesArray:data[@"rows"]];
        return array;
    }];
}

+ (RACSignal *)startLockUser:(NSString *)pid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"id":pid};
    NSURLRequest *request = [manager requestWithMethod:@"/member/smartlock/start" params:params uploadImages:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)stopLockUser:(NSString *)pid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"id":pid};
    NSURLRequest *request = [manager requestWithMethod:@"/member/smartlock/stop" params:params uploadImages:nil];
    return [manager signalWithRequest:request];
}
@end
