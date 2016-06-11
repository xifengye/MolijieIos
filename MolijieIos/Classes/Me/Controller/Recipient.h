//
//  Recipient.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipient : NSObject{
    NSString* province ;
    NSString* city ;
    NSString* district;
    NSString* detail;
}


@property(nonatomic,copy)NSString* Address;//this is use net Recipient info
@property(nonatomic,assign)BOOL AsDefault;
@property(nonatomic,copy)NSString* Mobile;
@property(nonatomic,copy)NSString* PostCode;
@property(nonatomic,copy)NSString* RealName;
@property(nonatomic,copy)NSString* Tel;
@property(nonatomic,assign)NSUInteger Number;

-(NSString*)getJsonString;
+(NSString*)getLocate:(NSString*)pro city:(NSString*)cit district:(NSString*)dis;
-(NSString*)getSimpleAddress;
-(NSString*)getPCD;
-(NSString*)getDetail;
-(void)setPCD:(NSString*) pro city:(NSString*)cit district:(NSString*)dis detail:(NSString*)det;
-(BOOL)checkSelf;
-(NSString*)getProvince;
-(NSString*)getCity;

-(NSString*)getDistrict;
@end
