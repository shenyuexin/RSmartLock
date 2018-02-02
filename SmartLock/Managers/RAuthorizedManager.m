//
//  RAuthorizedManager.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/19.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RAuthorizedManager.h"

@implementation RAuthorizedManager

+ (RAuthorizedManager *)manager
{
    static RAuthorizedManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RAuthorizedManager alloc] init];
    });
    return manager;
}


@end
