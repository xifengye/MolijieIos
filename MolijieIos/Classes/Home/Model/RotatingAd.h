//
//  RotatingAd.h
//  MolijieIos
//
//  Created by yexifeng on 15/12/4.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RotatingAd : NSObject

@property(nonatomic,copy)NSString* ImageID;//图片ID
@property(nonatomic,copy)NSString* Created;//创建日期(客户端可不用)
@property(nonatomic,assign)int OrderNum;//排列顺序

@property(nonatomic,copy)NSString* ShardingKey;//无用
@property(nonatomic,copy)NSString* ObjectID;//无用
@property(nonatomic,copy)NSString* ImageCataID;//无用
@property(nonatomic,copy)NSString* Title;//暂时无用


/**
 * 引用类型,指向的可能是一个目录/商品/活动链接
 */
@property(nonatomic,copy)NSString* ReferenceType;

@property(nonatomic,copy)NSString* ArticleReference;//文章地址

/**
 * 指向某个商品的尖
 */
@property(nonatomic,copy)NSString* GoodReference;

//指向一个目录
@property(nonatomic,copy)NSString* CataReference;
/**
 * 营销活动链接
 */
@property(nonatomic,copy)NSString* ActReference;
@end
