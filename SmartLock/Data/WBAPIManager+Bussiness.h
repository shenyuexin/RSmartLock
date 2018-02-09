//
//  WBAPIManager+Bussiness.h
//  Weimai
//
//  Created by Richard Shen on 16/1/14.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import "WBAPIManager.h"
#import "RPersonInfo.h"

@interface WBAPIManager (Bussiness)

+ (RACSignal *)getSmsCode:(NSString *)phone;
+ (RACSignal *)loginWithPhone:(NSString *)phone code:(NSString *)code;

+ (RACSignal *)getHomeBanner;
+ (RACSignal *)getHomeList:(NSInteger)page;
+ (RACSignal *)getLockInfo:(NSString *)serialNum;

+ (RACSignal *)stopLock:(NSString *)serialNum;
+ (RACSignal *)resetLock:(NSString *)serialNum;

+ (RACSignal *)addPerson:(RPersonInfo *)person toLock:(NSString *)serialNum;
@end
