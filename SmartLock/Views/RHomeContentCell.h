//
//  RHomeContentCell.h
//  SmartLock
//
//  Created by Richard Shen on 2018/1/17.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHomeContentCell : UIButton

@property (nonatomic, strong) UILabel *txtLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIImageView *imgView;

- (void)setRightImage:(UIImage *)image disableImage:(UIImage *)disableImg;
@end
