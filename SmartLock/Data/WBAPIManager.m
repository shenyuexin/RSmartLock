//
//  WBAPIManager.m
//  Weimai
//
//  Created by Richard Shen on 16/1/11.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import "WBAPIManager.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+BeeExtension.h"
//#import "WBCookieManager.h"
#import "APPMacro.h"
#import "NSDate+BeeExtension.h"

static NSInteger kSuccessCode = 100000;
static NSInteger kErrorToken = 10008;

@interface WBAPIManager()

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) AFURLSessionManager *sessionManager;
@end

@implementation WBAPIManager

+ (instancetype)sharedManager
{
    static WBAPIManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WBAPIManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if(self){

//        _accessToken = [WBStoreManager loadObjectForKey:kSaveToken];
//        _loginUser = [WBStoreManager loadObjectForKey:kSaveUser];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager = manager;
    }
    return self;
}

- (void)updateSaveUserInfo
{
//    [WBStoreManager saveObject:_loginUser forKey:kSaveUser];
}

- (void)startNetworkMonitoring
{
    self.reachManager = [AFNetworkReachabilityManager managerForDomain:@"www.baidu.com"];
    [self.reachManager startMonitoring];
}

//- (void)setAccessToken:(WBAccessToken *)accessToken
//{
//    if(_accessToken == accessToken) return;
//
//    _accessToken = accessToken;
//    [WBStoreManager saveObject:_accessToken forKey:kSaveToken];
//
//    [WBCookieManager saveCookie:_accessToken.uid forKey:@"uid"];
//    [WBCookieManager saveCookie:_accessToken.token forKey:@"token"];
////    [WBCookieManager saveCookie:deviceUniqueIdentifier().MD5 forKey:@"mm_wm_uuid"];
//}
//
//- (void)setLoginUser:(WBUserInfo *)loginUser
//{
//    if(_loginUser == loginUser) return;
//
//    _loginUser = loginUser;
//    [WBStoreManager saveObject:_loginUser forKey:kSaveUser];
//}

- (BOOL)isLogin
{
    static NSInteger i = 1;
    if(i == 1){
        i++;
        return NO;
    }
    return YES;
}

+ (BOOL)isLogin
{
    return [WBAPIManager sharedManager].isLogin;
}

+ (void)notifyLogin
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationInvalidToken object:nil];
}

#pragma mark - NSURLRequest
- (NSString *)signWithParams:(NSDictionary *)params key:(NSString *)key
{
    NSArray *keys = [params allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableString *mutStr = [NSMutableString string];
    
    [sortedArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = params[obj];
        if(!([value isKindOfClass:[NSString class]] && ((NSString *)value).length < 1)){
            [mutStr appendFormat:@"%@=%@",obj,params[obj]];
            if (idx != (sortedArray.count-1)) {
                [mutStr appendString:@"&"];
            }
        }
    }];
    [mutStr appendString:key];
    return [mutStr MD5];
}

- (NSURLRequest *)requestWithMethod:(NSString *)method
                             params:(NSDictionary *)params
                       uploadImages:(NSArray *)images
{
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:params];
    if(self.isLogin){
//        [parameters setObject:self.accessToken.token forKey:@"token"];
//        if(!params[@"uid"]){
//            [parameters setObject:self.accessToken.uid forKey:@"id"];
//        }
    }
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:URL_API(method) parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSUInteger i = 0;
        NSUInteger count = images.count;
        for (i = 0 ; i < count; i++) {
            NSData *imgData = UIImageJPEGRepresentation(images[i], 0.3);
            NSString *imgName = [NSString stringWithFormat:@"img%ld",(unsigned long)(i+1)];
            [formData appendPartWithFileData:imgData
                                        name:imgName
                                    fileName:imgName
                                    mimeType:@"multipart/form-data"];
        }
    }error:nil];
    request.timeoutInterval = kTimeoutInterval + images.count * 10;
    return request;
}

#pragma mark - RACSignal
- (RACSignal *)signalWithRequest:(NSURLRequest *)request
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [_sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id _Nonnull responseObject, NSError * _Nullable error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            if(error){
                //请求出现网络错误
                [subscriber sendError:[NSError errorWithDomain:error.localizedDescription code:error.code userInfo:nil]];
            }
            else{
                //从服务器返回数据
                if([responseObject isKindOfClass:[NSArray class]]){
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                }else{
                    NSString *errorMessage = responseObject[@"message"]?:responseObject[@"msg"];
                    if(!errorMessage){
                        errorMessage = @"请求出错";
                    }
                    if(responseObject[@"errorCode"] && [responseObject[@"errorCode"] integerValue] != kSuccessCode ){
                        [subscriber sendError:[NSError errorWithDomain:errorMessage code:[responseObject[@"errorCode"] integerValue] userInfo:nil]];
                        
                        if([responseObject[@"errorCode"] integerValue] == kErrorToken){
                            //Token失效重新登录
                            [WBAPIManager notifyLogin];
                        }
                    }
                    else if(responseObject[@"code"] && [responseObject[@"code"] integerValue] != kSuccessCode ){
                        [subscriber sendError:[NSError errorWithDomain:errorMessage code:[responseObject[@"code"] integerValue] userInfo:nil]];
                    }
                    else{
                        if(responseObject[@"data"]){
                            [subscriber sendNext:responseObject[@"data"]];
                            [subscriber sendCompleted];
                        }else{
                            if(responseObject[@"result"] && [responseObject[@"result"] respondsToSelector:@selector(boolValue)] && ![responseObject[@"result"] boolValue]){
                                [subscriber sendError:[NSError errorWithDomain:@"请求出错" code:0 userInfo:nil]];
                            }else{
                                [subscriber sendNext:responseObject];
                                [subscriber sendCompleted];
                            }
                        }
                    }
                }
            }
        }];
        [task resume];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        return [RACDisposable disposableWithBlock:^{
            if(task.state != NSURLSessionTaskStateCompleted){
                [task cancel];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            }
        }];
    }];
    return signal;
}
@end
