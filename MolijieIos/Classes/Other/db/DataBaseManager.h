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


#define TableOrder   @"LocalOrder"

#define log false


@interface DataBaseManager : NSObject{
    NSMutableArray* orders;
}

+(instancetype)instance;

@property(nonatomic,strong)FMDatabase* dataBase;

-(NSUInteger)insertOrder:(OrderLocal*)order;
-(BOOL)updateOrderAmount:(OrderLocal *)order;

-(NSArray*)allOrder;

- (BOOL) dropTable:(NSString *)tableName;
- (BOOL) deleteTable:(NSString *)tableName;

@end
