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
    if([self needGoBack]){
        [self setupNavBar];
    }
}

-(void)setupNavBar{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.title = self.title;
    
}

-(void)goBack{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(BOOL)hiddenNavigationBar{
    return true;
}

-(BOOL)needGoBack{
    return [self hiddenNavigationBar] && YES;
}


@end
