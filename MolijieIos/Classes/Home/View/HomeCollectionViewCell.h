//
//  HomeCollectionViewCell.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/13.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGImageTitleView.h"

@interface HomeCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)MGImageTitleView* imageView;

-(void)setData:(NSString*)title imgId:(NSString*)imgId imageType:(NSString*)imageType;
-(void)setData:(NSString*)title imgId:(NSString*)imgId;

@end
