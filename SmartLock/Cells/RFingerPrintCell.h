//
//  RFingerPrintCell.h
//  SmartLock
//
//  Created by Richard Shen on 2018/1/22.
//  Copyright © 2018年 Richard Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString * const RFingerPrintCellIdentifier;

@interface RFingerPrintCell : UITableViewCell
{
    UILabel *_nameLabel;
    UILabel *_stateLabel;
    UILabel *_actionLabel;
}

@property (nonatomic, assign, getter=isRecorded) BOOL record;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, strong) NSString *title;
@end
