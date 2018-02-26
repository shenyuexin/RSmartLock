//
//  WBMediator.h
//  Weimai
//
//  Created by Richard Shen on 16/3/24.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBMediator : NSObject

@property (nonatomic, weak) UIViewController *topViewController;

+ (instancetype)sharedManager;

//前往登录页
- (void)gotoLoginControllerWithAnimate:(BOOL)animate;

//前往二维码扫描页
- (void)gotoQRCodeController;

//前往消息页
- (void)gotoMessageController;

//前往异常反馈页
- (void)gotoReportController;

//前往设置页
- (void)gotoSettingController:(id)lock;

//前往修改密码页
- (void)gotoModifyPasswordController;

//前往开锁记录页
- (void)gotoRecordsController;

//前往设置录制指纹页
- (void)gotoFingerPrintController;

//前往录制提示页
- (void)gotoPrintingController;

//前往设置IC页
- (void)gotoICController;

//前往身份验证页
- (void)gotoICVerifyController;

//前往人脸验证页
- (void)gotoFaceController;

//前往锁详情页
- (void)gotoLockInfoController:(id)lock;

//前往编辑锁地址页面
- (void)gotoAddressController:(id)lock;

//前往设定许可人员页面
- (void)gotoSetPersonController:(id)lock;

//前往添加许可人员页面
- (void)gotoAddPersonController:(id)lock;

//前往用户开锁记录页面
- (void)gotoPersonRecordController:(NSString *)lockid personid:(NSString*)pid;
@end
