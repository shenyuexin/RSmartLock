//
//  WBAPIManager+Bussiness.h
//  Weimai
//
//  Created by Richard Shen on 16/1/14.
//  Copyright © 2016年 Weibo. All rights reserved.
//

#import "WBAPIManager.h"

@interface WBAPIManager (Bussiness)


/**
 *  获取首页顶部Banner列表
 *
 *  @return WBBannerInfo数组
 */
+ (RACSignal *)getBanners;


/**
 *  获取首页顶部时令特色
 *
 *  @return url
 */
+ (RACSignal *)getShiLing;

/**
 *  获取店铺收入
 *
 *  @return WBUserInfo
 */
+ (RACSignal *)getIncome;


/**
 *  获取冻结店铺收入
 *
 *  @return WBUserInfo
 */
+ (RACSignal *)getFrozenIncome;


/**
 *  获取我的客户列表
 *
 *  @param page 页码
 *
 *  @return @[WBCustomer]
 */
+ (RACSignal *)getCustomers:(NSInteger)page;

/**
 *  获取订单列表
 *
 *  @param page 页码
 *  @param type 订单类型
 *
 *  @return @[WBCustomer]
 */
+ (RACSignal *)getOrdersWithPage:(NSInteger)page type:(NSInteger)type;


/**
 *  获取商品列表
 *
 *  @param page     页码
 *  @param type     类型 [@"etime",@"sales",@"stock"]
 *  @param sort     排序方式 0-asc, 1-desc
 *  @param filte    筛选类型  0-全部商品, 1-自有商品，2-代理商品，3-置顶商品
 *
 *  @return @[WBProductInfo]
 */
+ (RACSignal *)getProductListWithPage:(NSInteger)page
                                 type:(NSInteger )type
                                 sort:(NSString *)sort
                                filte:(NSDictionary *)filte;

/**
 *  搜索商品列表
 *
 *  @param page     页码
 *  @param param    1自营，2代理
 *  @param key      搜索关键字
 *
 *  @return @[WBProductInfo]
 */
+ (RACSignal *)getProductListWithPage:(NSInteger)page
                                param:(NSInteger)param
                                  key:(NSString *)key;


/**
 *  获取搜索商品列表
 *
 *  @param page     页码
 *  @param key      搜索商品名称
 *
 *  @return @[WBProductInfo]
 */

+ (RACSignal *)getSearchProductListWithPage:(NSInteger)page
                                        key:(NSString *)key;

/**
 *  获取商品SKU详情
 *
 *  @param page     页码
 *  @param key      搜索商品名称
 *
 *  @return sku列表
 */

+ (RACSignal *)getProductSku:(NSString *)pid info:(NSDictionary *)info;

/**
 *  微卖客户端获取团购产品状态
 *
 *
 *  @return
 */
+ (RACSignal *)checkGroupStatus:(NSString *)pid;

/**
 *  微卖客户端获取产品进货状态
 *
 *
 *  @return
 */
+ (RACSignal *)checkStockStatus:(NSString *)pid mid:(NSString *)mid;

/**
 *  微卖客户端产品进货
 *
 *
 *  @return
 */
+ (RACSignal *)addStock:(NSString *)pid mid:(NSString *)mid;

/**
 *  检查商品SKU详情
 *
 *  @param page     页码
 *  @param key      搜索商品名称
 *
 *  @return @[WBProductInfo]
 */


+ (RACSignal *)checkProductSkuInfo:(NSString *)pid skus:(NSString *)skujson;

/**
 *  批量删除
 *
 *  @param ids     商品id，多个id逗号分隔
 */
+ (RACSignal *)deleteProductsWithIds:(NSString *)ids;

/**
 *  批量上架
 *
 *  @param ids     商品id，多个id逗号分隔
 */
+ (RACSignal *)shelfProductsWithIds:(NSString *)ids;

/**
 *  批量下架
 *
 *  @param ids     商品id，多个id逗号分隔
 */
+ (RACSignal *)unshelfProductsWithIds:(NSString *)ids;

/**
 *  获取收支明细
 *
 *  @param page     页码
 *
 *  @return @[WBIncomeDetailInfo]
 */
+ (RACSignal *)getIncomeListWithPage:(NSInteger)page;

/**
 *  获取分类列表
 *
 */
+ (RACSignal *)getCategoryList:(NSInteger)page;


/**
 * 发布自营商品
 *
 * @param desc 商品描述
 * @param imgs 图片列表
 * @param price 价格
 * @param tburl 淘宝地址
 * @param title 商品标题
 * @param label 标签
 *
 * @return 是否发布成功
 */
+ (RACSignal *)createProduct:(NSString *)desc price:(NSString *)price rprice:(NSString *)rprice stock:(NSString *)stock freight:(NSString *)freight categoryid:(NSString *)categoryid itemname:(NSString *)itemname detail:(NSString *)detail img:(NSArray *)imgs;

///**
// * 发布淘宝商品
// *
// * @param desc 商品描述
// * @param imgs 图片列表
// * @param price 价格
// * @param tburl 淘宝地址
// * @param title 商品标题
// * @param label 标签
// *
// * @return 是否发布成功
// */
//+ (RACSignal *)createProduct:(NSString *)desc imgs:(NSString *)imgsStr price:(NSString *)price tburl:(NSString *)tburl title:(NSString *)title label:(NSString *)labelStr;

/**
 * 编辑淘宝商品
 * @param pid 商品id
 * @param desc 商品描述
 * @param imgs 图片列表
 * @param price 价格
 * @param tburl 淘宝地址
 * @param title 商品标题
 * @param label 标签
 *
 * @return 是否编辑成功
 */
+ (RACSignal *)updateProduct:(NSString *)pid desc:(NSString *)desc imgs:(NSString *)imgsStr price:(NSString *)price tburl:(NSString *)tburl title:(NSString *)title label:(NSString *)labelStr;

/**
 * 发布图集
 *
 * @param desc 商品描述
 * @param imgs 图片列表
 * @param iids 关联商品ids
 * @param label 标签
 *
 * @return 是否发布成功
 */
+ (RACSignal *)createPhoto:(NSString *)desc imgs:(NSString *)imgsStr iids:(NSString *)iids label:(NSString *)labelStr;

/**
 * 编辑图集
 *
 * @param pid 商品id
 * @param desc 商品描述
 * @param imgs 图片列表
 * @param iids 关联商品ids
 * @param label 标签
 *
 * @return 是否发布成功
 */
+ (RACSignal *)updatePhoto:(NSString *)pid desc:(NSString *)desc imgs:(NSString *)imgsStr iids:(NSString *)iids label:(NSString *)labelStr;

/**
 * 分组列表
 *
 * @param 节点id
 *
 * @return 分组列表
 */
+ (RACSignal *)getGroupList;

/**
 * 商品列表
 *
 * @param groupid 节点id
 * @param page pageid
 *
 * @return 商品列表
 */

+ (RACSignal *)getProductListByType:(NSString *)groupId page:(NSUInteger )page;

/**
 * 店铺列表
 *
 * @param key 关键字
 * @param page pageid
 *
 * @return 店铺列表
 */

+ (RACSignal *)getShopList:(NSString *)key page:(NSUInteger )page;


+ (RACSignal *)getShopProducts:(NSUInteger )page;

/**
 * 搜索商品列表
 *
 * @param key 关键字
 * @param page pageid
 *
 * @return 店铺列表
 */

+ (RACSignal *)searchProduct:(NSString *)key page:(NSUInteger )page info:(NSDictionary *)info;

/**
 * 搜索分类商品列表
 *
 * @param key 关键字
 * @param page pageid
 *
 * @return 店铺列表
 */

+ (RACSignal *)searchProductByClassid:(NSString *)classid keyword:(NSString *)keyword page:(NSUInteger )page info:(NSDictionary *)info;

/**
 * 市场轮播图
 *
 *
 * @return 轮播图列表
 */
+ (RACSignal *)getMarketBanner;

/**
 * 添加收藏
 *
 *
 * @return
 */

+ (RACSignal *)addFavorite:(BOOL)isProduct dataId:(NSString *)dataId;

/**
 * 移除收藏
 *
 * @return
 */

+ (RACSignal *)cancelFavorite:(BOOL)isProduct dataId:(NSString *)dataId;

/**
 * 收藏店铺列表
 *
 * @return
 */

+ (RACSignal *)getMyFavShopList:(NSUInteger)page type:(NSUInteger )type searchKey:(NSString *)key;

/**
 * 收藏商品列表
 *
 * @return
 */

+ (RACSignal *)getMyFavProductList:(NSUInteger)page type:(NSUInteger )type searchKey:(NSString *)key;


/**
 * 商品置顶
 *
 * @return
 */

+ (RACSignal *)setTop:(NSString *)pid mode:(NSUInteger)mode;

/**
 * 商品取消置顶
 *
 * @return
 */

+ (RACSignal *)unsetTop:(NSString *)pid mode:(NSUInteger)mode;

/**
 * 商品删除
 *
 * @return
 */

+ (RACSignal *)deleteProduct:(NSString *)pid type:(NSInteger )type;

/**
 * 代理商品删除
 *
 * @return
 */
+ (RACSignal *)deletecProduct:(NSString *)pid;

/**
 * 商品详情
 *
 * @return
 */

+ (RACSignal *)getProDetail:(NSString *)pid;

/**
 * 商品详情
 *
 * @return
 */
+ (RACSignal *)getProBDetail:(NSString *)pid;

/**
 * 更新商品
 *
 * @return
 */

+ (RACSignal *)updateProduct:(WBProductInfo *)product removeImgStr:(NSString *)removeStr;

/**
 * 商品添加分类
 *
 * @return
 */

+ (RACSignal *)addCategory:(NSString *)cateId product:(NSString *)pid type:(NSInteger)type;

/**
 * 商品移除分类
 *
 * @return
 */

+ (RACSignal *)delCategory:(NSString *)cateId product:(NSString *)pid type:(NSInteger)type;

/**
 * 设置商品分类
 *
 * @return
 */

+ (RACSignal *)setCategory:(NSString *)cateIds product:(NSString *)pid type:(NSInteger)type;

/**
 * 设置是否店长推荐
 *
 * @return
 */

+ (RACSignal *)updateProductRecommend:(NSString *)pid type:(NSInteger)type isRecommend:(BOOL)isRecommend;

/**
 * 创建分类详情
 *
 * @return
 */
+ (RACSignal *)getpGroupList;

/**
 * 创建分类详情
 *
 * @return
 */
+ (RACSignal *)createpGroup:(NSString *)cateName;

/**
 * 删除分类
 *
 * @return
 */
+ (RACSignal *)delpGroup:(NSString *)groupid;

/**
 * 排序分类
 *
 * @return
 */
+ (RACSignal *)sortGroup:(NSDictionary *)sortDic;

+ (RACSignal *)productshelf:(NSString *)pid;

+ (RACSignal *)productunshelf:(NSString *)pid;

/**
 * 获取分类商品列表
 *
 * @return
 */
+ (RACSignal *)getGroupProductList:(NSString *)groupid isIn:(BOOL)isIn page:(NSUInteger)page;


/**
 * 一键代理
 *
 * @return @(YES)
 */
+ (RACSignal *)invitationAgent;


/**
 * 获取邀请列表
 *
 * @param type        0:我的邀请人；1:我的小伙伴
 *
 * @return @(YES)
 */
+ (RACSignal *)getInviteList:(NSInteger)type;

/**
 * 小铺头条
 *
 * @return @(YES)
 */
+ (RACSignal *)getShopNews;

/**
 * 市场频道商品列表
 *
 * @return @(YES)
 */
+ (RACSignal *)getProductsInChannel:(NSUInteger )channel page:(NSUInteger)page;

/**
 * 获取店铺纪录
 *
 * @return @(YES)
 */
+ (RACSignal *)getShopLog:(NSUInteger )days;

/**
 * 获取系统消息
 *
 * @return @(YES)
 */
+ (RACSignal *)getSysList:(NSUInteger )page;

/**
 * 获取首条系统订单消息
 *
 * @return @(YES)
 */
+ (RACSignal *)getFirstOrderMsg;

/**
 * 获取系统订单消息
 *
 * @return @(YES)
 */
+ (RACSignal *)getOrderMsgList:(NSUInteger )page;

/**
 * 获取我的订单个数
 *
 * @return NSDictionary
 */
+ (RACSignal *)getOrderSummary;

/**
 * 根据类型获取我的订单列表
 *
 * @param staus    订单状态，-1全部，0-交易关闭，1-未付款，2-待发货，3-已发货，4-交易成功
 *
 * @return NSAarray
 */
+ (RACSignal *)ordersWithStatus:(NSInteger )status page:(NSUInteger)page;

/**
 * 确认收货
 *
 * @return BOOL
 */
+ (RACSignal *)takeDeliveryWithOrderID:(NSString *)orderid;

/**
 * 取消订单
 *
 * @return BOOL
 */
+ (RACSignal *)cancelOrderWithOrderID:(NSString *)orderid reason:(NSString *)reasonType;


/**
 * 延长收货
 *
 * @return BOOL
 */
+ (RACSignal *)delayDeliveryWithOrderID:(NSString *)orderid orderNum:(NSString *)number;

/**
 * 删除订单
 *
 * @param orderid    订单id
 * @param type       订单类型
 *
 * @return NSAarray
 */
+ (RACSignal *)deleteOrderWithID:(NSString *)orderid type:(NSInteger)type;

/**
 * 可评价的订单
 *
 * @return NSAarray
 */
+ (RACSignal *)getRateOrders;

/**
 * 添加评论
 *
 * @param orderid               订单id
 * @param type                  订单类型
 * @param pid                   商品id
 * @param descScore             商品描述评分 1~5
 * @param deliverScore          物流评分 1~5
 * @param serviceScore          服务评分 1~5
 * @param imgs                  图片
 * @param content               评论内容
 * @param cType                 1初次评价；2追评
 *
 * @return BOOL
 */
+ (RACSignal *)addCommentWithOrderID:(NSString *)orderid
                                type:(NSInteger)type
                                 pid:(NSString *)pid
                           descScore:(NSInteger)dScore
                        deliverScore:(NSInteger)deScore
                        serviceScore:(NSInteger)sScore
                                imgs:(NSArray *)imgs
                             content:(NSString *)content
                         commentType:(NSInteger)cType;

/**
 * 评论详情
 *
 * @param orderid               订单id
 * @param type                  订单类型
 *
 * @return NSDictionary
 */
+ (RACSignal *)commentDetailWithOrderID:(NSString *)orderid type:(NSInteger)type;

/**
 * 评论列表
 *
 * @param pid                   商品id
 * @param page                  订单类型
 *
 * @return NSDictionary
 */
+ (RACSignal *)getCommentList:(NSString *)pid page:(NSUInteger)page;

/**
 * 分类列表
 *
 * @param pid                   商品id
 * @param page                  订单类型
 *
 * @return NSDictionary
 */
+ (RACSignal *)getClassifiList;

/**
 * 新品折扣列表
 *
 * @return NSDictionary
 */
+ (RACSignal *)getDiscountList;

/**
 * 新品折扣列表
 *
 * @param type                   1分类精选2新草集精选
 *
 * @return NSArray
 */
+ (RACSignal *)getChoiceListWithType:(NSInteger)type;


/**
 * 我有货源提交
 *
 * @param type                   1分类精选2新草集精选
 *
 * @return NSArray
 */
+ (RACSignal *)commitSupply:(NSDictionary *)content;

///client/supply/commit
/**
 * 获取订单详情
 *
 * @param oid                   订单id
 * @param mid                   mid
 * @param type                  订单类型
 *
 * @return NSArray
 */
+ (RACSignal *)getOrderInfoWithOid:(NSString *)oid mid:(NSString *)mid type:(NSInteger)type;

/**
 * 搜索订单
 *
 * @param page                  页码
 * @param key                   搜索关键字
 *
 * @return NSArray
 */
+ (RACSignal *)getSearchMineOrderListWithPage:(NSInteger)page
                                          key:(NSString *)key;

/**
 * 申请退款
 *
 * @param oid                  订单ID
 * @param fee                  退款金额
 * @param type                 退款类型 1 仅退款 2退货退款
 * @param remark               退款说明
 * @param reason               退款原因
 * @param apply_pics           凭证图片
 */

+ (RACSignal *)newRefund:(NSString *)oid fee:(NSString *)fee type:(NSUInteger)type remark:(NSString *)remark reason:(NSUInteger )reason pics:(NSString *)applyPics;

/**
 * 修改退款申请
 *
 * @param oid                  订单ID
 * @param fee                  退款金额
 * @param type                 退款类型 1 仅退款 2退货退款
 * @param remark               退款说明
 * @param reason               退款原因
 * @param apply_pics           凭证图片
 */

+ (RACSignal *)updateRefund:(NSString *)oid fee:(NSString *)fee type:(NSUInteger)type remark:(NSString *)remark reason:(NSUInteger )reason pics:(NSString *)applyPics;

/**
 * 取消退款申请
 *
 * @param oid                  订单id
 *
 * @return BOOL
 */
+ (RACSignal *)cancelRefundOrder:(NSString *)oid;

/**
 * 获取退款详情
 *
 * @param oid                  订单id
 * @param rid                  订单退款id
 *
 * @return BOOL
 */
+ (RACSignal *)refundOrderDetail:(NSString *)oid rid:(NSString *)rid;

/**
 * 获取快递公司列表
 *
 *
 * @return BOOL
 */
+ (RACSignal *)getExpressList;

/**
 * 填写快递单号
 *
 * @return BOOL
 *
 */
+ (RACSignal *)addExpress:(NSString *)oid company:(NSString *)company  num:(NSString *)num remark:(NSString *)remark pics:(NSString *)pics;

/**
 * 确认订单
 *
 * @return BOOL
 *
 */
+ (RACSignal *)confirmOrder:(NSDictionary *)args;

/**
 * 创建订单
 *
 * @return BOOL
 *
 */
+ (RACSignal *)createOrder:(NSDictionary *)args;

/**
 * 获取主分类
 *
 * @return @[WBCategoryInfo]
 *
 */
+ (RACSignal *)getNewCategoryList;

/**
 * 根据分类id获取分类信息和列表
 *
 * @return @[WBCategoryInfo]
 *
 */
+ (RACSignal *)getSuggestCategoryById:(NSString *)cid;

/**
 * 根据分类热销榜
 *
 * @return @[WBCategoryInfo]
 *
 */
+ (RACSignal *)getHotSuggestCategoryById:(NSString *)cid;

/**
 * 猜你喜欢
 *
 * @return @[WBCategoryInfo]
 *
 */
+ (RACSignal *)getLikeProductList;

/**
 * 淘宝商品详情
 *
 * @return @[WBCategoryInfo]
 *
 */
+ (RACSignal *)getTBProductDetail:(NSString *)pid;

/**
 * 获取首页热卖商品列表
 *
 * @return @[WBProductInfo]
 *
 */
+ (RACSignal *)getHomeProducts:(NSInteger)page;
@end
