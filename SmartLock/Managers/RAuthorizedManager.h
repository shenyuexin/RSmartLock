//
//  RAuthorizedManager.h
//  SmartLock
//
//  Created by Richard Shen on 2018/1/19.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAuthorizedManager : NSObject

@property (nonatomic, assign) BOOL isAuth;

+ (RAuthorizedManager *)manager;
@end
