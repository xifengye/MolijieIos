//
//  MGMeViewController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MeController.h"
#import "MGMeCellView.h"
#import "MGMeOrderStatusCell.h"
#import "AddressController.h"
#import "OrderController.h"


@interface MeController ()

@end

@implementation MeController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.tableView.showsVerticalScrollIndicator = false;
    }
    return self;
}
- (void)viewDidLoad {
    NSLog(@"controller width = %f",self.view.frame.size.width);
    [super viewDidLoad];
    [self setupSettingView];
}

-(BOOL)needGoBack{
    return NO;
}


-(void)setupSettingView{
    UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.1)];
    
     self.tableView.tableHeaderView = headerView;
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"MeCell";
            staticContentCell.tableViewCellSubclass = [MGMeCellView class];
            staticContentCell.cellHeight = CELL_HEIGHT;
        } whenSelected:^(NSIndexPath *indexPath) {

        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"list_icon_order"];
            cell.textLabel.text = @"查看全部订单";
        } whenSelected:^(NSIndexPath *indexPath) {
            OrderController* controller = [[OrderController alloc]init];
            [self presentViewController:controller animated:true completion:nil];
        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"MeOrderStatusCell";
            staticContentCell.tableViewCellSubclass = [MGMeOrderStatusCell class];
            cell.accessoryType = UITableViewCellAccessoryNone;
            if(cell){
                MGMeOrderStatusCell* orderStatusCell = (MGMeOrderStatusCell*)cell;
                [orderStatusCell.btnWaitSend addTarget:self action:@selector(onViewOrderByStatus:) forControlEvents:UIControlEventTouchUpInside];
                [orderStatusCell.btnWaitReceive addTarget:self action:@selector(onViewOrderByStatus:) forControlEvents:UIControlEventTouchUpInside];
                [orderStatusCell.btnWaitConfirm addTarget:self action:@selector(onViewOrderByStatus:) forControlEvents:UIControlEventTouchUpInside];
            }
        }];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"list_ico_collection"];
            cell.textLabel.text = @"我的收藏";
        } whenSelected:^(NSIndexPath *indexPath) {
            NSLog(@"新的好友");
        }];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"list_ico_address"];
            cell.textLabel.text = @"我的地址";
        } whenSelected:^(NSIndexPath *indexPath) {
            AddressController* addressController = [[AddressController alloc]init];
            UINavigationController* navController = [[UINavigationController alloc]initWithRootViewController:addressController];
            
            [self presentViewController:navController animated:true completion:nil];

        }];


    }];
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
       [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"list_ico_recommend"];
            cell.textLabel.text = @"推荐给好友(Android)";
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"list_ico_recommend"];
            cell.textLabel.text = @"推荐给好友(IPhone)";
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];

        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"list_ico_suggest"];
            cell.textLabel.text = @"我要提建议";
        } whenSelected:^(NSIndexPath *indexPath) {
            NSLog(@"新的好友");
        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"list_ico_check_up"];
            cell.textLabel.text = @"检查更新";
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"list_ico_about"];
            cell.textLabel.text = @"关于魔力街";
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)onViewOrderByStatus:(UIButton*)sender{
    
    int tag = sender.tag;
    switch (tag) {
        case 1://待发货
            NSLog(@"待发货");
            break;
        case 2://待收货
            NSLog(@"待收货");
            break;
        case 3://待确认
            NSLog(@"待确认");
            break;
        default:
            break;
    }
}


@end
