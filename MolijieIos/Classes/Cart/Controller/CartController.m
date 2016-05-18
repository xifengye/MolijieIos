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
#import "OrderLocalFrame.h"
#import "CartCell.h"
#import "Config.h"


@interface CartController ()

@end

@implementation CartController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self initView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onLocalOrderChange:) name:local_order_change object:nil];
    [self initData];
    
}

-(void)initView{
    CGFloat bottomViewHeight = barHeight;
    if(_navigationBarHidden){
        bottomViewHeight = barHeight*2;
    }
    MGBottomView* bottomView = [[MGBottomView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-bottomViewHeight, self.view.frame.size.width, barHeight)];
    [self.view addSubview:bottomView];
    UITableView* tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-bottomViewHeight)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


-(void)setupNavBar{
    [self.navigationController setNavigationBarHidden:_navigationBarHidden];
    if(!_navigationBarHidden){
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.title = @"购物车";
    
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

-(void)goBack{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void) onLocalOrderChange:(NSNotification*) notification{
    NSNumber* data = notification.object;
    NSUInteger ID = data.integerValue;
    OrderLocal* order = [[DataBaseManager instance]orderByID:ID];
    if(order!=nil){
        [self loadGoodsByOrderLocalFromNet:order];
    }
}

-(void)initData{
    orderLocalFrames = [NSMutableArray array];
    for(OrderLocal* order in [[DataBaseManager instance]allOrder]){
        [self loadGoodsByOrderLocalFromNet:order];
    }
}

-(void)loadGoodsByOrderLocalFromNet:(OrderLocal*)order{
    [AppDataTool requestGoodsDetail:order.cataId objectID:order.objectId response:^(Goods *goods) {
        OrderLocalFrame* olf = [[OrderLocalFrame alloc]init];
        [olf setData:order goods:goods];
        [orderLocalFrames addObject:olf];
        
        if(orderLocalFrames.count == [[DataBaseManager instance]allOrder].count){
            [self.tableView reloadData];
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
    return orderLocalFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CartCell* cell = [CartCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderLocalFrame* frame = orderLocalFrames[indexPath.row];
    cell.orderFrame = frame;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController* controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor redColor];
//    [self.navigationController pushViewController:controller animated:true];
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderLocalFrame* frame = orderLocalFrames[indexPath.row];
    return frame.cellHeight;
}


@end
