//
//  RAddPersonViewController.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/5.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RBaseViewController.h"
#import "RLockInfo.h"
#import "RPersonInfo.h"

@interface RAddPersonViewController : RBaseViewController

@property (nonatomic, strong) RLockInfo *lock;
@property (nonatomic, strong) RPersonInfo *person;
@end
