//
//  BinaryData.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/26.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinaryData : NSObject
@property(nonatomic,strong)NSData* data;
@property(nonatomic,copy)NSString* paramName;
@property(nonatomic,copy)NSString* serverFileName;
@property(nonatomic,copy)NSString* mimeType;
@end
