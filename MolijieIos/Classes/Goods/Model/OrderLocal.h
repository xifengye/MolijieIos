//
//  Order.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/17.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "ModelBase.h"

@interface OrderLocal : ModelBase{
    BOOL checked;
}
@property(nonatomic,copy)NSString* cataId;
@property(nonatomic,copy)NSString* objectId;
@property(nonatomic,assign)NSUInteger skuIndex;
@property(nonatomic,assign)NSUInteger amount;

-(BOOL)isMe:(OrderLocal*)other;
-(BOOL)isCheck;
-(void)setCheck:(BOOL)check;
-(NSString*)toJsonString;
@end
