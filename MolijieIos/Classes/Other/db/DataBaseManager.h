//
//  DataBaseTool.h
//  Lottey
//
//  Created by yexifeng on 15/12/30.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "OrderLocal.h"
#import "Favourite.h"


#define TableOrder   @"LocalOrder"
#define TableFavourite @"favourite"

#define log false


@interface DataBaseManager : NSObject{
    NSMutableArray* orders;
    NSMutableArray* favourites;
}

+(instancetype)instance;

@property(nonatomic,strong)FMDatabase* dataBase;

-(NSUInteger)insertOrder:(OrderLocal*)order;
-(BOOL)updateOrderAmount:(OrderLocal *)order;
-(OrderLocal*)orderByID:(NSUInteger)ID;
-(BOOL)deleteOrder:(OrderLocal*)order;

-(BOOL)insertFavourite:(Favourite*)favourite;
-(BOOL)deleteFavourite:(Favourite*)favourite;
-(NSArray*)favouriteList;
-(BOOL)isFavourite:(Favourite*)favourite;


-(NSArray*)allOrder;

//- (BOOL) dropTable:(NSString *)tableName;
//- (BOOL) deleteTable:(NSString *)tableName;

@end
