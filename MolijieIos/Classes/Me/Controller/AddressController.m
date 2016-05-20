//
//  AddressController.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/19.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "AddressController.h"
#import "MGAddressCell.h"
#import "AppDataMemory.h"
#import "Config.h"
#import "UIImage+MG.h"

@implementation AddressController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"我的地址";
    [self initView];
    addressCellFrameList = [NSMutableArray array];
    for(Recipient* r in [AppDataMemory instance].recipients){
        AddressCellFrame* acf = [[AddressCellFrame alloc]init];
        [acf setRecipient:r];
        [addressCellFrameList addObject:acf];
    }
}

-(BOOL)hiddenNavigationBar{
    return NO;
}

-(BOOL)needGoBack{
    return YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect rect = self.navigationController.navigationBar.frame;
    float y = rect.size.height + rect.origin.y;
    self.tableView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0);
}

-(void)initView{
    
    CGFloat btnAddHeight = barHeight;
    UIButton* btnAdd = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-btnAddHeight, self.view.frame.size.width, btnAddHeight)];
    [btnAdd setTitle:@"添加新地址" forState:UIControlStateNormal];
    [btnAdd setBackgroundImage:[UIImage createImageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
    [btnAdd setBackgroundImage:[UIImage createImageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
    [self.view addSubview:btnAdd];
    [btnAdd addTarget:self action:@selector(onAddNewAddress) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITableView* tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-btnAddHeight)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)onAddNewAddress{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return addressCellFrameList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MGAddressCell* cell = [MGAddressCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AddressCellFrame* frame = addressCellFrameList[indexPath.row];
    cell.cellFrame = frame;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController* controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor redColor];
    //    [self.navigationController pushViewController:controller animated:true];
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCellFrame* frame = addressCellFrameList[indexPath.row];
    return frame.cellHeight;
}

@end
