//
//  NewFeatureController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/12.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "NewFeatureController.h"
#import "MainController.h"

@implementation NewFeatureController

- (void)viewDidLoad{
    [super viewDidLoad];
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = true;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    CGSize scrollViewSize = scrollView.frame.size;
    scrollView.contentSize = CGSizeMake(scrollViewSize.width*3, scrollViewSize.height);
    for(int i=0;i<3;i++){
        UIImageView* imageView = [[UIImageView alloc] init];
        NSString* imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        UIImage* image = [UIImage imageNamed:imageName];
        imageView.image = image;
        imageView.frame = CGRectMake(scrollViewSize.width*i, 0, scrollViewSize.width, scrollViewSize.height);
        [scrollView addSubview:imageView];
        
        if(i==2){
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateSelected];
            [btn setTitle:@"立即体验" forState:UIControlStateNormal];
            btn.frame = CGRectMake(0, 0, btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.height);
            btn.center = CGPointMake(scrollViewSize.width/2, scrollViewSize.height*0.6);
            [imageView addSubview:btn];
            imageView.userInteractionEnabled = YES;
            [btn addTarget:self action:@selector(goMain:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    UIPageControl* pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, scrollViewSize.height-20,scrollViewSize.width, 20);
    
    pageControl.numberOfPages = 3;
    pageControl.backgroundColor = [UIColor grayColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    }

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;

}

-(void)goMain:(UIButton*)button{
    NSLog(@"goMain");
    MainController* mainController = [[MainController alloc]init];
    self.view.window.rootViewController = mainController;
}

- (void)dealloc{
    NSLog(@"dealloc");
}

//是否是第一次打开新版本
+(BOOL)isFirstOpenNewVersion{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSString* lastVersionCode = [userDefault stringForKey:@"versionCode"];
    NSString* currentVersionCode = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    if([currentVersionCode isEqualToString:lastVersionCode]){
        return NO;
    }else{
        [userDefault setObject:currentVersionCode forKey:@"versionCode"];
        [userDefault synchronize];
        return YES;
    }
}


@end
