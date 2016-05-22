//
//  Recipient.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "Recipient.h"

@implementation Recipient

-(NSString*)getProvince {
    return province;
}

-(NSString*)getCity {
    return city;
}

-(NSString*)getDistrict {
    return district;
}

-(NSString *)Address{
    [self parse];
    return [NSString stringWithFormat:@"%@@%@/%@/%@",detail,province,city,district];

}

-(NSString*)getSimpleAddress{
    [self parse];
    return [NSString stringWithFormat:@"%@%@%@%@",province,city,district,detail];
}

-(void)setPCD:(NSString*) pro city:(NSString*)cit district:(NSString*)dis detail:(NSString*)det {
    province = pro;
    city = cit;
    district = dis;
    detail = det;
}

-(NSString*)getDetail{
    [self parse];
    return detail;
}

-(void)parse{
    if(detail==nil || province==nil){
        NSUInteger index = [_Address rangeOfString:@"@"].location;
        detail = [_Address substringToIndex:index];
        NSArray* pcd =  [[_Address substringFromIndex:(index+1)] componentsSeparatedByString:@"/"];
        province = pcd[0];
        city = pcd[1];
        district = pcd[2];
    }
}

+(NSString*)getLocate:(NSString*)pro city:(NSString*)cit district:(NSString*)dis{
    return [NSString stringWithFormat:@"%@%@%@",pro,cit,dis];
}

-(NSString*)getPCD{
    [self parse];
    return [Recipient getLocate:province city:city district:district];
}



-(NSString *)getJsonString{
    return [NSString stringWithFormat:@"{\"Address\":\"%@\",\"AsDefault\":%@,\"Mobile\":\"%@\",\"Number\":%ld,\"PostCode\":\"%@\",\"RealName\":\"%@\",\"Tel\":\"%@\"}",self.Address,_AsDefault?@"true":@"false",_Mobile,_Number,_PostCode,_RealName,_Tel];
}
@end
