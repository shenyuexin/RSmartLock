//
//  WBOrderViewCell.h
//  Weimai
//
//  Created by Richard Shen on 16/9/8.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString * const WBOrderViewCellIdentifier;

@interface WBOrderViewCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger index;
//不用类型的订单数据
@property (nonatomic, weak) NSMutableDictionary *data;
@property (nonatomic, strong) NSString *lockId;

- (void)updateData;
@end
