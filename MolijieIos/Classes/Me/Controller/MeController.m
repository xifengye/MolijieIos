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
#import "OrderViewController.h"
#import "AccountController.h"
#import "AppDataMemory.h"
#import "SuggestController.h"


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


-(void)setupSettingView{
    UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.1)];
    
     self.tableView.tableHeaderView = headerView;
    __block MeController* blockSelf = self;

    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"MeCell";
            staticContentCell.tableViewCellSubclass = [MGMeCellView class];
            staticContentCell.cellHeight = CELL_HEIGHT;
            MGMeCellView* header = (MGMeCellView*)cell;
            header.nameLabel.text = [AppDataMemory instance].user.NickName;
            header.descLabel.text = [AppDataMemory instance].user.Mobile;
        } whenSelected:^(NSIndexPath *indexPath) {
            AccountController* controller = [[AccountController alloc]init];
            [blockSelf.navigationController pushViewController:controller animated:YES];
        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"list_icon_order"];
            cell.textLabel.text = @"我的订单";
            cell.detailTextLabel.text = @"查看全部订单";
        } whenSelected:^(NSIndexPath *indexPath) {
            [blockSelf viewOrder:TAB_ALL];
        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"MeOrderStatusCell";
            staticContentCell.tableViewCellSubclass = [MGMeOrderStatusCell class];
            cell.accessoryType = UITableViewCellAccessoryNone;
            if(cell){
                MGMeOrderStatusCell* orderStatusCell = (MGMeOrderStatusCell*)cell;
                [orderStatusCell.btnWaitSend addTarget:blockSelf action:@selector(onViewOrderByStatus:) forControlEvents:UIControlEventTouchUpInside];
                [orderStatusCell.btnWaitReceive addTarget:blockSelf action:@selector(onViewOrderByStatus:) forControlEvents:UIControlEventTouchUpInside];
                [orderStatusCell.btnWaitConfirm addTarget:blockSelf action:@selector(onViewOrderByStatus:) forControlEvents:UIControlEventTouchUpInside];
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
            AddressController* controller = [[AddressController alloc]init];
            [blockSelf.navigationController pushViewController:controller animated:YES];

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
            SuggestController* controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SuggestController"];
            [blockSelf.navigationController pushViewController:controller animated:YES];
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
            [self viewOrder:TAB_WAIT_SEND ];
            break;
        case 2://待收货
            [self viewOrder:TAB_WAIT_RECEIVE ];
            break;
        case 3://待确认
            [self viewOrder:TAB_WAIT_CONFIRM ];
            break;
        default:
            break;
    }
}

-(void)viewOrder:(Tabs) tab{
    OrderViewController* controller = [[OrderViewController alloc]init];
    controller.defaultTab = tab;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
