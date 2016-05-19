//
//  MGMeCountCell.m
//  Sinafensi
//
//  Created by yexifeng on 15/11/30.
//  Copyright © 2015年 moregood. All rights reserved.
//

#import "MGMeOrderStatusCell.h"
#import "UIImage+MG.h"
#define Less_width  27.5

@implementation MGMeOrderStatusCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"MeCountCell";
    MGMeOrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell = [[MGMeOrderStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIFont* numberFont = [UIFont systemFontOfSize:14];
        CGFloat perWidth = (self.frame.size.width+Less_width*2)/3;
        CGFloat height=  self.frame.size.height;
        
        UIButton* btnWaitSend = [[UIButton alloc]init];
        btnWaitSend.tag = 1;
        [btnWaitSend setTitle:@"待发货" forState:UIControlStateNormal] ;
        [self addSubview:btnWaitSend];
        btnWaitSend.font = numberFont;
        [btnWaitSend setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnWaitSend.frame = CGRectMake(0,0,perWidth,height);
        [btnWaitSend setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        self.btnWaitSend = btnWaitSend;
        
        UIView* lineView1 = [[UIView alloc]initWithFrame:CGRectMake(perWidth, 0, 0.5f, height)];
        lineView1.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView1];
        
        UIButton* btnWaitReceive = [[UIButton alloc]init];
        btnWaitReceive.tag = 2;
        [btnWaitReceive setTitle: @"待收货" forState:UIControlStateNormal];
        [self addSubview:btnWaitReceive];
        btnWaitReceive.font = numberFont;
        [btnWaitReceive setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnWaitReceive.frame = CGRectMake(perWidth,0,perWidth,height);
        [btnWaitReceive setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        self.btnWaitReceive = btnWaitReceive;
        
        UIView* lineView2 = [[UIView alloc]initWithFrame:CGRectMake(perWidth*2, 0, 0.5f, height)];
        lineView2.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView2];
        
        UIButton* btnWaitConfirm = [[UIButton alloc]init];
        btnWaitConfirm.tag = 3;
        [btnWaitConfirm setTitle: @"待确认" forState:UIControlStateNormal];
        [self addSubview:btnWaitConfirm];
        btnWaitConfirm.font = numberFont;
        [btnWaitConfirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnWaitConfirm.frame = CGRectMake(perWidth*2,0,perWidth,height);
        [btnWaitConfirm setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        self.btnWaitConfirm = btnWaitConfirm;
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
