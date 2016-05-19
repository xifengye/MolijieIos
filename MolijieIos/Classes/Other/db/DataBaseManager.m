//
//  DataBaseTool.m
//  Lottey
//
//  Created by yexifeng on 15/12/30.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "DataBaseManager.h"
#import "ModelBase.h"


#define dataBaseName @"molijie.sqlite"

#define dataBasePath [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) lastObject]stringByAppendingPathComponent:dataBaseName]


@implementation DataBaseManager

#pragma mark DataBaseManager

-(id)init {
    if (self = [super init]) {
        _dataBase = [FMDatabase databaseWithPath:dataBasePath];
    }
    return self;
}



+(id)instance {
    
    static DataBaseManager*sharedMyManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedMyManager = [[self alloc] init];
        [sharedMyManager createTables];
        [sharedMyManager initData];
        
    });
    
    return sharedMyManager;
}

#pragma mark 初始化创建表



//创建表
-(BOOL)createTable:(NSString*)sqlCreateTable{
    BOOL result = false;
    if ([self.dataBase open]) {
        
        BOOL res = [self.dataBase executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"error when creating db table");
            result = false;
        } else {
            NSLog(@"success to creating db table");
            result = true;
        }
        [self.dataBase close];
    }
    return result;
}


//创建所有用到的表
-(void)createTables{
//    [self dropTable:TableOrder];
    NSString *orderSqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' TEXT, '%@' INTEGER, '%@' INTEGER)",TableOrder,@"ID",@"cataId",@"objectId",@"skuIndex",@"amount"];
       [self createTable:orderSqlCreateTable];//中奖人员
}


#pragma mark 初始化数据
-(void)initData{
    orders = [self queryOrders];
}



#pragma mark - order

//插入一个员工
-(NSUInteger)insertOrder:(OrderLocal*)order{
    NSUInteger checkId = [self orderIsExist:order];
    if(checkId>0){
        return checkId;
    }
    NSUInteger ID = [self insert:TableOrder value:order];
    if(ID>0){
        order.ID = ID;
        [orders addObject:order];
        
    }
    return ID;
}

-(NSUInteger)orderIsExist:(OrderLocal*)order{
    for(OrderLocal* o in orders){
        if([o isMe:order]){
            o.amount++;
            [self updateOrderAmount:o];
            return o.ID;
        }
    }
    return 0;
}

-(BOOL)updateOrderAmount:(OrderLocal *)order{
    if([self.dataBase open]){
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE '%@' SET amount='%lu' WHERE ID='%lu'", TableOrder,order.amount,order.ID];
        BOOL res = [self.dataBase executeUpdate:updateSql];
        if (!res) {
            NSLog(@"更新order Amount失败");
        } else {
            NSLog(@"success to update Order amount");
        }
        [self.dataBase close];
        return res;
    }
    
    return false;

}


-(OrderLocal *)orderByID:(NSUInteger)ID{
    for(OrderLocal* o in orders){
        if(o.ID==ID){
            return o;
        }
    }
    return nil;
}


-(NSMutableArray*) queryOrders{
    NSMutableArray* os = [NSMutableArray array];
    if ([self.dataBase open]) {
        FMResultSet *rs = [self.dataBase executeQuery:[NSString stringWithFormat:@"SELECT ID,cataId,objectId,skuIndex,amount FROM %@",TableOrder]];
        while ([rs next]) {
            int ID = [rs intForColumn:@"ID"];
            NSString *cataId = [rs stringForColumn:@"cataId"];
            NSString *ojbectId = [rs stringForColumn:@"objectId"];
            NSUInteger skuIndex = [rs intForColumn:@"skuIndex"];
            NSUInteger amount = [rs intForColumn:@"amount"];
            OrderLocal* order = [[OrderLocal alloc]init];
            order.ID = ID;
            order.cataId = cataId;
            order.amount = amount;
            order.objectId = ojbectId;
            order.skuIndex = skuIndex;
            [os addObject:order];
        }
    [rs close];
    }
    return os;
}


//从内存中删除员工
-(void)removeOrder:(OrderLocal*)order{
    for(OrderLocal* o in orders){
        if(o.ID == order.ID){
            [orders removeObject:o];
            break;
        }
    }

}

-(BOOL)deleteOrder:(OrderLocal *)order{
    BOOL reslut = [self deleteByID:TableOrder ID:order.ID];
    if(reslut){
        [self removeOrder:order];
    }
    return reslut;
}

-(NSArray *)allOrder{
    return orders;
}




#pragma mark 生成插入语句

//根据模式创建插入数据,key-value
-(NSString*)createInsertSqlWithObj:(NSString*)tableName value:(ModelBase*)value{
    NSArray* propertys = [value filterPropertys];
    NSMutableString* insertSql = [NSMutableString stringWithString:[NSString stringWithFormat:@"INSERT INTO %@ (",tableName]];
    for(int i=0;i<propertys.count;i++){
        NSString* property = propertys[i];
        if(![property isEqualToString:@"ID"]){
            [insertSql appendString:[NSString stringWithFormat:@"%@,",property]];
        }
        if(i==propertys.count-1){
            [insertSql deleteCharactersInRange:NSMakeRange(insertSql.length-1, 1)];
            [insertSql appendString:@") VALUES ("];
        }
    }
    NSDictionary* kv = [value toDictionary];
    for(int i=0;i<propertys.count;i++){
        NSString* property = propertys[i];
        if(![property isEqualToString:@"ID"]){
            
            [insertSql appendString:[NSString stringWithFormat:@"'%@',",kv[[NSString stringWithFormat:@"_%@",property]]]];
        }
        if(i==propertys.count-1){
            [insertSql deleteCharactersInRange:NSMakeRange(insertSql.length-1, 1)];
            [insertSql appendString:@")"];
        }
    }
    return insertSql;
}

#pragma mark 插入

//插入一个模型对象到数据库
-(NSUInteger)insert:(NSString*)tableName value:(ModelBase*)value{
    NSUInteger ID = 0;
    if ([self.dataBase open]) {
        NSString* insertSql = [self createInsertSqlWithObj:tableName value:value];
//        NSLog(@"插入语句:%@",insertSql);
        BOOL res = [self.dataBase executeUpdate:insertSql];
        if (!res) {
            NSLog(@"error when insert db table");
        } else {
            ID = self.dataBase.lastInsertRowId;
            value.ID = ID;
            NSLog(@"success to insert db table");
        }
        [self.dataBase close];
    }
    
    return ID;
}

//批量插入模型数据
-(void)inserts:(NSString*)tableName value:(NSArray<ModelBase*>*)values{
    if ([self.dataBase open]) {
        for(int i=0;i<values.count;i++){
            NSUInteger ID = 0;
            ModelBase* value = values[i];
            NSString* insertSql = [self createInsertSqlWithObj:tableName value:value];
//            NSLog(@"插入语句:%@",insertSql);
            BOOL res = [self.dataBase executeUpdate:insertSql];
            
            if (!res) {
                NSLog(@"error when insert db table");
            } else {
                ID = self.dataBase.lastInsertRowId;
                value.ID = ID;
//                NSLog(@"success to insert db table");
            }
        }
        [self.dataBase close];
    }
}

#pragma mark 移除表

// 删除表
- (BOOL) dropTable:(NSString *)tableName
{
    if([self.dataBase open]){
        NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
        if (![self.dataBase executeUpdate:sqlstr])
        {
            NSLog(@"Delete table error!");
            return NO;
        }
        return YES;
    }
    return NO;
}

#pragma mark 清除表数据

//删除某表数据根据ID
-(BOOL)deleteByID:(NSString *)tableName ID:(NSUInteger)ID{
    if([self.dataBase open]){
        NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@ WHERE ID=%lu", tableName,ID];
        if (![self.dataBase executeUpdate:sqlstr])
        {
            NSLog(@"Erase table error!");
            return NO;
        }
        return YES;
    }
    return NO;
    
    return false;
}


// 清除表
- (BOOL) deleteTable:(NSString *)tableName
{
    if([self.dataBase open]){
        NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
        if (![self.dataBase executeUpdate:sqlstr])
        {
            NSLog(@"Erase table error!");
            return NO;
        }
        return YES;
    }
    return NO;
}






-(void)resetAppDataBase{
    [self dropTable:TableOrder];
    [self createTables];
    [orders removeAllObjects];
}




@end
