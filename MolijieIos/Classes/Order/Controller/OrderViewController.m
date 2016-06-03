//
//  OrderViewController.m
//  MolijieIos
//
//  Created by yexifeng on 16/6/2.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "OrderViewController.h"
#import "DAPagesContainer.h"
#import "WaitSendController.h"
#import "WaitConfirmController.h"
#import "WaitReceiveController.h"
#import "AllOrderController.h"
#import "OrderController.h"
#import "AppDataTool.h"
#import "MBProgressHUD+MJ.h"
#import "OrderConsignments.h"
#import "AppDataMemory.h"




@interface OrderViewController (){
    NSMutableArray* _orderFrames;
    UIView* orderEmptyView;
    

}

@property (strong, nonatomic) DAPagesContainer *pagesContainer;

@end




@implementation OrderViewController

-(void)setCurrentTab:(NSUInteger)currentTab{
    _currentTab = currentTab;
    [self updateOrder:currentTab];
}
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    self.pagesContainer = [[DAPagesContainer alloc] init];
    [self.pagesContainer willMoveToParentViewController:self];
    self.pagesContainer.view.frame = self.view.bounds;
    self.pagesContainer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.pagesContainer.view];
    [self.pagesContainer didMoveToParentViewController:self];
    
    WaitSendController *waitSendController = [[WaitSendController alloc] init];
    UITableView* waitSendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height -self.pagesContainer.topBarHeight)];
    [waitSendController.view addSubview:waitSendTableView];
    waitSendController.title = @"待发货";
    
    WaitReceiveController *waitReceiveViewController = [[WaitReceiveController alloc] init];
    UITableView* waitReceiveTableView = [[UITableView alloc]initWithFrame:waitSendTableView.bounds];
    [waitReceiveViewController.view addSubview:waitReceiveTableView];
    waitReceiveViewController.title = @"待收货";
    
    WaitConfirmController *waitConfirmViewController = [[WaitConfirmController alloc] init];
    UITableView* waitConfirmTableView = [[UITableView alloc]initWithFrame:waitSendTableView.bounds];
    [waitConfirmViewController.view addSubview:waitConfirmTableView];
    waitConfirmViewController.title = @"待确认";
    
    AllOrderController *allViewController = [[AllOrderController alloc] init];
    allViewController.title = @"全部订单";
    
    self.pagesContainer.viewControllers = @[waitSendController, waitReceiveViewController,waitConfirmViewController , allViewController];
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

@end
