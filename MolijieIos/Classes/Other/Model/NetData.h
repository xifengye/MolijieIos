//
//  NetData.h
//  MolijieIos
//
//  Created by yexifeng on 15/12/17.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetDataRequest.h"

@interface NetData : NSObject
+(instancetype)dataWithType:(NetDataType)type param:(id)param;
-(instancetype)initWithType:(NetDataType)type param:(id)param;
@property(nonatomic,assign)NetDataType type;
@property(nonatomic,strong)id param;
@end
