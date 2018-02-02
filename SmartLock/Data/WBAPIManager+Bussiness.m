//
//  WBAPIManager+Bussiness.m
//  Weimai
//
//  Created by Richard Shen on 16/1/14.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import "WBAPIManager+Bussiness.h"
#import "WBBannerInfo.h"
#import "WBMsgInfo.h"
#import "WBTopicInfo.h"
#import "WBActivityInfo.h"
#import "WBWeiboManager.h"
#import "WBTagInfo.h"
#import "WBCustomerInfo.h"
#import "WBOrderInfo.h"
#import "WBUtil.h"
#import "WBProductInfo.h"
#import "WBIncomeInfo.h"
#import "WBInviterInfo.h"
#import "WBSysMessage.h"
#import "WBMineOrderInfo.h"
#import "WBOrderMessage.h"
#import "WBComment.h"
#import "WBChoiceInfo.h"
#import "WBMineOrderDetailInfo.h"
#import "NSDate+BeeExtension.h"
#import "WBCategoryInfo.h"


@implementation WBAPIManager (Bussiness)

+ (RACSignal *)getBanners
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/app/topbillboard" params:nil uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSArray *data) {
        NSArray *banners = [WBBannerInfo mj_objectArrayWithKeyValuesArray:data];
        return banners;
    }];
}

+ (RACSignal *)getShiLing
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/cfg/top4places" params:nil uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSArray *data) {
        NSString *url = nil;
        for(NSDictionary *dic in data){
            if([dic[@"title"] isEqualToString:@"时令特色"]){
                url = dic[@"activeUrl"];
            }
        }
        return url;
    }];
}

/**
 *  获取分类列表
 *
 */
+ (RACSignal *)getCategoryList:(NSInteger)page
{
    NSDictionary *params = @{@"pid":@(0),
                             @"version":versionWithoutDot()};
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/app/categorylist" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSArray *data) {
        //NSArray *messages = [WBMsgInfo mj_objectArrayWithKeyValuesArray:data];
        return data;
    }];
}


+ (RACSignal *)getIncome
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/account/income" params:nil uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSString *allincome = [NSString stringWithFormat:@"%lf", (double)[data[@"allincome"] floatValue]];
        manager.loginUser.allRevenue = [NSDecimalNumber decimalNumberWithString:allincome];

        NSString *mymoney = [NSString stringWithFormat:@"%lf", (double)[data[@"mymoney"] floatValue]];
        manager.loginUser.revenue = [NSDecimalNumber decimalNumberWithString:mymoney];
        
        NSString *commission = [NSString stringWithFormat:@"%lf", (double)[data[@"allshangbao"] floatValue]];
        manager.loginUser.commission = [NSDecimalNumber decimalNumberWithString:commission];
        
        NSString *income = [NSString stringWithFormat:@"%lf", (double)[data[@"allweimai"] floatValue]];
        manager.loginUser.income = [NSDecimalNumber decimalNumberWithString:income];
        
        NSString *friendCommission = [NSString stringWithFormat:@"%lf", (double)[data[@"allshangbao_recommend"] floatValue]];
        manager.loginUser.friendCommission = [NSDecimalNumber decimalNumberWithString:friendCommission];
        
        manager.loginUser.weekRevenues = data[@"mingxi"];
        [WBStoreManager saveObject:manager.loginUser forKey:kSaveUser];
        return manager.loginUser;
    }];
}

+ (RACSignal *)getFrozenIncome
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/account/frozen" params:nil uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSString *doubleString = [NSString stringWithFormat:@"%lf", (double)[data[@"allfrozen"] floatValue]];
        manager.loginUser.frozenRevenue = [NSDecimalNumber decimalNumberWithString:doubleString];
        
        NSString *frozen = [NSString stringWithFormat:@"%lf", (double)[data[@"frozen"] floatValue]];
        manager.loginUser.frozenTransaction = [NSDecimalNumber decimalNumberWithString:frozen];
        
        NSString *sevenfrozen = [NSString stringWithFormat:@"%lf", (double)[data[@"sevenfrozen"] floatValue]];
        manager.loginUser.frozen7day = [NSDecimalNumber decimalNumberWithString:sevenfrozen];
        
        [WBStoreManager saveObject:manager.loginUser forKey:kSaveUser];
        return manager.loginUser;
    }];
}

+ (RACSignal *)getCustomers:(NSInteger)page
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/shop/customlist" params:@{@"pageno":@(page)} uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *customers = [WBCustomerInfo mj_objectArrayWithKeyValuesArray:data[@"result"]];
        return customers;
    }];
}

+ (RACSignal *)getOrdersWithPage:(NSInteger)page type:(NSInteger)type
{
    switch (type) {
        case 0:
            type = 2;
            break;
        case 1:
            type = 1;
            break;
        case 2:
            type = 3;
            break;
        case 3:
            type = 0;
            break;
    }
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/order/list" params:@{@"pageno":@(page),@"state":@(type),@"uid":manager.accessToken.uid} uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *orders = [WBOrderInfo mj_objectArrayWithKeyValuesArray:data[@"list"]];
        return orders;
    }];
}

+ (RACSignal *)getProductListWithPage:(NSInteger)page
                                 type:(NSInteger)type
                                 sort:(NSString *)sort
                                filte:(NSDictionary *)filte
{
    WBAPIManager *manager = [self sharedManager];
    NSMutableDictionary *params = @{@"pageno":@(page),@"num":@(20)}.mutableCopy;
    [params setObject:@(type) forKey:@"is_shelf"];
    [params setObject:sort forKey:@"order"];
    if(filte.count >0){
        [params addEntriesFromDictionary:filte];
    }
    if([sort isEqualToString:@"stock"]){
        [params setObject:@"asc" forKey:@"sort"];
    }
    else{
        [params setObject:@"desc" forKey:@"sort"];
    }
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/listnew" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *products = [WBProductInfo mj_objectArrayWithKeyValuesArray:data[@"list"]];
        return products;
    }];
}

+ (RACSignal *)getProductListWithPage:(NSInteger)page
                                param:(NSInteger)param
                                  key:(NSString *)key
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"pageno":@(page),
                             @"num":@(20),
                             @"param":@(param),
                             @"keyword":key};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/listnew" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *products = [WBProductInfo mj_objectArrayWithKeyValuesArray:data[@"list"]];
        return products;
    }];
}

+ (RACSignal *)getSearchProductListWithPage:(NSInteger)page
                                        key:(NSString *)key
{
    WBAPIManager *manager = [self sharedManager];
    NSMutableDictionary *params = @{@"pageno":@(page),@"num":@(20)}.mutableCopy;
    [params setObject:key forKey:@"itemname"];
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/search" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *products = [WBProductInfo mj_objectArrayWithKeyValuesArray:data[@"list"]];
        return products;
    }];
}

+ (RACSignal *)getProductSku:(NSString *)pid info:(NSDictionary *)info
{
    WBAPIManager *manager = [self sharedManager];
    NSMutableDictionary *params = [@{@"pid":pid} mutableCopy];
    [params addEntriesFromDictionary:info];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/sku" params:params uploadImage:nil];
    
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        return data;
    }];
}

+ (RACSignal *)checkGroupStatus:(NSString *)pid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"pid":pid};
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/groupon/status" params:params uploadImage:nil];
    
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        return data;
    }];
}

+ (RACSignal *)checkStockStatus:(NSString *)pid mid:(NSString *)mid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"pid":pid,@"mid":mid};
    NSURLRequest *request = [manager requestWithMethod:@"/client/c/stock/status" params:params uploadImage:nil];
    
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        return data;
    }];
}

+ (RACSignal *)addStock:(NSString *)pid mid:(NSString *)mid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"pid":pid,@"mid":mid};
    NSURLRequest *request = [manager requestWithMethod:@"/client/c/stock/addstock" params:params uploadImage:nil];
    
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        return data;
    }];
}

+ (RACSignal *)checkProductSkuInfo:(NSString *)pid skus:(NSString *)skujson
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"pid":pid,@"namevalue":skujson};
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/skuinfo" params:params uploadImage:nil];
    
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        return data;
    }];
}

+ (RACSignal *)deleteProductsWithIds:(NSString *)ids
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"itemids":ids};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/batch/delete" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)shelfProductsWithIds:(NSString *)ids
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"itemids":ids};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/batch/shelf" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)unshelfProductsWithIds:(NSString *)ids
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"itemids":ids};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/batch/unshelf" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getIncomeListWithPage:(NSInteger)page
{
    WBAPIManager *manager = [self sharedManager];
    NSMutableDictionary *params = @{@"pageno":@(page),@"num":@(20)}.mutableCopy;
    NSURLRequest *request = [manager requestWithMethod:@"/client/account/detail" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *incomes = [WBIncomeInfo mj_objectArrayWithKeyValuesArray:data[@"result"]];
        return incomes;
    }];
}


+ (RACSignal *)createProduct:(NSString *)desc price:(NSString *)price rprice:(NSString *)rprice stock:(NSString *)stock freight:(NSString *)freight categoryid:(NSString *)categoryid itemname:(NSString *)itemname detail:(NSString *)detail img:(NSArray *)imgs
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"description":desc,
                                                                                  //@"price":price,
                                                                                  //@"rprice":rprice,
                                                                                  @"freight":freight,
                                                                                  //@"stock":stock,
                                                                                  @"itemname":itemname,
                                                                                  @"categoryid":categoryid}];
    NSArray *detailArray = [NSJSONSerialization JSONObjectWithData:[detail dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    if (detailArray && detailArray.count > 0) {
        [params setObject:detail forKey:@"detail"];
    }else
    {
        [params setObject:price forKey:@"price"];
        [params setObject:price forKey:@"rprice"];
        [params setObject:stock forKey:@"stock"];
    }

    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/create" params:params uploadImages:imgs];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSLog(@"createProduct :%@",data);
        return data;
    }];
}

+ (RACSignal *)updateProduct:(NSString *)pid desc:(NSString *)desc imgs:(NSString *)imgsStr price:(NSString *)price tburl:(NSString *)tburl title:(NSString *)title label:(NSString *)labelStr
{
    NSMutableDictionary *params =[NSMutableDictionary dictionaryWithDictionary:@{@"iid":pid,
                                                                                 @"desc":desc,
                                                                                 @"imgs":imgsStr,
                                                                                 @"price":price,
                                                                                 @"tburl":tburl,
                                                                                 @"title":title}];
    if (labelStr.length > 0) {
        [params setObject:labelStr forKey:@"labels"];
    }
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/product/update" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSLog(@"updateProduct :%@",data);
        return data;
    }];
    
}

+ (RACSignal *)createPhoto:(NSString *)desc imgs:(NSString *)imgsStr iids:(NSString *)iids label:(NSString *)labelStr
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"desc":desc,
                                                                                  @"imgs":imgsStr}];
    if (iids.length > 0) {
        [params setObject:iids forKey:@"iids"];
    }
    if (labelStr.length > 0) {
        [params setObject:labelStr forKey:@"labels"];
    }
    /* @{@"desc":desc,
                             @"imgs":imgsStr,
                             @"iids":iids,
                             @"labels":labelStr}];*/
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/picture/create" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSLog(@"createProduct :%@",data);
        return data;
    }];
}

+ (RACSignal *)updatePhoto:(NSString *)pid desc:(NSString *)desc imgs:(NSString *)imgsStr iids:(NSString *)iids label:(NSString *)labelStr
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"pid":pid,
                                                                                  @"desc":desc,
                                                                                  @"imgs":imgsStr,
                                                                                  @"labels":labelStr}];
    if (iids.length > 0) {
        [params setObject:iids forKey:@"iids"];
    }
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/picture/update" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSLog(@"updateProduct :%@",data);
        return data;
    }];
}

+ (RACSignal *)getGroupList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{}];

    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/app/grouplist" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSArray * data) {
    return data;
    }];
}

+ (RACSignal *)getProductListByType:(NSString *)groupId page:(NSUInteger )page
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"group_id" : groupId,@"page":@(page),@"num":@(kDefaultPageNum)}];
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/wholesale/list" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSArray *productList = [WBProductInfo groupListWithJson:data[@"list"]];
        return productList;
    }];
}

+ (RACSignal *)getShopList:(NSString *)key page:(NSUInteger )page
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(page),@"num":@(kDefaultPageNum)}];
    if (key && [key isKindOfClass:[NSString class]] && key.length > 0) {
        [params setObject:key forKey:@"keyword"];
    }
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/wholesale/merchants" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSArray *productList = [WBShopInfo groupListWithJson:[data objectForKey:@"list"]];
        return productList;
    }];
}

+ (RACSignal *)getShopProducts:(NSUInteger )page
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(page),@"num":@(kDefaultPageNum)}];
    
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/products" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSArray *productList = [WBProductInfo groupListWithJson:[data objectForKey:@"list"]];
        return productList;
    }];
}

+ (RACSignal *)searchProduct:(NSString *)key page:(NSUInteger )page info:(NSDictionary *)info
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"keyword" : key}];
    [params addEntriesFromDictionary:info];
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/wholesale/list" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSArray *productList = [WBProductInfo groupListWithJson:data[@"list"]];
        return productList;
    }];
}

+ (RACSignal *)searchProductByClassid:(NSString *)classid keyword:(NSString *)keyword  page:(NSUInteger )page info:(NSDictionary *)info
{
    NSMutableDictionary *params = [@{@"class_id" : classid,@"keyword" : keyword,@"page":@(page)} mutableCopy];
 [params addEntriesFromDictionary:info];
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/wholesale/list" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSArray *productList = [WBProductInfo groupListWithJson:data[@"list"]];
        return productList;
    }];
}


+ (RACSignal *)getMarketBanner
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/wholesale/banner" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSArray * data) {
        NSArray *banners = [WBBannerInfo getMarketList:data];
        return banners;
    }];
}

+ (RACSignal *)addFavorite:(BOOL)isProduct dataId:(NSString *)dataId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"data_id":dataId,
                                                                                  @"type":isProduct?@"1":@"2"}];
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/favorite/create" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSArray * data) {
        NSArray *banners = [WBBannerInfo mj_objectArrayWithKeyValuesArray:data];
        return banners;
    }];
}

+ (RACSignal *)cancelFavorite:(BOOL)isProduct dataId:(NSString *)dataId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"data_id":dataId,
                                                                                  @"type":isProduct?@"1":@"2"}];
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/favorite/delete" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSArray * data) {
        NSArray *banners = [WBBannerInfo mj_objectArrayWithKeyValuesArray:data];
        return banners;
    }];
}

+ (RACSignal *)getMyFavShopList:(NSUInteger)page type:(NSUInteger )type searchKey:(NSString *)key
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(page),
                                                                                  @"type":@"2",
                                                                                  @"my_type":@(type),
                                                                                  @"num":@(kDefaultPageNum)}];
    if (key) {
        [params setObject:key forKey:@"keyword"];
    }
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/favorite/list" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSArray *shops = [WBShopInfo favGroupListWithJson:[data objectForKey:@"list"]];
        return shops;
    }];
}

+ (RACSignal *)getMyFavProductList:(NSUInteger)page type:(NSUInteger )type searchKey:(NSString *)key
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"page":@(page),
                                                                                  @"type":@"1",
                                                                                  @"my_type":@(type),
                                                                                  @"num":@(kDefaultPageNum)}];
    if (key) {
        [params setObject:key forKey:@"keyword"];
    }
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/favorite/list" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSArray *products = [WBProductInfo favGroupListWithJson:[data objectForKey:@"list"]];
        return products;
    }];
    
}


+ (RACSignal *)setTop:(NSString *)pid mode:(NSUInteger)mode
{
    WBAPIManager *manager = [self sharedManager];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"iid":pid,
                                                                                  @"type":@(mode),
                                                                                  @"uid":manager.loginUser.userid}];
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/top/setnew" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        return data[@"sort_weight"];
    }];
}

/**
 * 商品取消置顶
 *
 * @return
 */

+ (RACSignal *)unsetTop:(NSString *)pid mode:(NSUInteger)mode
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"iid":pid,
                             @"type":@(mode),
                             @"uid":manager.loginUser.userid};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/top/unsetnew" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)deleteProduct:(NSString *)pid type:(NSInteger )type
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"itemid":pid,@"type":@(type)};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/delete" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

/**
 * 代理商品删除
 *
 * @return
 */
+ (RACSignal *)deletecProduct:(NSString *)pid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"itemid":pid};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/cdelete" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

+ (RACSignal *)getProDetail:(NSString *)pid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"itemid":pid};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/detail" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

/**
 * 商品详情
 *
 * @return
 */

+ (RACSignal *)getProBDetail:(NSString *)pid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"itemid":pid};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/bdetail" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

+ (RACSignal *)updateProduct:(WBProductInfo *)product removeImgStr:(NSString *)removeStr
{
   WBAPIManager *manager = [self sharedManager];
   NSString *priceStr = [NSString stringWithFormat:@"%.2f",product.price];
   NSMutableDictionary *params = [@{@"itemid":product.pid,
                             @"itemname":product.title,
                             @"price": priceStr,
                             @"freight":@(product.postage),
                             @"stock":@(product.stock),
                             @"remove_list":removeStr,
                             @"description":product.desc,
                             @"categoryid":product.categoryId} mutableCopy];
    
    if (product.typeArray.count > 0) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:product.typeArray options:NSJSONWritingPrettyPrinted error:nil];
        NSString *detailstr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [params setObject:detailstr forKey:@"detail"];
    }
    
    
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/update" params:params uploadImages:product.imgs];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

+ (RACSignal *)addCategory:(NSString *)cateId product:(NSString *)pid type:(NSInteger)type
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"type":@(type),
                             @"groupid":cateId,
                             @"itemid":pid};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/addgroup" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}





+ (RACSignal *)delCategory:(NSString *)cateId product:(NSString *)pid type:(NSInteger)type
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"type":@(type),
                             @"groupid":cateId,
                             @"itemid":pid};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/delgroup" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

+ (RACSignal *)setCategory:(NSString *)cateIds product:(NSString *)pid type:(NSInteger)type
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"type":@(type),
                             @"groupid":cateIds,
                             @"itemid":pid};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/setgroup" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}


+ (RACSignal *)updateProductRecommend:(NSString *)pid type:(NSInteger)type isRecommend:(BOOL)isRecommend
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"type":@(type),
                             @"iid":pid};
    NSURLRequest *request = [manager requestWithMethod:isRecommend?@"/client/product/recommend/set":@"/client/product/recommend/unset" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

+ (RACSignal *)getpGroupList
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/group/list" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}


+ (RACSignal *)createpGroup:(NSString *)cateName
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"name":cateName};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/group/create" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

+ (RACSignal *)delpGroup:(NSString *)groupid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"groupid":groupid};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/group/delete" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

+ (RACSignal *)sortGroup:(NSDictionary *)sortDic
{
    WBAPIManager *manager = [self sharedManager];
    NSMutableArray *sortArray = [NSMutableArray array];
    [sortDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        [sortArray addObject:@{@"group_id":key,@"seq":obj}];
    }];

    NSData *data = [NSJSONSerialization dataWithJSONObject:sortArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *sortStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary *params = @{@"sorts":sortStr};
    
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/group/sort" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

+ (RACSignal *)productshelf:(NSString *)pid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"itemids":pid};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/batch/shelf" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
       
        return data;
    }];
}

+ (RACSignal *)productunshelf:(NSString *)pid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"itemids":pid};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/batch/unshelf" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}


+ (RACSignal *)getGroupProductList:(NSString *)groupid isIn:(BOOL)isIn  page:(NSUInteger)page
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"groupid":groupid,@"is_out":isIn == YES?@1:@2,@"page":@(page),@"num":@(kDefaultPageNum)};
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/groupitems" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

+ (RACSignal *)invitationAgent
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/invitation/agent" params:nil uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getInviteList:(NSInteger)type
{
    NSString *method = nil;
    if(type == 0){
        method = @"/client/invitation/inviter";
    }
    else if(type == 1){
        method = @"/client/invitation/invitee";
    }
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:method params:nil uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(id data) {
        if([data isKindOfClass:[NSDictionary class]]){
            WBInviterInfo *invite = [WBInviterInfo mj_objectWithKeyValues:data];
            if(invite){
                return @[invite];
            }
            return nil;
        }
        else
        {
            NSArray *invites = [WBInviterInfo mj_objectArrayWithKeyValuesArray:data];
            return invites;
        }
    }];
}

+ (RACSignal *)getShopNews
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"page":@(1),@"num":@(5)};
    NSURLRequest *request = [manager requestWithMethod:@"/client/shop/news" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return [data objectForKey:@"list"];
    }];
}

+ (RACSignal *)getProductsInChannel:(NSUInteger )channel  page:(NSUInteger)page
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"page":@(page),@"num":@(kDefaultPageNum),@"type":@(channel)};
    NSURLRequest *request = [manager requestWithMethod:@"/client/wholesale/products" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

+ (RACSignal *)getShopLog:(NSUInteger )days
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"time":@(days)};
    NSURLRequest *request = [manager requestWithMethod:@"/client/shop/stats" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data ;
    }];
}


+ (RACSignal *)getFirstOrderMsg
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *params = @{@"version":app_Version};
    NSURLRequest *request = [manager requestWithMethod:@"/client/push/ordermsg/first" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        WBSysMessage *sysMsg = [WBSysMessage new];
        sysMsg.sysMsgType = 1;
        sysMsg.unreadCount = [data[@"unread_count"] integerValue];
        sysMsg.img = @"订单消息图标";
        sysMsg.pushText = [data[@"list"] objectForKey:@"title"];
        NSString *strTime = [data[@"list"] objectForKey:@"create_time"];
        sysMsg.time = [[NSDate dateWithString:strTime] timeIntervalSince1970];
        return sysMsg ;
    }];
}

+ (RACSignal *)getOrderMsgList:(NSUInteger )page
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *params = @{@"page":@(page),@"version":app_Version};
    NSURLRequest *request = [manager requestWithMethod:@"/client/push/ordermsg/msglist" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
       NSArray *msgs = [WBOrderMessage mj_objectArrayWithKeyValuesArray:data[@"list"]];
        return msgs;
    }];
}

+ (RACSignal *)getSysList:(NSUInteger )page
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"page":@(page)};
    NSURLRequest *request = [manager requestWithMethod:@"/client/push/msglist" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return [WBSysMessage mj_objectArrayWithKeyValuesArray:[data objectForKey:@"result"]];
    }];
}

+ (RACSignal *)getOrderSummary
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/summary" params:nil uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return @[data[@"unpaied"],data[@"unsend"],data[@"unreceived"],data[@"uncomment"]];
    }];
}

+ (RACSignal *)ordersWithStatus:(NSInteger )status page:(NSUInteger)page
{
    if(status == 0){
        status = -1;
    }
    
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"uid":manager.accessToken.uid,
                             @"status":@(status),
                             @"page":@(page),
                             @"num":@(20)};

    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/list" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *orders = [WBMineOrderInfo mj_objectArrayWithKeyValuesArray:data[@"list"]];
        for(WBMineOrderInfo *order in orders){
            order.reasons = data[@"cancel_reason"];
        }
        return orders;
    }];

}

+ (RACSignal *)takeDeliveryWithOrderID:(NSString *)orderid
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"oid":orderid,
                             @"type":@(2)};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/change" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)cancelOrderWithOrderID:(NSString *)orderid reason:(NSString *)reasonType
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"oid":orderid,
                             @"type":@(1),
                             @"cancel_reason":reasonType};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/change" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)delayDeliveryWithOrderID:(NSString *)orderid orderNum:(NSString *)number
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"oid":orderid,
                             @"orderid":number};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/delay" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)deleteOrderWithID:(NSString *)orderid type:(NSInteger)type
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"oid":orderid,
                             @"order_type":@(type)};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/delete" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getRateOrders
{
    WBAPIManager *manager = [self sharedManager];

    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/comment/listmore" params:nil uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSArray *data) {
        NSArray *orders = [WBMineOrderInfo mj_objectArrayWithKeyValuesArray:data];
        return orders;
    }];
}

+ (RACSignal *)addCommentWithOrderID:(NSString *)orderid
                                type:(NSInteger)type
                                 pid:(NSString *)pid
                           descScore:(NSInteger)dScore
                        deliverScore:(NSInteger)deScore
                        serviceScore:(NSInteger)sScore
                                imgs:(NSArray *)imgs
                             content:(NSString *)content
                         commentType:(NSInteger)cType
{
    NSString *imgString = @"";
    if(imgs.count != 0){
        imgString = [imgs componentsJoinedByString:@"|"];
    }
    
    WBAPIManager *manager = [self sharedManager];
    NSMutableDictionary *params = @{@"oid":orderid,
                                    @"order_type":@(type),
                                     @"pid":pid,
                                     @"imgs":imgString,
                                     @"comment":content?:@"此用户没有填写评价。",
                                     @"type":@(cType)}.mutableCopy;
    if(cType == 1){
        [params addEntriesFromDictionary:@{@"desc_score":@(dScore),
                                           @"delivery_score":@(deScore),
                                           @"service_score":@(sScore)}];
    }
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/comment/add" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)commentDetailWithOrderID:(NSString *)orderid type:(NSInteger)type
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"oid":orderid,
                             @"order_type":@(type)};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/detail" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        return ((NSArray *)data[@"comment"]).firstObject;
    }];
}

+ (RACSignal *)getCommentList:(NSString *)pid page:(NSUInteger)page
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"pid":pid,
                             @"page":@(page),
                             @"page_num":@(20)};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/product/comment/list" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *comments = [WBComment mj_objectArrayWithKeyValuesArray:data];
        return  comments;
    }];
}

+ (RACSignal *)getClassifiList
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/classification/list" params:@{} uploadImage:nil];

    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        return  data;
    }];
}

+ (RACSignal *)getDiscountList
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/discount/index" params:nil uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getChoiceListWithType:(NSInteger)type
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/choice/list" params:@{@"type":@(type)} uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *choices = [WBChoiceInfo mj_objectArrayWithKeyValuesArray:data];
        return  choices;
    }];
}

+ (RACSignal *)commitSupply:(NSDictionary *)content
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/supply/commit" params:content uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        return  data;
    }];
}

+ (RACSignal *)getOrderInfoWithOid:(NSString *)oid mid:(NSString *)mid type:(NSInteger)type
{
    NSDictionary *params = @{@"oid":oid,
                             @"mid":mid?:@"",
                             @"order_type":@(type)};

    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/info" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        WBMineOrderDetailInfo *order = [WBMineOrderDetailInfo mj_objectWithKeyValues:data];
        order.addrId = data[@"address"][@"addr_id"];
        return  order;
    }];
}

+ (RACSignal *)getSearchMineOrderListWithPage:(NSInteger)page
                                          key:(NSString *)key
{
    WBAPIManager *manager = [self sharedManager];
    NSDictionary *params = @{@"pageno":@(page),
                             @"num":@(20),
                             @"status":@(-1),
                             @"keyword":key,
                             @"uid":manager.accessToken.uid};
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/list" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        NSArray *orders = [WBMineOrderInfo mj_objectArrayWithKeyValuesArray:data[@"list"]];
        return orders;
    }];
}


+ (RACSignal *)newRefund:(NSString *)oid fee:(NSString *)fee type:(NSUInteger)type remark:(NSString *)remark reason:(NSUInteger )reason pics:(NSString *)applyPics
{
    WBAPIManager *manager = [self sharedManager];
    NSMutableDictionary *params = [@{@"oid":oid,
                             @"total_fee":fee,
                             @"type":@(type),
                             @"reason":@(reason),
                             @"apply_pics": applyPics} mutableCopy];
    if (remark.length > 0) {
        [params setObject:remark forKey:@"remark"];
    }
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/refund/apply" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        
        return data;
    }];
}

+ (RACSignal *)updateRefund:(NSString *)oid fee:(NSString *)fee type:(NSUInteger)type remark:(NSString *)remark reason:(NSUInteger )reason pics:(NSString *)applyPics{
    WBAPIManager *manager = [self sharedManager];
    NSMutableDictionary *params = [@{@"oid":oid,
                                     @"total_fee":fee,
                                     @"type":@(type),
                                     @"reason":@(reason),
                                     @"apply_pics": applyPics} mutableCopy];
    if (remark.length > 0) {
        [params setObject:remark forKey:@"remark"];
    }
    
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/refund/edit" params:params uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary *data) {
        return data;
    }];
}

+ (RACSignal *)cancelRefundOrder:(NSString *)oid
{
    NSDictionary *params = @{@"oid":oid};
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/refund/cancel" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)refundOrderDetail:(NSString *)oid rid:(NSString *)rid
{
    NSDictionary *params = @{@"oid":oid,
                             @"refund_id":rid?:@""};
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/refund/info" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getExpressList
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/express/list" params:@{} uploadImage:nil];
    return [manager signalWithRequest:request];
}


+ (RACSignal *)addExpress:(NSString *)oid company:(NSString *)company num:(NSString *)num remark:(NSString *)remark pics:(NSString *)pics{
    NSMutableDictionary *params = [@{@"express":company,
                             @"express_num":num,
                             @"oid":oid} mutableCopy];
    if(remark.length > 0){
        [params setObject:remark forKey:@"express_remark"];
    }
    if (pics.length > 0) {
        [params setObject:pics forKey:@"express_pics"];
    }
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/refund/addexpress" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)confirmOrder:(NSDictionary *)args
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/confirmorder" params:args uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)createOrder:(NSDictionary *)args
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/order/create" params:args uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getNewCategoryList
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/classification/listsuggest" params:nil uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getSuggestCategoryById:(NSString *)cid
{
    NSDictionary *params = @{@"f_id":cid};
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/classification/listSuggestById" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getHotSuggestCategoryById:(NSString *)cid
{
    NSDictionary *params = @{@"class_id":cid,
                             @"is_wholesale":@(0),
                             @"num":@(20),
                             @"page":@(1)};
    
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/classification/hotsuggest" params:params uploadImage:nil];
    return [manager signalWithRequest:request];
}

+ (RACSignal *)getLikeProductList
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/wholesale/list" params:@{@"is_wholesale":@(0),@"orderby":@"sales",@"num":@(6),@"page":@(1)} uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        NSArray *productList = [WBProductInfo groupListWithJson:data[@"list"]];
        return productList;
    }];
}

+ (RACSignal *)getTBProductDetail:(NSString *)pid
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/product/detail" params:@{@"product_id":pid} uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSDictionary * data) {
        return data;
    }];
}

+ (RACSignal *)getHomeProducts:(NSInteger)page
{
    WBAPIManager *manager = [self sharedManager];
    NSURLRequest *request = [manager requestWithMethod:@"/client/buyer/product/youmaylike" params:@{@"count":@(20),@"page":@(page)} uploadImage:nil];
    return [[manager signalWithRequest:request] map:^id(NSArray * data) {
        NSArray *products = [WBProductInfo groupListWithJson:data];
        return products;
    }];
}

@end
