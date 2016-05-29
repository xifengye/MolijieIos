//
//  OrderCell.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/29.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "OrderCell.h"
#import "OrderItemView.h"

@implementation OrderCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"MeCell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        UILabel* smLabel = [[UILabel alloc]init];
        [self addSubview:smLabel];
        smLabel.font = timeFont;
        self.smLabel = smLabel;
        
        UILabel* timeLabel = [[UILabel alloc]init];
        [self addSubview:timeLabel];
        timeLabel.font = timeFont;
        self.timeLabel = timeLabel;
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        
        
        UILabel* statusLabel = [[UILabel alloc]init];
        [self addSubview:statusLabel];
        statusLabel.font = statusFont;
        self.statusLabel = statusLabel;
        self.statusLabel.textColor = [UIColor redColor];
        
        UIView* items = [[UIView alloc]init];
        [self addSubview:items];
        self.items = items;
        
        UILabel* descLabel = [[UILabel alloc]init];
        [self addSubview:descLabel];
        descLabel.font = normalFont;
        self.descLabel = descLabel;
        self.descLabel.textAlignment = NSTextAlignmentRight;
        
        

        
    }
    return self;
}

-(void)setOrderFrame:(OrderFrame *)orderFrame{
    _orderFrame = orderFrame;
    self.smLabel.frame = orderFrame.smF;
    self.timeLabel.frame = orderFrame.timeF;
    self.statusLabel.frame = orderFrame.statusF;
    self.items.frame = orderFrame.itemsF;
    self.descLabel.frame = orderFrame.descF;
    UIView* line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(orderFrame.itemsF), orderFrame.itemsF.size.width, 0.5f)];
    line1.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
    [self addSubview:line1];
    
    UIView* line2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(orderFrame.itemsF), orderFrame.itemsF.size.width, 0.5f)];
    line2.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
    [self addSubview:line2];
    
    UIView* line3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(orderFrame.descF), orderFrame.itemsF.size.width, 0.5f)];
    line3.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
    [self addSubview:line3];

    
    self.smLabel.text = orderFrame.order.SN;
    self.timeLabel.text = orderFrame.order.CreatedText;
    self.statusLabel.text = [orderFrame.order getOrderProgressText];
    
    CGFloat y =0;
    for(Items* item in orderFrame.order.Items){
        OrderItemView* oiv = [[OrderItemView alloc]initWithFrame:CGRectMake(0, y, orderFrame.itemsF.size.width, order_item_height)];
        y+=order_item_height;
        [oiv setItem:item];
        [self.items addSubview:oiv];
    }
    self.descLabel.text = [NSString stringWithFormat:@"共%ld件商品 合计:%@(含运费%@)",orderFrame.order.Items.count,[NSString priceString:orderFrame.order.TotalPrice],[NSString priceString:orderFrame.order.Freight]];
    NSArray* clientSupportCanDoList = @[@"Cancel",@"ConfirmOrder",@"DeliverBack",@"ConfirmReceipt",@"Pay"];
    
    NSArray* cdl = [orderFrame.order.CanDoList componentsSeparatedByString:@","];
    NSMutableArray* canDoList = [NSMutableArray array];
    for(NSString* canDo in cdl){
        if([clientSupportCanDoList containsObject:canDo]){
            [canDoList addObject:canDo];
        }
    }
    if([orderFrame.order canViewLogistics]){
        [canDoList addObject:@"ViewLogistics"];
    }
    CGFloat btnWidth = orderFrame.btnsF.size.width/canDoList.count;
    CGFloat btnX = 0;
    for(NSString* canDo in canDoList){
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, orderFrame.btnsF.origin.y, btnWidth, orderFrame.btnsF.size.height)];
        btn.font = normalFont;
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btn addTarget:self action:@selector(onOrderOperate:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        if([@"Cancel" isEqualToString:canDo]){
            [btn setTitle:@"取消订单" forState:UIControlStateNormal];
            [btn setTag:CancelTab];
            [self addSubview:btn];
//        }else if([@"EditPrice" isEqualToString:canDo]){
//            [btn setTitle:@"改价" forState:UIControlStateNormal];
        }else if([@"ConfirmOrder" isEqualToString:canDo]){
            [btn setTitle:@"确认订单" forState:UIControlStateNormal];
            [btn setTag:ConfirmOrderTag];
            [self addSubview:btn];
        }else if([@"DeliverBack" isEqualToString:canDo]){
            [btn setTitle:@"退货" forState:UIControlStateNormal];
            [btn setTag:DeliverBackTag];
            [self addSubview:btn];
        }else if([@"ConfirmReceipt" isEqualToString:canDo]){
            [btn setTitle:@"确认收货" forState:UIControlStateNormal];
            [btn setTag:ConfirmReceiptTag];
            [self addSubview:btn];
        }else if([@"Pay" isEqualToString:canDo]){
            [btn setTitle:@"支付" forState:UIControlStateNormal];
            [btn setTag:PayTag];
            [self addSubview:btn];
        }else if([@"ViewLogistics" isEqualToString:canDo]){
            [btn setTitle:@"查看物流" forState:UIControlStateNormal];
            [btn setTag:ViewLogisticsTag];
            [self addSubview:btn];
        }else{
            
        }
        btnX+=btnWidth;
    }
}


-(void)onOrderOperate:(UIButton*)btn{
    if([self.delegate respondsToSelector:@selector(onOrderOperate:order:)]){
        [self.delegate onOrderOperate:btn.tag order:self.orderFrame.order];
    }
}

@end
