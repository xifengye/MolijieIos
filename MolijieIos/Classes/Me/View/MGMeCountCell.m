//
//  MGMeCountCell.m
//  Sinafensi
//
//  Created by yexifeng on 15/11/30.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "MGMeCountCell.h"
#define Less_width  27.5

@implementation MGMeCountCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"MeCountCell";
    MGMeCountCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell = [[MGMeCountCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        NSLog(@"cell width = %f",self.frame.size.width);
        UIFont* numberFont = [UIFont fontWithName:@"Helvetica-Bold"  size:(16.0)];
        UIFont* descFont = [UIFont systemFontOfSize:14];
        CGFloat perWidth = self.frame.size.width/3;
        
        UILabel* weiboCountLabel = [[UILabel alloc]init];
        weiboCountLabel.text = @"30";
        [self addSubview:weiboCountLabel];
        weiboCountLabel.font = numberFont;
        CGSize weiboCountLabelSize = [weiboCountLabel.text sizeWithFont:numberFont];
        CGFloat weiboCountLabelX = Less_width+(perWidth-weiboCountLabelSize.width)/2;
        CGFloat weiboCountLabelY = 2;
        weiboCountLabel.frame = CGRectMake(weiboCountLabelX,weiboCountLabelY,weiboCountLabelSize.width,weiboCountLabelSize.height);

        UILabel* weiboLabel = [[UILabel alloc]init];
        weiboLabel.text = @"微博";
        [self addSubview:weiboLabel];
        weiboLabel.font = descFont;
        weiboLabel.textColor = [UIColor grayColor];
        CGSize weiboLabelSize = [weiboLabel.text sizeWithFont:numberFont];
        CGFloat weiboLabelX = Less_width+(perWidth-weiboLabelSize.width)/2;
        CGFloat weiboLabelY = CGRectGetMaxY(weiboCountLabel.frame);
        weiboLabel.frame = CGRectMake(weiboLabelX,weiboLabelY,weiboLabelSize.width,weiboLabelSize.height);
        
        
        UILabel* guanzhuCountLabel = [[UILabel alloc]init];
        guanzhuCountLabel.text = @"26";
        [self addSubview:guanzhuCountLabel];
        guanzhuCountLabel.font = numberFont;
        CGSize guanzhuCountLabelSize = [guanzhuCountLabel.text sizeWithFont:numberFont];
        CGFloat guanzhuCountLabelX = Less_width+(self.frame.size.width-guanzhuCountLabelSize.width)/2;
        CGFloat guanzhuCountLabelY = 2;
        guanzhuCountLabel.frame = CGRectMake(guanzhuCountLabelX,guanzhuCountLabelY,guanzhuCountLabelSize.width,guanzhuCountLabelSize.height);
        
        UILabel* guanzhuLabel = [[UILabel alloc]init];
        guanzhuLabel.text = @"关注";
        [self addSubview:guanzhuLabel];
        guanzhuLabel.font = descFont;
        guanzhuLabel.textColor = [UIColor grayColor];
        CGSize guanzhuLabelSize = [guanzhuLabel.text sizeWithFont:numberFont];
        CGFloat guanzhuLabelX = Less_width+perWidth+(perWidth-guanzhuLabelSize.width)/2;
        CGFloat guanzhuLabelY = CGRectGetMaxY(guanzhuCountLabel.frame);
        guanzhuLabel.frame = CGRectMake(guanzhuLabelX,guanzhuLabelY,guanzhuLabelSize.width,guanzhuLabelSize.height);
        
        
        UILabel* fensiCountLabel = [[UILabel alloc]init];
        fensiCountLabel.text = @"5";
        [self addSubview:fensiCountLabel];
        fensiCountLabel.font = numberFont;
        CGSize fensiCountLabelSize = [fensiCountLabel.text sizeWithFont:numberFont];
        CGFloat fensiCountLabelX = Less_width+perWidth*2+(perWidth-fensiCountLabelSize.width)/2;
        CGFloat fensiCountLabelY = 2;
        fensiCountLabel.frame = CGRectMake(fensiCountLabelX,fensiCountLabelY,fensiCountLabelSize.width,fensiCountLabelSize.height);
        
        UILabel* fensiLabel = [[UILabel alloc]init];
        fensiLabel.text = @"粉丝";
        [self addSubview:fensiLabel];
        fensiLabel.font = descFont;
        fensiLabel.textColor = [UIColor grayColor];
        CGSize fensiLabelSize = [fensiLabel.text sizeWithFont:numberFont];
        CGFloat fensiLabelX = Less_width+perWidth*2+(perWidth-fensiLabelSize.width)/2;
        CGFloat fensiLabelY = CGRectGetMaxY(fensiCountLabel.frame);
        fensiLabel.frame = CGRectMake(fensiLabelX,fensiLabelY,fensiLabelSize.width,fensiLabelSize.height);
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
