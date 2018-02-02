//
//  RICCell.m
//  SmartLock
//
//  Created by Richard Shen on 2018/1/22.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import "RICCell.h"

NSString * const RICCellIdentifier = @"RICCellIdentifier";

@implementation RICCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecord:(BOOL)record
{
    [super setRecord:record];
    [_stateLabel removeFromSuperview];
    
    if(!record){
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _actionLabel.text = @"配置";
        _actionLabel.textColor = HEX_RGB(0x297ce5);
    }
    else{
        self.accessoryType = UITableViewCellAccessoryNone;
        _actionLabel.text = @"身份证开锁";
        _actionLabel.textColor = HEX_RGB(0xaaaaaa);
    }
}

@end
