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

@implementation SettlementController


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
    [self caculatePrice];
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
    
    UITableView* tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-barHeight)];
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

-(void)caculatePrice{
    CGFloat allPrice = 0;
    for(SettlementItemFrame* olf in settlementItemFrames){
        if([olf.order isCheck]){
            allPrice =allPrice + (olf.order.amount * [olf.goods getPriceBySkuIndex:olf.order.skuIndex]);
        }
    }
    self.bottomView.priceLabel.text = [NSString stringWithFormat:@"总计: %@",[NSString priceString:allPrice]];
}


@end
