//
//  OrderViewController.m
//  MolijieIos
//
//  Created by yexifeng on 16/6/2.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "OrderViewController.h"
#import "DAPagesContainer.h"
#import "AppDataTool.h"
#import "MBProgressHUD+MJ.h"
#import "OrderConsignments.h"
#import "AppDataMemory.h"
#import "BaseOrderController.h"


typedef void(^UIActionHandler)(UIAlertAction *action);

@interface OrderViewController ()<DAPageContainerDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray* _orderFrames;
    UIView* orderEmptyView;
    

}

@property (strong, nonatomic) DAPagesContainer *pagesContainer;

@end




@implementation OrderViewController

-(void)setCurrentTab:(Tabs)currentTab{
    _currentTab = currentTab;
    [self updateOrder:currentTab];
    BaseOrderController* controller = self.pagesContainer.viewControllers[currentTab];
    if(controller){
        [controller.tableView reloadData];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    _orderFrames = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.pagesContainer = [[DAPagesContainer alloc] init];
    [self.pagesContainer willMoveToParentViewController:self];
    CGRect rect = self.navigationController.navigationBar.frame;
    float y = rect.size.height + rect.origin.y;
    self.pagesContainer.view.frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height-y);
    self.pagesContainer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.pagesContainer.view];
    self.pagesContainer.delegate = self;
    [self.pagesContainer didMoveToParentViewController:self];
    
    self.pagesContainer.viewControllers = [self createTabViews:@[@"待发货", @"待收货",@"待确认" , @"全部订单"]];
    self.pagesContainer.selectedIndex = _defaultTab;
}

-(NSArray*)createTabViews:(NSArray*)titles{
    NSMutableArray* controllers = [NSMutableArray array];
    for(NSString* title in titles){
        BaseOrderController *waitSendController = [[BaseOrderController alloc] init];
        UITableView* waitSendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.pagesContainer.view.bounds.size.width, self.pagesContainer.view.bounds.size.height -self.pagesContainer.topBarHeight)];
        waitSendTableView.dataSource = self;
        waitSendTableView.delegate = self;
        waitSendController.tableView = waitSendTableView;
        [waitSendController.view addSubview:waitSendTableView];
        waitSendController.title = title;
        [controllers addObject:waitSendController];
    }
    return controllers;
}

- (void)viewWillUnload
{
    self.pagesContainer = nil;
    [super viewWillUnload];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.pagesContainer updateLayoutForNewOrientation:toInterfaceOrientation];
}

-(void)reloadOrderFromNet{
    [MBProgressHUD showMessage:@""];
    [AppDataTool loadRecentOrders:^(NSArray * orders) {
        [MBProgressHUD hideHUD];
        [[AppDataMemory instance]clearOrders];
        [[AppDataMemory instance]addOrders:orders];
        [self updateOrder:_currentTab];
    } onError:^(ErrorCode errorCode) {
    }];
    
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _orderFrames.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Identifier = @"orderCell";
    OrderCell * cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    //    if (!cell) {
    //        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    //    }
    cell.delegate = self;
    OrderFrame* orderFrame = [_orderFrames objectAtIndex:indexPath.row];
    [cell setOrderFrame:orderFrame];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderFrame* orderFrame = _orderFrames[indexPath.row];
    return orderFrame.cellHeight;
}

-(void)updateOrder:(NSUInteger)tab{
    NSArray* orders = [AppDataMemory instance].orderDict.allValues.copy;
    orderEmptyView.hidden = orders.count > 0;
    NSMutableArray* finalOrder = [NSMutableArray array];
    [_orderFrames removeAllObjects];
    if (orders && orders.count > 0) {
        for (Order* order in orders) {
            switch (tab) {
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
        for(Order* o in finalOrder){
            OrderFrame* of = [[OrderFrame alloc]init];
            [of setOrder:o];
            [_orderFrames addObject:of];
        }
    }
}

-(void)didDAPageContainerSelectedIndex:(DAPagesContainer *)container selectedIndex:(NSUInteger)index{
    self.currentTab = index;
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
            [self viewLogistics:order];
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
        [self reloadOrderFromNet];
    } onError:^(ErrorCode errorCode) {
        
    }];
}

-(void)confirmOrder:(Order*)order{
    NSLog(@"确认订单");
    [AppDataTool confirmOrder:order.SN response:^(){
        [self reloadOrderFromNet];
    } onError:^(ErrorCode errorCode) {
        
    }];
    
}

-(void)deliverBack:(Order*)order{
    NSLog(@"退货");
    [AppDataTool loadOrderConsignments:order.SN response:^(NSArray * consignments) {
        if(consignments.count>0){
            OrderConsignments* consignment = consignments[0];
            [AppDataTool deliverBack:order.SN lspCode:[[AppDataMemory instance]getLpsCodeByLpsName: consignment.DSPName] postReceptCode:consignment.PostReceptCode postFrom:consignment.SendFrom response:^(BOOL s){
                if(s){
                    [MBProgressHUD showSuccess:@"退货成功"];
                    [self reloadOrderFromNet];
                }
            } onError:^(ErrorCode errorCode) {
                
            }];
        }
    } onError:^(ErrorCode errorCode) {
        
    }];
    
    
}

-(void)confirmReceipt:(Order*)order{
    NSLog(@"确认收货");
    [AppDataTool confirmReceipt:order.SN response:^(){
        [self reloadOrderFromNet];
    } onError:^(ErrorCode errorCode) {
        
    }];
}

-(void)pay:(Order*)order{
    NSLog(@"支付");
}

-(void)viewLogistics:(Order*)order{
    NSLog(@"查看物流");
    [AppDataTool loadOrderConsignments:order.SN response:^(NSArray * consigments) {
        if(consigments.count>0){
            NSMutableString* msg = [NSMutableString string];
            NSMutableString* orderNumber = [NSMutableString string];
            for (int i = 0; i < consigments.count; i++) {
                OrderConsignments* oc = [consigments objectAtIndex:i];
                [msg appendFormat:@"物流公司:%@\n",oc.DSPName];
                [msg appendFormat:@"物流单号:%@\n",oc.PostReceptCode];
                [msg appendFormat:@"发货时间:%@\n",oc.CreatedText];
                [msg appendFormat:@"起运地址:%@\n",oc.SendFrom];
                [msg appendFormat:@"收件地址:%@\n\n",[order.Recipient getSimpleAddress]];
                
                [orderNumber appendString: oc.PostReceptCode];
                if (i < consigments.count - 1) {
                    [orderNumber appendString:@","];
                }
            }
            [self alertTip:@"物流信息" msg:msg cancelActionTitle:@"关闭" okActionTitle:@"拷贝物流单号" okHandler:^(UIAlertAction *action) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = orderNumber;
                [MBProgressHUD showSuccess:@"单号复制成功"];
            }];
        }
    } onError:^(ErrorCode errorCode) {
        
    }];
    
}


@end
