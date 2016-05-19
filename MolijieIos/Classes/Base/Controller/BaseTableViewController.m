//
//  BaseTableViewController.m
//  MolijieIos
//
//  Created by yexifeng on 15/12/4.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController
-(void)viewDidLoad{
    [self.navigationController setNavigationBarHidden:self.hiddenNavigationBar];
    if([self needGoBack]){
        [self setupNavBar];
    }
}

-(BOOL)hiddenNavigationBar{
    return true;
}

-(void)setupNavBar{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.title = self.title;
    
}

-(void)goBack{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(BOOL)needGoBack{
    return [self hiddenNavigationBar] && YES;
}

@end
