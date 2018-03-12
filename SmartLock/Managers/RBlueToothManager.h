//
//  RAuthorizedManager.h
//  SmartLock
//
//  Created by Richard Shen on 2018/1/19.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBlueToothManager : NSObject

@property (nonatomic, assign) BOOL isConnected;

+ (RBlueToothManager *)manager;

//连接锁
- (void)connectToLock:(NSString *)serialNum complete:(void (^)(BOOL success))completionHandler;

//修改开锁密码
- (void)changePassword:(NSString *)password complete:(void (^)(BOOL success))completionHandler;

//修改指纹密码
- (void)changeFingerPrintWithIndex:(NSInteger)index complete:(void (^)(BOOL success))completionHandler;

//配置IC卡开锁
- (void)configureICWithIndex:(NSInteger)index;

@end
