//
//  RRecordInfo.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/2.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RBaseInfo.h"

@interface RRecordInfo : RBaseInfo


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *idNum;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, assign) long long timestamp;
@property (nonatomic, assign) NSInteger mode;
@end
