//
//  AppDataMemory.h
//  MolijieIos
//
//  Created by yexifeng on 15/12/4.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"
#import "RotatingAd.h"
#import "IndexBlock.h"
#import "Childs.h"


@interface AppDataMemory : NSObject
@property(nonatomic,strong)Token* userToken;
@property(nonatomic,strong)Token* appToken;
@property(nonatomic,strong)NSArray<RotatingAd*>* rotatingAds;
@property(nonatomic,strong)NSArray<IndexBlock*>* indexBlocks;
@property(nonatomic,strong)NSArray<Childs*>* childs;

-(Childs*)getChilds:(NSString*)cataId;

+(instancetype)instance;
@end
