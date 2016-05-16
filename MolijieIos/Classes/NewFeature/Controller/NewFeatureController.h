//
//  NewFeatureController.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/12.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureController : UIViewController<UIScrollViewDelegate>
@property(nonatomic,retain) UIPageControl* pageControl;

+(BOOL)isFirstOpenNewVersion;
@end
