//
//  MGDiscoverViewController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "ArticleController.h"
#import "MGSearchBar.h"
#import "Config.h"
#import "MBProgressHUD+MJ.h"

@interface ArticleController ()<UIWebViewDelegate>

@end

@implementation ArticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.badgeValue = @"disc";
    UIWebView* webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:webView];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:article_url]]];

}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"加载中..."];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}



@end
