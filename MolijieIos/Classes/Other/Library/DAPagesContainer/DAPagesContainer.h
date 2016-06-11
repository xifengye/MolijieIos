//
//  DAPageContainerScrollView.h
//  DAPagesContainerScrollView
//
//  Created by Daria Kopaliani on 5/29/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DAPagesContainer;
@protocol DAPageContainerDelegate <NSObject>

@optional
-(void)didDAPageContainerSelectedIndex:(DAPagesContainer*)container selectedIndex:(NSUInteger)index;

@end


@interface DAPagesContainer : UIViewController


@property (strong, nonatomic) NSArray *viewControllers;
@property (assign, nonatomic) NSUInteger selectedIndex;

@property (assign, nonatomic) NSUInteger topBarHeight;
@property (assign, nonatomic) CGSize pageIndicatorViewSize;
@property (strong, nonatomic) UIColor *topBarBackgroundColor;
@property (strong, nonatomic) UIFont *topBarItemLabelsFont;
@property (strong, nonatomic) UIColor *pageItemsTitleColor;
@property (strong, nonatomic) UIColor *selectedPageItemColor;

@property(weak,nonatomic) id<DAPageContainerDelegate> delegate;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;
- (void)updateLayoutForNewOrientation:(UIInterfaceOrientation)orientation;

@end