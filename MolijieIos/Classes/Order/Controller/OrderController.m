//
//  OrderController.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/28.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "OrderController.h"
#import "AppDataMemory.h"
#import "AppDataTool.h"
typedef void(^UIActionHandler)(UIAlertAction *action);

typedef enum : NSUInteger {
    TAB_WAIT_SEND,
    TAB_WAIT_RECEIVE,
    TAB_WAIT_CONFIRM,
    TAB_ALL
} Tabs;

@interface OrderController(){
    YLSlideView * _slideView;
    NSArray *_orders;
    NSMutableArray* _orderFrames;
    UIView* orderEmptyView;
}
@end
@implementation OrderController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻客户端ScrollView重用";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars =NO;
    self.modalPresentationCapturesStatusBarAppearance =NO;
    self.navigationController.navigationBar.translucent =NO;

    _orderFrames = [NSMutableArray array];
    _slideView = [[YLSlideView alloc]initWithFrame:CGRectMake(0, 20,
                                                              self.view.frame.size.width,
                                                              self.view.frame.size.height-20)
                                         forTitles:@[@"待发货",
                                                     @"待收货",
                                                     @"待确认",
                                                     @"所有订单"]];
    
    _slideView.backgroundColor = [UIColor whiteColor];
    _slideView.delegate        = self;
    [self.view addSubview:_slideView];
    
   }

- (NSInteger)columnNumber{
    return 4;
}

- (YLSlideCell *)slideView:(YLSlideView *)slideView
         cellForRowAtIndex:(NSUInteger)index{
    
    YLSlideCell * cell = [slideView dequeueReusableCell];
    
    if (!cell) {
        cell = [[YLSlideCell alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                           style:UITableViewStylePlain];
        cell.delegate   = self;
        cell.dataSource = self;
    }
    
    return cell;
}
- (void)slideVisibleView:(YLSlideCell *)cell forIndex:(NSUInteger)index{
    NSLog(@"index :%@ ",@(index));
    [self updateOrder:index];
    [cell reloadData]; //刷新TableView
    //    NSLog(@"刷新数据");
}


- (void)slideViewInitiatedComplete:(YLSlideCell *)cell forIndex:(NSUInteger)index{
    
    //可以在这里做数据的预加载（缓存数据）
    NSLog(@"缓存数据 %@",@(index));
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self updateOrder:index];
        [cell reloadData];
        
    });
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _orderFrames.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"orderCell";
    OrderCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.delegate = self;
    OrderFrame* orderFrame = [_orderFrames objectAtIndex:indexPath.row];
    [cell setOrderFrame:orderFrame];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderFrame* orderFrame = _orderFrames[indexPath.row];
    return orderFrame.cellHeight;
}

-(void)updateOrder:(NSUInteger)index{
    NSArray* orders = [AppDataMemory instance].orderDict.allValues.copy;
    orderEmptyView.hidden = orders.count > 0;
    NSMutableArray* finalOrder = [NSMutableArray array];
    [_orderFrames removeAllObjects];
    if (orders && orders.count > 0) {
        for (Order* order in orders) {
            switch (index) {
                default:
                case TAB_WAIT_SEND:
                    if (order.OrderProgress != WaitForProcess) {
                        continue;
                    }
                    break;
                case TAB_WAIT_RECEIVE:
                    if (order.OrderProgress != Processing) {
                        continue;
                    }
                    break;
                case TAB_WAIT_CONFIRM:
                    if (order.OrderProgress != WaitForConfirm) {
                        continue;
                    }
                    break;
                case TAB_ALL:
                    
                    break;
            }
            [finalOrder addObject:order];
        }
        _orders = finalOrder;
        for(Order* o in _orders){
            OrderFrame* of = [[OrderFrame alloc]init];
            [of setOrder:o];
            [_orderFrames addObject:of];
        }
    }
}

-(void)onOrderOperate:(NSInteger)btnTag order:(Order *)order{
    switch (btnTag) {
        case CancelTab:{
            [self alertTip:@"取消订单" msg:@"您确认要取消该订单?" cancelActionTitle:@"关闭" okActionTitle:@"确认取消" okHandler:^(UIAlertAction *action) {
                [self cancelOrder:order];
            }];
        }
            break;
        case ConfirmOrderTag:
            [self confirmOrder:order];
            break;
        case DeliverBackTag:{
            [self alertTip:@"退货" msg:@"您确认要退货吗?" cancelActionTitle:@"关闭" okActionTitle:@"确认退货" okHandler:^(UIAlertAction *action) {
                 [self deliverBack:order];
            }];
        }
           
            break;
        case ConfirmReceiptTag:{
            [self alertTip:@"确认收货" msg:@"您确认收到货物了吗?" cancelActionTitle:@"关闭" okActionTitle:@"确认收货" okHandler:^(UIAlertAction *action) {
                [self confirmReceipt:order];
            }];
        }
            break;
        case PayTag:
            [self pay:order];
            break;
        case ViewLogisticsTag:
            [self viewLogistics];
            break;
        default:
            break;
    }
}

-(void)alertTip:(NSString*)title msg:(NSString*)msg cancelActionTitle:(NSString*)cancelTitle  okActionTitle:(NSString*)okTitle okHandler:(UIActionHandler)okHandler{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:okHandler];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)cancelOrder:(Order*)order{
    [AppDataTool cancelOrder:order.SN response:^(){
        
    } onError:^(ErrorCode errorCode) {
        
    }];
}

-(void)confirmOrder:(Order*)order{
    NSLog(@"确认订单");
}

-(void)deliverBack:(Order*)order{
    NSLog(@"退货");
}

-(void)confirmReceipt:(Order*)order{
    NSLog(@"确认收货");
}

-(void)pay:(Order*)order{
    NSLog(@"支付");
}

-(void)viewLogistics{
    NSLog(@"查看物流");
}

@end