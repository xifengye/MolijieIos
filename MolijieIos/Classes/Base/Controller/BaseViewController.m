//
//  BaseViewController.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/13.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewDidLoad{
    [self.navigationController setNavigationBarHidden:self.hiddenNavigationBar];
}

-(BOOL)hiddenNavigationBar{
    return true;
}


@end
