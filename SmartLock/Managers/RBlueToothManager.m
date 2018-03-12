//
//  RAuthorizedManager.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/19.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RBlueToothManager.h"

@implementation RBlueToothManager

+ (RBlueToothManager *)manager
{
    static RBlueToothManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RBlueToothManager alloc] init];
    });
    return manager;
}

- (void)connectToLock:(NSString *)serialNum complete:(void (^)(BOOL success))completionHandler
{
    completionHandler(YES);
}

//修改开锁密码
- (void)changePassword:(NSString *)password complete:(void (^)(BOOL success))completionHandler
{
    completionHandler(YES);

}

//修改指纹密码
- (void)changeFingerPrintWithIndex:(NSInteger)index complete:(void (^)(BOOL success))completionHandler
{
    completionHandler(YES);

}

//配置IC卡开锁
- (void)configureICWithIndex:(NSInteger)index
{
    
}

@end
