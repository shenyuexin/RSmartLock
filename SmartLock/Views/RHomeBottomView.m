//
//  RHomeBottomView.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/15.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RHomeBottomView.h"
#import "WBMediator.h"

@interface RHomeBottomView ()

@property (nonatomic, strong) UILabel  *tipLabel;
@property (nonatomic, strong) UIButton *feedbackBtn;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UIView   *badgeView;
@end

@implementation RHomeBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = HEX_RGB(0x589AEF);
        [self addSubview:self.tipLabel];
        [self addSubview:self.feedbackBtn];
        [self addSubview:self.messageBtn];
    }
    return self;
}

- (void)receiveNewMessage
{
    [self.messageBtn addSubview:self.badgeView];
}

#pragma mark - Event
- (void)feedbackClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"即将拨打客户电话？"
                                                                   message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"呼叫客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }]];
    [[WBMediator sharedManager].topViewController presentViewController:alert animated:YES completion:nil];
}

- (void)messageClick
{
    [[WBMediator sharedManager] gotoMessageController];
    [_badgeView removeFromSuperview];
}

#pragma mark - Getter
- (UILabel *)tipLabel
{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont systemFontOfSize:15];
    }
    return _tipLabel;
}

- (UIButton *)feedbackBtn
{
    if(!_feedbackBtn){
        _feedbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 44, 44)];
        [_feedbackBtn setImage:[UIImage imageNamed:@"kefu"] forState:UIControlStateNormal];
        [_feedbackBtn setImageEdgeInsets:UIEdgeInsetsMake(8.5, 8.5, 8.5, 8.5)];
        [_feedbackBtn addTarget:self action:@selector(feedbackClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feedbackBtn;
}

- (UIButton *)messageBtn
{
    if(!_messageBtn){
        _messageBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-54, 5, 44, 44)];
        [_messageBtn setImage:[UIImage imageNamed:@"tongzhi"] forState:UIControlStateNormal];
        [_messageBtn setImageEdgeInsets:UIEdgeInsetsMake(8.5, 9.5, 8.5, 9.5)];
        [_messageBtn addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

- (UIView *)badgeView
{
    if(!_badgeView){
        _badgeView = [[UIView alloc] initWithFrame:CGRectMake(42, -2, 4, 4)];
        _badgeView.backgroundColor = HEX_RGB(0xf45252);
        _badgeView.layer.cornerRadius = _badgeView.width/2;
        _badgeView.layer.masksToBounds = YES;
    }
    return _badgeView;
}
@end
