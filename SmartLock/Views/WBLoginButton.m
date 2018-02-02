//
//  WBLoginButton.m
//  Weimai
//
//  Created by Richard Shen on 16/1/27.
//  Copyright © 2016年 Richard. All rights reserved.
//

#import "WBLoginButton.h"
#import "UIImage+Color.h"

@implementation WBLoginButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.layer.cornerRadius = 2;
        self.layer.masksToBounds = YES;
        
        [self setBackgroundImage:[UIImage imageWithColor:COLOR_BAR] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}
@end
