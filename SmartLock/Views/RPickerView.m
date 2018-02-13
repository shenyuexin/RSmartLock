//
//  RPickerView.m
//  SmartLock
//
//  Created by Richard Shen on 2018/2/13.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RPickerView.h"
#import "UIView+BorderLine.h"

@interface RPickerView ()

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation RPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
        self.cancelBtn.height = self.height - self.contentView.height;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)showInView:(UIView *)superview
{
    [superview addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.top = SCREEN_HEIGHT - self.contentView.height;
    } completion:^(BOOL finished) {
        [self addSubview:self.cancelBtn];
    }];
}

#pragma mark - Event
- (void)cancelClick
{
}

- (void)confirmClick
{
}

- (void)dismissClick
{
    [self.cancelBtn removeFromSuperview];
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Getter
- (UIButton *)cancelBtn
{
    if(!_cancelBtn){
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-356)];
        _cancelBtn.backgroundColor = HEX_RGBA(0x000000, 0.5);
        [_cancelBtn addTarget:self action:@selector(dismissClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIView *)contentView
{
    if(!_contentView){
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 356)];
        _contentView.backgroundColor = [UIColor whiteColor];
        
        [_contentView addSubview:self.titleLabel];
        [_contentView addSubview:self.resetBtn];
        [_contentView addSubview:self.confirmBtn];
    }
    return _contentView;
}

- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = HEX_RGB(0x666666);
        [_titleLabel addBorderLine:BorderBottom];
    }
    return _titleLabel;
}

- (UIButton *)resetBtn
{
    if(!_resetBtn){
        _resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 44, 46)];
        [_resetBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:HEX_RGB(0x666666) forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_resetBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

- (UIButton *)confirmBtn
{
    if(!_confirmBtn){
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-54, 0, 44, 46)];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:HEX_RGB(0x3dba9c) forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
@end
