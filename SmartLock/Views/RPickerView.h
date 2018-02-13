//
//  RPickerView.h
//  SmartLock
//
//  Created by Richard Shen on 2018/2/13.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPickerView : UIView
{
    UIButton *_cancelBtn;
    UIView *_contentView;
    UIButton *_resetBtn;
    UIButton *_confirmBtn;
    UILabel *_titleLabel;
}

@property (nonatomic, strong) NSString *title;

- (void)showInView:(UIView *)superview;
- (void)dismissClick;

- (void)cancelClick;
- (void)confirmClick;
@end
