//
//  WBSearchBar.m
//  Weimai
//
//  Created by Richard Shen on 2017/11/20.
//  Copyright © 2017年 Weibo. All rights reserved.
//

#import "WBSearchBar.h"

@interface WBSearchBar ()

@property (nonatomic, assign) CGFloat placeholderWidth;
@end

@implementation WBSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundImage = [UIImage new];
        self.txtFiled = [self valueForKey:@"searchField"];
        
        if(self.txtFiled){
            self.txtFiled.layer.cornerRadius = 18;
            self.txtFiled.layer.masksToBounds = YES;
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderWidth = [self.placeholder sizeWithFont:self.txtFiled.font byHeight:self.height].width + 3;
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetMake((self.txtFiled.width - _placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
}


// 实现textfield的代理方法
// 开始编辑的时候重置为靠左
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // 继续传递代理方法
    BOOL value = YES;
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        value = [self.delegate searchBarShouldBeginEditing:self];
    }
    if(!value) return NO;
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}

// 结束编辑的时候设置为居中
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    BOOL value = YES;
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]){
        value = [self.delegate searchBarShouldEndEditing:self];
    }
    if(!value) return NO;
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width - _placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}

@end
