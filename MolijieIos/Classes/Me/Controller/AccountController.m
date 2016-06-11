//
//  AccountController.m
//  MolijieIos
//
//  Created by yexifeng on 16/6/10.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "AccountController.h"
#import "AppDataMemory.h"

@implementation AccountController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initSubViews];
}

-(void)initSubViews{
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
//            cell.imageView.image = [UIImage imageNamed:@"list_ico_recommend"];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = @"账号";
            cell.textLabel.backgroundColor = [UIColor blueColor];
            cell.detailTextLabel.text = [AppDataMemory instance].user.Mobile;
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.imageView.image = [UIImage imageNamed:@"list_ico_recommend"];
            cell.textLabel.text = @"ID";
            cell.detailTextLabel.text = [AppDataMemory instance].user.UserName;
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
//            cell.imageView.image = [UIImage imageNamed:@"list_ico_suggest"];
            cell.textLabel.text = @"密码";
            cell.detailTextLabel.text = @"******";
        } whenSelected:^(NSIndexPath *indexPath) {
            NSLog(@"新的好友");
        }];
        
    }];
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
//            cell.imageView.image = [UIImage imageNamed:@"list_ico_recommend"];
            cell.textLabel.text = @"昵称";
            cell.detailTextLabel.text = [AppDataMemory instance].user.NickName;
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
//            cell.imageView.image = [UIImage imageNamed:@"list_ico_recommend"];
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = [AppDataMemory instance].user.Gender;
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
//            cell.imageView.image = [UIImage imageNamed:@"list_ico_suggest"];
            cell.textLabel.text = @"生日";
            cell.detailTextLabel.text = [AppDataMemory instance].user.BirthDate;
        } whenSelected:^(NSIndexPath *indexPath) {
            NSLog(@"新的好友");
        }];
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"ValueTextCell";
//            cell.imageView.image = [UIImage imageNamed:@"list_ico_check_up"];
            cell.textLabel.text = @"邮箱";
            cell.detailTextLabel.text = [AppDataMemory instance].user.Mail;
        } whenSelected:^(NSIndexPath *indexPath) {
            
        }];
    }];
}
@end
