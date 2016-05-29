//
//  AppDataTool.h
//  MolijieIos
//
//  Created by yexifeng on 15/12/3.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"
#import "MLJResponse.h"
#import "Goods.h"
#import "Order.h"

#define UseForAppSource     @"UseForAppSource"
#define  UseForGoodSource   @"UseForGoodSource"
#define  UseForUserAvatar   @"UseForUserAvatar"

#define Cata  @"Cata"
// 指向一则营销活动
#define Act  @"Act"
// 指向一条商品
#define GoodItem    @"GoodItem"
// 指向一篇文章
#define Article @"Article"


#define local_order_change  @"localOrder_change"



typedef void(^HomePageResultBlock)(NSArray*,NSArray*);
typedef void(^CataListResultBlock)(NSArray*);
typedef void(^ErrorBlock)(ErrorCode);
typedef void(^TokenResultBlock)(Token*);
typedef void(^GoodsListResultBlock)(NSArray<Goods*>*);
typedef void(^GoodsDetailResultBlock)(Goods*);
typedef void(^AddressesResultBlock)(NSArray*);
typedef void(^FreightResultBlock)(CGFloat);
typedef void(^CreateOrderResultBlock)(Order*);
typedef void(^LoadOrderResultBlock)(NSArray*);
typedef void(^ResponseResultBlock)();
typedef void(^OrderConsignmentsResultBlock)(NSArray*);




@interface AppDataTool : NSObject
+(void)requestAppToken:(TokenResultBlock) onResponse onError:(ErrorBlock)error;
+(void)login:(NSString *)username password:(NSString *)password didResponse:(TokenResultBlock)onResponse onError:(ErrorBlock)error;

+(void)requestHomePage:(HomePageResultBlock)onResponse onError:(ErrorBlock)error;

+(void)requestCataList:(CataListResultBlock)onResponse onError:(ErrorBlock)error;
+(void)requestGoodsList:(NSString*)cataID pageNo:(NSUInteger)pageNo pageSize:(NSUInteger)pageSize response:(GoodsListResultBlock)onResponse onError:(ErrorBlock)error;

+(void)requestGoodsDetail:(NSString*)cataID objectID:(NSString*)oId response:(GoodsDetailResultBlock)onResponse onError:(ErrorBlock)error;

+(void)requestAddress:(AddressesResultBlock)onResponse onError:(ErrorBlock)error;

//计算运费
+(void)calculateFreight:(NSString*)cartItemJson recipient:(NSString*)recipient response:(FreightResultBlock)onResponse onError:(ErrorBlock)error;

//创建订单
+(void)createOrder:(NSString*)cartItemJson recipient:(NSString*)recipient paymentType:(NSString*)payment response:(CreateOrderResultBlock)onResponse onError:(ErrorBlock)error;

+(void)loadRecentOrders:(LoadOrderResultBlock)response onError:(ErrorBlock)error;

+(void)confirmReceipt:(NSString*)sn response:(ResponseResultBlock)onResponse onError:(ErrorBlock)error;

+(void)loadOrderConsignments:(NSString*)sn response:(OrderConsignmentsResultBlock)onResponse onError:(ErrorBlock)error;


+(void)confirmOrder:(NSString*)sn response:(ResponseResultBlock)onResponse onError:(ErrorBlock)error;

+(void)cancelOrder:(NSString*)sn response:(ResponseResultBlock)onResponse onError:(ErrorBlock)error;

+(void)deliverBack:(NSString*)sn lspCode:(NSString*)lspCode postReceptCode:(NSString*)postReceptCode postFrom:(NSString*)postFrom response:(ResponseResultBlock)onResponse onError:(ErrorBlock)error;

+(void)pay:(NSString*)sn price:(CGFloat)price payment:(NSString*)payment response:(ResponseResultBlock)onResponse onError:(ErrorBlock)error;

+(NSString*)imageUrlFor:(NSString*)imgType withImgid:(NSString*)img_id;

@end
