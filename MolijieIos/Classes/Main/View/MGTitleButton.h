//
//  MGTitleButton.h
//  SinaWeibo
//
//  Created by yexifeng on 15/11/12.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DicrectChangeDelegate <NSObject>

-(void)didDicrectChange:(BOOL)isUp;

@end

@interface MGTitleButton : UIButton{
    bool isUpArrow;
}

@property(assign,nonatomic)id<DicrectChangeDelegate> delegate;
-(void)turnArrow:(UIButton*)button;

@end
