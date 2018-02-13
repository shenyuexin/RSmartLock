//
//  WBMediator.m
//  Weimai
//
//  Created by Richard Shen on 16/3/24.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import "WBMediator.h"

@implementation WBMediator

+ (instancetype)sharedManager
{
    static WBMediator *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [WBMediator new];
    });
    return manager;
}

- (UIViewController *)topViewController
{
    UINavigationController *navController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    if(navController.presentedViewController){
//        UINavigationController *presentedNavController = (UINavigationController *)selectNavController.presentedViewController;
//        return presentedNavController.topViewController;
//    }
    return navController.topViewController;
}

- (void)gotoController:(UIViewController *)controller
{
    controller.hidesBottomBarWhenPushed = YES;
    [self.topViewController.navigationController pushViewController:controller animated:YES];
}

- (UIViewController *)controllerWithName:(NSString *)name
{
    Class targetClass = NSClassFromString(name);
    UIViewController *contoller = [[targetClass alloc] init];
    return contoller;
}

#pragma mark - Method
- (void)gotoLoginControllerWithAnimate:(BOOL)animate
{
    UIViewController *controller = [self controllerWithName:@"RLoginViewController"];
    [self.topViewController presentViewController:controller animated:animate completion:^{
        [self.topViewController.navigationController popToRootViewControllerAnimated:NO];
    }];
}

- (void)gotoQRCodeController
{
    UIViewController *controller = [self controllerWithName:@"RQRCodeViewController"];
    [self gotoController:controller];
}

- (void)gotoMessageController
{
    UIViewController *controller = [self controllerWithName:@"RMessageViewController"];
    [self gotoController:controller];
}

- (void)gotoReportController
{
    UIViewController *controller = [self controllerWithName:@"RReportViewController"];
    [self gotoController:controller];
}

- (void)gotoSettingController
{
    UIViewController *controller = [self controllerWithName:@"RSettingViewController"];
    [self gotoController:controller];
}

- (void)gotoModifyPasswordController
{
    UIViewController *controller = [self controllerWithName:@"RPasswordViewController"];
    [self gotoController:controller];
}

- (void)gotoRecordsController
{
    UIViewController *controller = [self controllerWithName:@"RRecordsViewController"];
    [self gotoController:controller];
}

- (void)gotoFingerPrintController
{
    UIViewController *controller = [self controllerWithName:@"RFingerprintViewController"];
    [self gotoController:controller];
}

- (void)gotoPrintingController
{
    UIViewController *controller = [self controllerWithName:@"RPrintingViewController"];
    [self.topViewController.navigationController presentViewController:controller animated:YES completion:nil];
}

- (void)gotoICController
{
    UIViewController *controller = [self controllerWithName:@"RICViewController"];
    [self gotoController:controller];
}

- (void)gotoICVerifyController
{
    UIViewController *controller = [self controllerWithName:@"RICVerifyViewController"];
    [self gotoController:controller];
}

- (void)gotoFaceController
{
    UIViewController *controller = [self controllerWithName:@"RFaceViewController"];
    [self gotoController:controller];
}

- (void)gotoLockInfoController:(id)lock
{
    UIViewController *controller = [self controllerWithName:@"RLockInfoViewController"];
    SEL action = NSSelectorFromString(@"setLock:");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [controller performSelector:action withObject:lock];
#pragma clang diagnostic pop
    [self gotoController:controller];
}

- (void)gotoAddressController:(id)lock
{
    UIViewController *controller = [self controllerWithName:@"RAddressViewController"];
    SEL action = NSSelectorFromString(@"setLock:");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [controller performSelector:action withObject:lock];
#pragma clang diagnostic pop
    [self gotoController:controller]; 
}

- (void)gotoSetPersonController:(id)lock
{
    UIViewController *controller = [self controllerWithName:@"RPersonViewController"];
    SEL action = NSSelectorFromString(@"setLock:");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [controller performSelector:action withObject:lock];
#pragma clang diagnostic pop
    [self gotoController:controller];
}

- (void)gotoAddPersonController:(id)lock
{
    UIViewController *controller = [self controllerWithName:@"RAddPersonViewController"];
    SEL action = NSSelectorFromString(@"setLock:");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [controller performSelector:action withObject:lock];
#pragma clang diagnostic pop
    [self gotoController:controller];
}
@end
