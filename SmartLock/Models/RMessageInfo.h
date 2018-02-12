//
//  RMessageInfo.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/12.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMessageInfo : NSObject

@property (nonatomic, strong) NSString *mid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, assign) long long timestamp;
@end
