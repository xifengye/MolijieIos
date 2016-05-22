//
//  MGAddressCell.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/20.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "MGAddressCell.h"
#import "Config.h"

@implementation MGAddressCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"HomeCell";
    MGAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell = [[MGAddressCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        //添加内部的子控件
        [self setupSubviews];
    }
    return self;
}


-(void)setupSubviews{
    UIButton* btnCheck = [[UIButton alloc]init];
    [btnCheck setImage:[UIImage imageNamed:@"checkbox_normal"] forState:UIControlStateNormal];
    [btnCheck setImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateSelected];
    self.btnDefalut = btnCheck;
    [btnCheck addTarget:self action:@selector(onCheckChange) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnCheck];

    
    UILabel* nameLabel = [[UILabel alloc]init];
    self.nameLabel = nameLabel;
    self.nameLabel.font = labelFont;
    [self addSubview:nameLabel];
    
    UILabel* phoneLabel = [[UILabel alloc]init];
    self.phoneLabel = phoneLabel;
    self.phoneLabel.font = labelFont;
    [self addSubview:phoneLabel];
    
    UILabel* addressLabel = [[UILabel alloc]init];
    self.addressLabel = addressLabel;
    self.addressLabel.font = labelFont;
    [self addSubview:addressLabel];
    
    UILabel* defaultLabel = [[UILabel alloc]init];
    self.defaultLabel = defaultLabel;
    self.defaultLabel.font = labelFont;
    self.defaultLabel.text = @"设置为默认地址";
    [self addSubview:defaultLabel];

    
    
    UIButton* btnDelete = [[UIButton alloc]init];
    [btnDelete setImage:[UIImage imageNamed:@"ico_delete"] forState:UIControlStateNormal];
    self.btnDelete = btnDelete;
    [self addSubview:btnDelete];
    [btnDelete addTarget:self action:@selector(onDelete) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor blackColor];
    self.lineView  = lineView;
    [self addSubview:lineView];
    
}


-(void)setCellFrame:(AddressCellFrame *)cellFrame{
    _cellFrame = cellFrame;
    _nameLabel.frame = cellFrame.nameLabelF;
    _phoneLabel.frame = cellFrame.phoneLabelF;
    _addressLabel.frame = cellFrame.addressLabelF;
    _lineView.frame = cellFrame.lineViewF;
    _btnDefalut.frame = cellFrame.btnDefaultF;
    _btnDelete.frame = cellFrame.btnDeleteF;
    _defaultLabel.frame = cellFrame.defaultLabelF;
    
    _nameLabel.text = cellFrame.recipient.RealName;
    _phoneLabel.text = cellFrame.recipient.Mobile;
    _addressLabel.text = [cellFrame.recipient getSimpleAddress];
    _btnDefalut.selected = cellFrame.recipient.AsDefault;
    
}

- (void)drawRect:(CGRect)rect{
    //创建路径并获取句柄
    CGMutablePathRef path = CGPathCreateMutable();
    //指定矩形
    CGRect rectangle = CGRectMake(rect.origin.x+margin,rect.origin.y+margin,rect.size.width-margin*2,rect.size.height-margin*2);
    //将矩形添加到路径中
    CGPathAddRect(path,NULL,rectangle);
    //获取上下文
    CGContextRef currentContext =
    UIGraphicsGetCurrentContext();
    //将路径添加到上下文
    CGContextAddPath(currentContext, path);
    //设置矩形填充色
    [[UIColor whiteColor] setFill];
    //矩形边框颜色
    [[UIColor grayColor] setStroke];
    //边框宽度
    CGContextSetLineWidth(currentContext,1.0f);
    //绘制
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    CGPathRelease(path);
}


@end
