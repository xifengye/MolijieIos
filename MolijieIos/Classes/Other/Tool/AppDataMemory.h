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
#import "Recipient.h"
#import "User.h"
#import "Order.h"
#import "LPS.h"


@interface AppDataMemory : NSObject
@property(nonatomic,strong)User* user;
@property(nonatomic,strong)Token* appToken;
@property(nonatomic,strong)NSArray<RotatingAd*>* rotatingAds;
@property(nonatomic,strong)NSArray<IndexBlock*>* indexBlocks;
@property(nonatomic,strong)NSArray<Childs*>* childs;
@property(nonatomic,strong)NSMutableArray<Recipient*>* recipients;
@property(nonatomic,strong)NSMutableDictionary* orderDict;
@property(nonatomic,strong)NSMutableDictionary* lpsDict;

-(Childs*)getChilds:(NSString*)cataId;
-(Recipient*)defaultRecipient;

-(void)addOrders:(NSArray*)order;
-(void)addOrder:(Order*)order;
-(void)clearOrders;

-(void)addLpsList:(NSArray*)lpsList;
-(NSString*) getLpsCodeByLpsName:(NSString*) name;

-(NSString*)recipientJsonArray;

-(void)addRecipient:(Recipient*)r;
-(void)modifyRecipient:(Recipient*)r;

+(instancetype)instance;
@end
