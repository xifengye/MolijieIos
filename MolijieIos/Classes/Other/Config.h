//
//  Config.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/18.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Config : UIView
#define barHeight    49
#define mljLabelFont  [UIFont systemFontOfSize:14]

#define NOTIFYCATION_UPDATE_ADDRESS @"update_address"
#define NOTIFYCATION_SELECT_ADDRESS_PCD @"select_address_pcd"

#define article_url @"http://112.124.61.35:9999/Weekly/"

#define SUGGEST_MAX_LEN 500

+ (NSString *)getCurrentDeviceModel;
@end
