//
//  MGMeCellView.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/30.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "MGMeCellView.h"

@implementation MGMeCellView


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"MeCell";
    MGMeCellView *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell = [[MGMeCellView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor = [UIColor orangeColor];
        CGFloat imageX = 10;
        CGFloat imageY = 10;
        CGFloat imageWidth = CELL_HEIGHT-20;
        CGFloat imageHeight = imageWidth;
        UIImageView* imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
        imageView.image = [UIImage imageNamed:@"avatar_default"];
        [self addSubview:imageView];
        
        UILabel* nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"疯子小助手";
        [self addSubview:nameLabel];
        
        UIFont* nameFont = [UIFont fontWithName:@"Helvetica-Bold"  size:(18.0)];
        nameLabel.font = nameFont;
        CGSize nameSize = [nameLabel.text sizeWithFont:nameFont];
        CGFloat nameX = CGRectGetMaxX(imageView.frame)+10;
        CGFloat nameY = imageY+(imageHeight/2-nameSize.height)/2;
        nameLabel.frame = CGRectMake(nameX,nameY,nameSize.width,nameSize.height);
        
        UIButton* vipBtn = [[UIButton alloc]init];
        [vipBtn setImage:[UIImage imageNamed:@"common_icon_membership_expired"] forState:UIControlStateNormal];
        vipBtn.frame = CGRectMake(0, 0, vipBtn.currentImage.size.width, vipBtn.currentImage.size.height);
        vipBtn.layer.position = CGPointMake(CGRectGetMaxX(nameLabel.frame)+10, nameLabel.layer.position.y);
        [self addSubview:vipBtn];
        
        UIFont* descFont = [UIFont systemFontOfSize:15];
        UILabel* descLabel = [[UILabel alloc]init];
        descLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+10,CGRectGetMaxY(nameLabel.frame)+10, 80, 30);
        descLabel.text = @"简介:暂无介绍";
        descLabel.font = descFont;
        descLabel.textColor = [UIColor grayColor];
        [self addSubview:descLabel];
        CGSize descSize = [descLabel.text sizeWithFont:descFont];
        CGFloat descX = CGRectGetMaxX(imageView.frame)+10;
        CGFloat descY = imageY + imageHeight/2+(imageHeight/2-nameSize.height)/2;
        descLabel.frame = CGRectMake(descX, descY, descSize.width, descSize.height);
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
