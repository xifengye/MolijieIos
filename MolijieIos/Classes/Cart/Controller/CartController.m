//
//  MGMessageViewController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "CartController.h"
#import "MGAmountView.h"
#import "DataBaseManager.h"
#import "AppDataTool.h"
#import "CartItemFrame.h"
#import "CartCell.h"
#import "Config.h"
#import "NSString+MG.h"
#import "SettlementController.h"



@interface CartController ()

@end

@implementation CartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    [self initView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onLocalOrderChange:) name:local_order_change object:nil];
    [self initData];
    
}


-(void)initView{
    self.navigationController.toolbar.hidden = NO;
    CGFloat bottomViewHeight = barHeight;
    if(_isInTab){
        bottomViewHeight+=49;
    }
    MGCartBottomView* bottomView = [[MGCartBottomView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-bottomViewHeight, self.view.frame.size.width, barHeight)];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    self.bottomView.delegate = self;
    
    UITableView* tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-bottomViewHeight)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


-(UIScrollView *)adjustContentInsetView{
    return _tableView;
}



- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
  if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
   {
       return NO;
   }else{
    return YES;
   }
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void) onLocalOrderChange:(NSNotification*) notification{
    NSNumber* data = notification.object;
    NSUInteger ID = data.integerValue;
    if(ID>0){
        OrderLocal* order = [[DataBaseManager instance]orderByID:ID];
        if(order!=nil){
            [self loadGoodsByOrderLocalFromNet:order];
        }
    }
}

-(void)initData{
    cartItemFrames = [NSMutableArray array];
    for(OrderLocal* order in [[DataBaseManager instance]allOrder]){
        [self loadGoodsByOrderLocalFromNet:order];
    }
}

-(void)loadGoodsByOrderLocalFromNet:(OrderLocal*)order{
    [AppDataTool requestGoodsDetail:order.cataId objectID:order.objectId response:^(Goods *goods) {
        CartItemFrame* olf = [[CartItemFrame alloc]init];
        [olf setData:order goods:goods];
        [cartItemFrames addObject:olf];
        
        if(cartItemFrames.count == [[DataBaseManager instance]allOrder].count){
            [self.tableView reloadData];
            [self caculatePrice];
        }
    } onError:^(ErrorCode errorCode) {
        
    }];
}
        

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cartItemFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CartCell* cell = [CartCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CartItemFrame* frame = cartItemFrames[indexPath.row];
    cell.cartItemFrame = frame;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController* controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor redColor];
//    [self.navigationController pushViewController:controller animated:true];
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CartItemFrame* frame = cartItemFrames[indexPath.row];
    return frame.cellHeight;
}

-(void)caculatePrice{
    CGFloat allPrice = 0;
    for(CartItemFrame* olf in cartItemFrames){
        if([olf.order isCheck]){
            allPrice =allPrice + (olf.order.amount * [olf.goods getPriceBySkuIndex:olf.order.skuIndex]);
        }
    }
    self.bottomView.priceLabel.text = [NSString stringWithFormat:@"总计: %@",[NSString priceString:allPrice]];
}


#pragma mark    CartCellDelegate

-(void)didGoodsAmountChange:(CartCell *)cell{
    [[DataBaseManager instance]updateOrderAmount:cell.cartItemFrame.order];
    [self caculatePrice];
}

-(void)didGoodsCheckChange:(CartCell *)cell{
    [self caculatePrice];
    BOOL isAllChecked = true;
    BOOL isNoOneChecked = true;
    
    for(CartItemFrame* olf in cartItemFrames){
        if(![olf.order isCheck]){
            isAllChecked = false;
        }else{
            isNoOneChecked = false;
        }
    }
    self.bottomView.btnSettlement.enabled = !isNoOneChecked;
    self.bottomView.btnCheckAll.selected = isAllChecked;
}

-(void)didGoodsRemoved:(CartCell *)cell{
    CartItemFrame* order = cell.cartItemFrame;
    BOOL result = [[DataBaseManager instance] deleteOrder:order.order];
    if(result){
        [cartItemFrames removeObject:order];
        [self didGoodsCheckChange:nil];
        [self.tableView reloadData];
        [[NSNotificationCenter defaultCenter]postNotificationName:local_order_change object:[NSNumber numberWithInteger:0]];
    }
}


#pragma mark BottomViewDelegate

-(void)bottomViewDidCheckAllChange:(MGCartBottomView *)view{
    for(CartItemFrame* olf in cartItemFrames){
        [olf.order setCheck:view.btnCheckAll.isSelected];
    }
    self.bottomView.btnSettlement.enabled = view.btnCheckAll.isSelected;
    [self.tableView reloadData];
    [self caculatePrice];
    
}

-(void)bottomViewDidGoSettlement:(MGCartBottomView *)view{
    SettlementController* settlementController = [[SettlementController alloc]init];
    [settlementController initItemFrames:cartItemFrames];
    settlementController.title = @"结算";
    [self.navigationController pushViewController:settlementController animated:YES];
}



@end
