//
//  MGAddressCell.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/20.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressCellFrame.h"

@interface MGAddressCell : UITableViewCell

+(instancetype) cellWithTableView:(UITableView*)tableView;
@property(nonatomic,strong)AddressCellFrame* cellFrame;
@property(nonatomic,weak)UILabel* nameLabel;
@property(nonatomic,weak)UILabel* phoneLabel;
@property(nonatomic,weak)UILabel* addressLabel;
@property(nonatomic,weak)UILabel* defaultLabel;

@property(nonatomic,weak)UIButton* btnDefalut;
@property(nonatomic,weak)UIButton* btnDelete;
@property(nonatomic,weak)UIView* lineView ;
@end
