//
//  SettlementController.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "SettlementController.h"
#import "Config.h"
#import "SettlementCell.h"
#import "AppDataMemory.h"
#import "AppDataTool.h"

@implementation SettlementController


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initData{
    [self caculatePrice];
    recipient = [[AppDataMemory instance]defaultRecipient];
    if(recipient){
        [self calculateFreight];
    }
}

-(NSString*)getCartItemsJson{
    NSMutableString* sb = [NSMutableString stringWithString:@"["];
    int i=0;
    for(CartItemFrame* so in settlementItemFrames){
        [sb appendString:[so.order toJsonString]];
        if(++i<settlementItemFrames.count){
            [sb appendString:@","];
        }
    }
    [sb appendString:@"]"];
    return sb;
}

-(void)calculateFreight{
    NSString* cartItemJson = [self getCartItemsJson];
    NSString* recipientJson = [recipient getJsonString];
    NSLog(@"cartItemJson=%@,recipientJson=%@",cartItemJson,recipientJson);
    [AppDataTool calculateFreight:cartItemJson recipient:recipientJson response:^(CGFloat freight) {
        self.bottomView.priceLabel.text = [NSString stringWithFormat:@"运费: %@",[NSString priceString:freight]];
    } onError:^(ErrorCode errorCode) {
        
    }];
}

-(void)initItemFrames:(NSArray *)array{
    settlementItemFrames = [NSMutableArray array];
    for(CartItemFrame* olf in array){
        SettlementItemFrame* itemFrame =[[SettlementItemFrame alloc]init];
        [itemFrame setData:olf.order goods:olf.goods];
        [settlementItemFrames addObject:itemFrame];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect rect = self.navigationController.navigationBar.frame;
    float y = rect.size.height + rect.origin.y;
    self.tableView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0);
}


-(void)initView{
    
    MGSettlementBottomView* bottomView = [[MGSettlementBottomView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-barHeight, self.view.frame.size.width, barHeight)];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    self.bottomView.delegate = self;
    
    CGFloat paymentViewHeight = barHeight;
    MGBorderButton* paymentView = [[MGBorderButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-barHeight-paymentViewHeight, self.view.frame.size.width, paymentViewHeight)];
    [self.view addSubview:paymentView];
    
    UIImage* payIcon = [UIImage imageNamed:@"zfb"];
    UIImageView* payIconView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, (paymentViewHeight-payIcon.size.height)/2, payIcon.size.width, payIcon.size.height)];
    [paymentView addSubview:payIconView];
    [payIconView setImage:payIcon];
    
    NSString* payName = @"支付宝";
    CGSize payNameSize = [payName sizeWithFont:labelFont];
    UILabel* payLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin*2+payIcon.size.width, (paymentViewHeight-payNameSize.height)/2, payNameSize.width, payNameSize.height)];
    payLabel.text = payName;
    payLabel.font = labelFont;
    [paymentView addSubview:payLabel];
    
    UIImage* checkImg = [UIImage imageNamed:@"btn_radio_on"];
    UIButton* btnCheck = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-margin-checkImg.size.width, (paymentViewHeight-checkImg.size.height)/2, checkImg.size.width, checkImg.size.height)];
    [btnCheck setImage:checkImg forState:UIControlStateSelected];
    btnCheck.selected = YES;
    [paymentView addSubview:btnCheck];
    
    
    UITableView* tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-barHeight-paymentViewHeight-margin)];
    [self.view addSubview:tableView];
    self.tableView = tableView;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


-(BOOL)hiddenNavigationBar{
    return NO;
}

-(BOOL)needGoBack{
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return settlementItemFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SettlementCell* cell = [SettlementCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SettlementItemFrame* frame = settlementItemFrames[indexPath.row];
    cell.settlementItemFrame = frame;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController* controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor redColor];
    //    [self.navigationController pushViewController:controller animated:true];
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettlementItemFrame* frame = settlementItemFrames[indexPath.row];
    return frame.cellHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MGAddressView* addressView = [[MGAddressView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, addressNoOperateCellFrame.cellHeight+margin)];
    addressView.addressFrame = addressNoOperateCellFrame;
    [addressView addTarget:self action:@selector(onAddressClicked) forControlEvents:UIControlEventTouchUpInside];
    return addressView;
}

-(void)onAddressClicked{
    NSLog(@"address clicked");
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    addressNoOperateCellFrame = [[AddressNoOperateCellFrame alloc]init];
    [addressNoOperateCellFrame setRecipient:[[AppDataMemory instance] defaultRecipient]];
    return addressNoOperateCellFrame.cellHeight+margin;
}

-(void)caculatePrice{
    CGFloat allPrice = 0;
    for(SettlementItemFrame* olf in settlementItemFrames){
        if([olf.order isCheck]){
            allPrice =allPrice + (olf.order.amount * [olf.goods getPriceBySkuIndex:olf.order.skuIndex]);
        }
    }
    self.bottomView.priceLabel.text = [NSString stringWithFormat:@"总计: %@",[NSString priceString:allPrice]];
}

-(void)bottomViewDidCommit:(MGSettlementBottomView *)view{
    NSLog(@"提交订单");
}


@end
