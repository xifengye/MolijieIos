//
//  AppDataTool.m
//  MolijieIos
//
//  Created by yexifeng on 15/12/3.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "AppDataTool.h"
#import "HttpTool.h"
#import "SandBoxTool.h"
#import "RotatingAd.h"
#import "IndexBlock.h"
#import "Childs.h"
#import "Recipient.h"
#import "AppDataMemory.h"
#import "OrderConsignments.h"

@implementation AppDataTool
+(void)requestAppToken:(TokenResultBlock)onResponse onError:(ErrorBlock)error{
    
//    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"MoLiJieClientForAndroid",@"appid",@"18259181651",@"password",@"xx-xxx-xxxx",@"device_code", nil];
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"MoLiJieClientForIOS",@"appid",@"15005919722",@"password",@"xx-xxx-xxxx-xxxx",@"device_code", nil];
    [HttpTool MLJPOST:@"AppAuthorize" params:dic hasAppToken:false hasUserToken:false hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            Token* token = [Token objectWithKeyValues:response.Data];
            [SandBoxTool saveAppToken:token];
            onResponse(token);
        }

    } failure:^(NSError *error) {
        NSLog(@"failure:%@",error);
    }];
}

+(void)login:(NSString *)username password:(NSString *)password didResponse:(TokenResultBlock)onResponse onError:(ErrorBlock)error{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:username,@"user_id",password,@"password", nil];
    [HttpTool MLJPOST:@"UserAuthorize" params:params hasAppToken:true hasUserToken:false hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"login Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            Token* token = [Token objectWithKeyValues:response.Data];
            [SandBoxTool saveUserToken:token];
            onResponse(token);
        }

    } failure:^(NSError *error) {
        NSLog(@"login failure:%@",error);
    }];
}

+(void)requestHomePage:(HomePageResultBlock)onResponse onError:(ErrorBlock)error{
    NSDictionary* params = [NSDictionary dictionary];
    [HttpTool MLJPOST:@"LoadAppHomePage" params:params hasAppToken:true hasUserToken:false hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"requestHomePage Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"requestHomePage resp:%@",response.Data);
            NSArray* ads = response.Data[@"RotatingAds"];
            NSArray* ids = response.Data[@"IndexBlocks"];
            onResponse([RotatingAd objectArrayWithKeyValuesArray:ads],[IndexBlock objectArrayWithKeyValuesArray:ids]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"requestHomePage failure:%@",error);
    }];

}

+(void)requestCataList:(CataListResultBlock)onResponse onError:(ErrorBlock)error{
    NSDictionary* params = [NSDictionary dictionary];
    [HttpTool MLJPOST:@"LoadTopCataList" params:params hasAppToken:true hasUserToken:false hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"requestCataList Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"requestCataList resp:%@",response.Data);
            onResponse([Childs objectArrayWithKeyValuesArray:response.Data]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"requestCataList failure:%@",error);
    }];

}

+(void)requestGoodsList:(NSString*)cataID pageNo:(NSUInteger)pageNo pageSize:(NSUInteger)pageSize response:(GoodsListResultBlock)onResponse onError:(ErrorBlock)error{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:cataID forKey:@"cata_id"];
    [params setObject:[NSString stringWithFormat:@"%ld",pageNo] forKey:@"page_no"];
    [params setObject:[NSString stringWithFormat:@"%ld",pageSize] forKey:@"page_size"];
    [HttpTool MLJPOST:@"LoadGoodList" params:params hasAppToken:true hasUserToken:false hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"requestGoodsList Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"requestGoodsList resp:%@",response.Data);
            NSDictionary* dic = response.Data;
            onResponse([Goods objectArrayWithKeyValuesArray:dic[@"List"]]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"requestGoodsList failure:%@",error);
    }];
    
}

+(void)requestGoodsDetail:(NSString *)cataID objectID:(NSString *)oId response:(GoodsDetailResultBlock)onResponse onError:(ErrorBlock)error{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:cataID forKey:@"cata_id"];
    [params setObject:oId forKey:@"good_id"];
    [HttpTool MLJPOST:@"LoadGoodDetail" params:params hasAppToken:true hasUserToken:false hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"requestGoodsDetail Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"requestGoodsDetail resp:%@",response.Data);
            onResponse([Goods objectWithKeyValues:response.Data]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"requestGoodsDetail failure:%@",error);
    }];

}

+(void)requestAddress:(AddressesResultBlock)onResponse onError:(ErrorBlock)error{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [HttpTool MLJPOST:@"LoadUserAddressBook" params:params hasAppToken:true hasUserToken:true hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"requestAddress Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"requestAddress resp:%@",response.Data);
            onResponse([Recipient objectArrayWithKeyValuesArray:response.Data]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"requestAddress failure:%@",error);
    }];

}

+(void)calculateFreight:(NSString *)cartItemJson recipient:(NSString *)recipient response:(FreightResultBlock)onResponse onError:(ErrorBlock)error{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:cartItemJson forKey:@"car_items_json"];
    [params setObject:recipient forKey:@"recipient_json"];
    [HttpTool MLJPOST:@"CalculateFreight" params:params hasAppToken:true hasUserToken:true hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"calculateFreight Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"calculateFreight resp:%@",response.Data);
            NSNumber* number =  response.Data;
            onResponse(number.floatValue);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"calculateFreight failure:%@",error);
    }];

}

+(void)createOrder:(NSString *)cartItemJson recipient:(NSString *)recipient paymentType:(NSString *)payment response:(CreateOrderResultBlock)onResponse onError:(ErrorBlock)error{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:[AppDataMemory instance].user.UserName forKey:@"customer_id"];
    [params setObject:cartItemJson forKey:@"car_items_json"];
    [params setObject:recipient forKey:@"recipient_json"];
    [params setObject:payment forKey:@"payment"];
    [HttpTool MLJPOST:@"NewOrder" params:params hasAppToken:true hasUserToken:true hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"createOrder Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"createOrder resp:%@",response.Data);
            onResponse([Order objectWithKeyValues:response.Data]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"createOrder failure:%@",error);
    }];

}

+(void)loadRecentOrders:(LoadOrderResultBlock)onResponse onError:(ErrorBlock)error{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:[AppDataMemory instance].user.UserName forKey:@"customer_id"];
    [HttpTool MLJPOST:@"LoadRecentOrders" params:params hasAppToken:true hasUserToken:true hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"loadRecentOrders Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"loadRecentOrders resp:%@",response.Data);
            onResponse([Order objectArrayWithKeyValuesArray:response.Data]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"loadRecentOrders failure:%@",error);
    }];

}

+(NSString *)imageUrlFor:(NSString*)imgType withImgid:(NSString *)img_id{
    return [NSString stringWithFormat:@"http://112.124.61.35:9999/int/android_api/LoadImage?img_id=%@&img_type=%@&size=%@",img_id,imgType,@"Original"];
}

+(void)confirmReceipt:(NSString *)sn response:(ResponseResultBlock)onResponse onError:(ErrorBlock)error{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:[AppDataMemory instance].user.UserName forKey:@"customer_id"];
    [params setObject:sn forKey:@"order_sn"];
    [HttpTool MLJPOST:@"ConfirmReceipt" params:params hasAppToken:true hasUserToken:true hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"confirmReceipt Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"confirmReceipt resp:%@",response.Data);
            onResponse();
        }
        
    } failure:^(NSError *error) {
        NSLog(@"confirmReceipt failure:%@",error);
    }];
}

+(void)cancelOrder:(NSString *)sn response:(ResponseResultBlock)onResponse onError:(ErrorBlock)error{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:[AppDataMemory instance].user.UserName forKey:@"customer_id"];
    [params setObject:sn forKey:@"order_sn"];
    [HttpTool MLJPOST:@"CancelOrder" params:params hasAppToken:true hasUserToken:true hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"cancelOrder Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"cancelOrder resp:%@",response.Data);
            onResponse();
        }
        
    } failure:^(NSError *error) {
        NSLog(@"cancelOrder failure:%@",error);
    }];

}

+(void)confirmOrder:(NSString *)sn response:(ResponseResultBlock)onResponse onError:(ErrorBlock)error{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:[AppDataMemory instance].user.UserName forKey:@"customer_id"];
    [params setObject:sn forKey:@"order_sn"];
    [HttpTool MLJPOST:@"ConfirmOrder" params:params hasAppToken:true hasUserToken:true hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"confirmOrder Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"confirmOrder resp:%@",response.Data);
            onResponse();
        }
        
    } failure:^(NSError *error) {
        NSLog(@"confirmOrder failure:%@",error);
    }];

}


+(void)deliverBack:(NSString *)sn lspCode:(NSString *)lspCode postReceptCode:(NSString *)postReceptCode postFrom:(NSString *)postFrom response:(ResponseResultBlock)onResponse onError:(ErrorBlock)error{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:[AppDataMemory instance].user.UserName forKey:@"customer_id"];
    [params setObject:sn forKey:@"order_sn"];
    [params setObject:lspCode forKey:@"lsp_code"];
    [params setObject:postReceptCode forKey:@"post_recept_code"];
    [params setObject:postFrom forKey:@"post_from"];
    [HttpTool MLJPOST:@"DeliverBack" params:params hasAppToken:true hasUserToken:true hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"deliverBack Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"deliverBack resp:%@",response.Data);
            onResponse();
        }
        
    } failure:^(NSError *error) {
        NSLog(@"deliverBack failure:%@",error);
    }];

}

+(void)loadOrderConsignments:(NSString *)sn response:(OrderConsignmentsResultBlock)onResponse onError:(ErrorBlock)error{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:[AppDataMemory instance].user.UserName forKey:@"customer_id"];
    [params setObject:sn forKey:@"order_sn"];
    [HttpTool MLJPOST:@"LoadOrderConsignments" params:params hasAppToken:true hasUserToken:true hasAES:true success:^(MLJResponse *response) {
        if(response.HasError){
            NSLog(@"loadOrderConsignments Error:%lld",response.ErrorCode);
            error(response.ErrorCode);
        }else{
            NSLog(@"loadOrderConsignments resp:%@",response.Data);
            onResponse([OrderConsignments objectArrayWithKeyValuesArray:response.Data]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"loadOrderConsignments failure:%@",error);
    }];

}

@end
