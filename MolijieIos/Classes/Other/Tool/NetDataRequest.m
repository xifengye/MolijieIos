//
//  NetDataRequest.m
//  MolijieIos
//
//  Created by yexifeng on 15/12/17.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "NetDataRequest.h"
#import "NetData.h"
#import "AppDataTool.h"
#import "AppDataMemory.h"
#import "MJExtension.h"

@implementation NetDataRequest

+(instancetype)requestWithTypes:(FinishBlock)finishBlock requestType:(NSArray *)types{
    return [[self alloc]initWithTypes:finishBlock requestType:types];
}


-(instancetype)initWithTypes:(FinishBlock)finishBlock requestType:(NSArray *)types{
    self = [super init];
    if (self) {
        _queue = [[NSQueue alloc]init];
        _finishBlock = finishBlock;
        for(int i=0;i<types.count;i++){
            [_queue enqueue:types[i]];
        }
    }
    return self;

}


-(void)start{
    [self loadNetData];
}


-(void)loadNetData{
    NetData* data = [_queue dequeue];
    if(data==nil){
        _finishBlock();
    }else{
        switch (data.type) {
            case LoadAddress:{
                [AppDataTool requestAddress:^(NSArray* address) {
                    [AppDataMemory instance].recipients = address;
                    [self loadNetData];
                } onError:^(ErrorCode errorCode) {
                    [self loadNetData];
                }];
                break;
            }
            case LoadGoods:{
                
                break;
            }
            case LoadLSPList:{
                
                break;
            }
            case ArticleBadge:{
                
                break;
            }
            case CataList:{
                [AppDataTool requestCataList:^(NSArray *childs) {
                    NSLog(@"childs:%@",childs);
                    [AppDataMemory instance].childs = childs;
                    [self loadNetData];
                } onError:^(ErrorCode errorCode) {
                    [self loadNetData];
                }];

                break;
            }
            case CheckVersion:{
                
                break;
            }
            case OrderLocal:{
                
                break;
            }
            case HomePage:{
                [AppDataTool requestHomePage:^(NSArray<RotatingAd*> *rds, NSArray<IndexBlock*> *ibs) {
                    NSLog(@"rds:%@\nibs:%@",rds,ibs);
                    [AppDataMemory instance].rotatingAds = rds;
                    [AppDataMemory instance].indexBlocks = ibs;
                    [self loadNetData];
                } onError:^(ErrorCode errorCode) {
                    [self loadNetData];
                }];
                break;
            }
        }
    }
}

@end
