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
#import "AddressEditController.h"
#import "AppDataTool.h"
#import "MBProgressHUD+MJ.h"

@interface AddressController()<MGAddressCellDelegate>

@end

@implementation AddressController
-(void)viewDidLoad{
    self.title = @"我的地址";
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didAddressBookUpdated:) name:NOTIFYCATION_UPDATE_ADDRESS object:nil];

    [self initView];
    addressCellFrameList = [NSMutableArray array];
    [self reloadData];
}

-(void)reloadData{
    [addressCellFrameList removeAllObjects];
    for(Recipient* r in [AppDataMemory instance].recipients){
        AddressCellFrame* acf = [[AddressCellFrame alloc]init];
        [acf setRecipient:r];
        [addressCellFrameList addObject:acf];
    }
    [self.tableView reloadData];
}

-(void)didAddressBookUpdated:(id)notifycation{
    [self reloadData];
}

-(UIScrollView *)adjustContentInsetView{
    return _tableView;
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
    [self toEditAddress:nil];
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
    cell.delegate = self;
    return cell;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCellFrame* frame = addressCellFrameList[indexPath.row];
    return frame.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCellFrame* frame = addressCellFrameList[indexPath.row];
    [self toEditAddress:frame.recipient];
}

-(void)toEditAddress:(Recipient*)r{
    
    AddressEditController* controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddressEditController"];
    controller.recipient = r;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)didAddressCellDelete:(MGAddressCell *)cell deleteRecipient:(Recipient *)recipient{
    [[AppDataMemory instance].recipients removeObject:recipient];
    [AppDataTool setAddresses:^(BOOL result) {
        if(result){
            [MBProgressHUD showSuccess:@"删除成功!"];
             [self reloadData];
        }else{
            [MBProgressHUD showError:@"删除失败!"];
        }
    } onError:^(ErrorCode errorCode) {
        [MBProgressHUD showError:@"删除出错!"];
    }];

}



@end
