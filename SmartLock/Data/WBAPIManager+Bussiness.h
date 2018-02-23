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

/**
 *  获取锁开锁记录
 *
 *  @param serialNum     页码
 *  @param keyword       搜索条件：手机号或姓名,可以为nil
 *  @param begin         筛选条件：开始日期,可以为nil
 *  @param end           筛选条件：结束日期,可以为nil
 *  @param page          页码
 *
 *  @return @[WBProductInfo]
 */
+ (RACSignal *)getLockRecords:(NSString *)serialNum
                      keyWord:(NSString *)keyword
                    beginDate:(NSString *)begin
                      endDate:(NSString *)end
                         page:(NSInteger)page;

+ (RACSignal *)stopLock:(NSString *)serialNum;
+ (RACSignal *)resetLock:(NSString *)serialNum;
+ (RACSignal *)setLockAddress:(NSString *)address serialNum:(NSString *)serialNum;


+ (RACSignal *)addPerson:(RPersonInfo *)person toLock:(NSString *)serialNum;

//获取系统消息列表
+ (RACSignal *)getMessagesWithPage:(NSInteger)page;

//获取锁使用用户列表
+ (RACSignal *)getLockUsers:(NSString *)serialNum enable:(BOOL)enable page:(NSInteger)page;

+ (RACSignal *)startLockUser:(NSString *)pid;
+ (RACSignal *)stopLockUser:(NSString *)pid;

@end
