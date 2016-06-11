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
    [self setupNavBar];
}

-(void)setupNavBar{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.title = self.title;
    
}

-(BOOL)hiddenNavigationBar{
    return NO;
}

-(UIScrollView *)adjustContentInsetView{
    return nil;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    UIScrollView* view = [self adjustContentInsetView];
    if(view){
        CGRect rect = self.navigationController.navigationBar.frame;
        float y = rect.size.height + rect.origin.y;
        view.contentInset = UIEdgeInsetsMake(y, 0, 0, 0);
    }
}

@end
