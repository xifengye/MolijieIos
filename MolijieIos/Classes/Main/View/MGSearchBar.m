//
//  MGSearchBar.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/10.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MGSearchBar.h"
#import "UIImage+MG.h"

@implementation MGSearchBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clearButtonMode = UITextFieldViewModeAlways;
        NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
        dictionary[NSForegroundColorAttributeName] = [UIColor redColor];
        dictionary[NSFontAttributeName] = [UIFont systemFontOfSize:16];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:dictionary];
        self.background = [UIImage imageWithStretchable:@"searchbar_textfield_background"];
        self.contentMode = UIViewContentModeCenter;
        UIImageView* searchBarLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        searchBarLeftView.contentMode = UIViewContentModeCenter;
        searchBarLeftView.frame = CGRectMake(0, 0, searchBarLeftView.image.size.width+15,searchBarLeftView.image.size.height);
        self.leftView = searchBarLeftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = true;
    }
    return self;
}

@end
