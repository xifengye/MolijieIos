//
//  NetDataRequest.h
//  MolijieIos
//
//  Created by yexifeng on 15/12/17.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSQueue.h"

typedef NS_OPTIONS(int, NetDataType){
    LoadAddress = 1,//用户地址
    CheckVersion = 2,
    CataList = 3,//加载目录
    HomePage = 4,//主页数据(滚动广告+IndexBlock)
    LoadOrder = 5,//用户订单数据
    ArticleBadge = 6,//文章数量
    LoadLSPList = 7,//物流列表
    LoadGoods = 8,//加载商品详情
    LoadConsignments = 9
};

typedef void (^FinishBlock)();

@interface NetDataRequest : NSObject
@property(nonatomic,strong) NSQueue* queue;
@property(nonatomic,strong) FinishBlock finishBlock;

+(instancetype) requestWithTypes:(FinishBlock) finishBlock requestType:(NSArray*) types;
- (instancetype)initWithTypes:(FinishBlock) finishBlock requestType:(NSArray*) types;

-(void)start;
@end
