//
//  MGMeViewController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "MeController.h"
#import "MGMeCellView.h"
#import "MGMeCountCell.h"


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
    [self setupNavBar];
    [self setupSettingView];
}

-(void)setupSettingView{
//     UIView* profileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
//    profileView.backgroundColor = [UIColor redColor];
//    
//     self.tableView.tableHeaderView = profileView;
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
       [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
           staticContentCell.reuseIdentifier = @"MeCell";
           staticContentCell.tableViewCellSubclass = [MGMeCellView class];
           staticContentCell.cellHeight = CELL_HEIGHT;
       } whenSelected:^(NSIndexPath *indexPath) {
           
       }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"MeCountCell";
            staticContentCell.tableViewCellSubclass = [MGMeCountCell class];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }];
    }];
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
       [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
           staticContentCell.reuseIdentifier = @"ValueTextCell";
           cell.imageView.image = [UIImage imageNamed:@"new_friend"];
           cell.textLabel.text = @"新的好友";
       } whenSelected:^(NSIndexPath *indexPath) {
           NSLog(@"新的好友");
       }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"new_friend"];
            cell.textLabel.text = @"微博等级";
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"new_friend"];
            cell.textLabel.text = @"编辑资料";
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
    }];
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"new_friend"];
            cell.textLabel.text = @"我的相册";
        } whenSelected:^(NSIndexPath *indexPath) {
            NSLog(@"新的好友");
        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"new_friend"];
            cell.textLabel.text = @"我的点评";
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"new_friend"];
            cell.textLabel.text = @"我的赞";
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
    }];
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"new_friend"];
            cell.textLabel.text = @"微博会员";
        } whenSelected:^(NSIndexPath *indexPath) {
            NSLog(@"新的好友");
        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"new_friend"];
            cell.textLabel.text = @"微博运动";
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"new_friend"];
            cell.textLabel.text = @"微博支付";
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
    }];
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"new_friend"];
            cell.textLabel.text = @"草稿箱";
        } whenSelected:^(NSIndexPath *indexPath) {
        }];
    }];

    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.imageView.image = [UIImage imageNamed:@"new_friend"];
            cell.textLabel.text = @"更多";
        } whenSelected:^(NSIndexPath *indexPath) {
        }];
    }];


}

-(void)setupNavBar{
     self.tabBarItem.badgeValue = @"meme";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
