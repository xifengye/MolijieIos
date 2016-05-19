//
//  AddressController.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "AddressController.h"

@implementation AddressController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"我的地址";
}

-(BOOL)hiddenNavigationBar{
    return NO;
}

-(BOOL)needGoBack{
    return YES;
}

@end
