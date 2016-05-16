//
//  HomeCollectionViewCell.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/13.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "IndexBlock.h"
#import "UIImageView+WebCache.h"
#import "AppDataTool.h"

@implementation HomeCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        MGPhotoView* pView = [[MGPhotoView alloc]init];
//        pView.contentMode = UIViewContentModeScaleAspectFill;
//        pView.clipsToBounds = YES;
//        pView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        self.imageView = pView;
//        [self addSubview:pView];
        MGImageTitleView* imageView = [[MGImageTitleView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.imageView = imageView;
        [self addSubview:imageView];
    }
    return self;
}

-(void)setData:(NSString *)title imgId:(NSString *)imgId imageType:(NSString*)imageType{
    [self.imageView setTitle :title];
    NSString* url = [AppDataTool imageUrlFor:imageType withImgid:imgId];
    [self.imageView setImageWithURL:url];
}

-(void)setData:(NSString *)title imgId:(NSString *)imgId{
    [self setData:title imgId:imgId imageType:UseForAppSource];
}
@end
