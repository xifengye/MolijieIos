//
//  GoodsListCell.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/15.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "GoodsListCell.h"
#import "UIImageView+WebCache.h"
#import "AppDataTool.h"

@implementation GoodsListCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        UIImageView* imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-labelHeight*2);
        self.imageView = imageView;
        [self addSubview:imageView];
        
        UILabel* nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(10, frame.size.height -labelHeight*2 , frame.size.width, labelHeight);
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont systemFontOfSize:12];
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        UILabel* priceLabel = [[UILabel alloc]init];
        priceLabel.frame = CGRectMake(10, frame.size.height - labelHeight, frame.size.width, labelHeight);
        priceLabel.textColor = [UIColor orangeColor];
        priceLabel.font = [UIFont systemFontOfSize:12];
        self.priceLabel = priceLabel;
        [self addSubview:priceLabel];
    }
    return self;
}

-(void)setGoods:(Goods *)goods{
     NSString* url = [AppDataTool imageUrlFor:UseForGoodSource withImgid:goods.MainResources[0]];
    [self.imageView setImageWithURL:url];
    self.nameLabel.text = goods.Title;
    self.priceLabel.text = @"XXXXX";
}

@end
