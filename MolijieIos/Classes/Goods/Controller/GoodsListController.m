//
//  GoodsListController.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/14.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "GoodsListController.h"
#import "AppDataTool.h"
#import "GoodsListCell.h"
#import "AppDataTool.h"
#import "AppDataMemory.h"
#import "GoodsDetailController.h"

@implementation GoodsListController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"进口葡萄酒精选 (销售中)";
    self.pageNo = 1;
    [self requestData];
    [self initViews];
    
}


-(void)requestData{
    [AppDataTool requestGoodsList:self.cataId pageNo:self.pageNo pageSize:20 response:^(NSArray<Goods *> *goodsList) {
        self.goodsList = goodsList;
        [self.collectionView reloadData];
    } onError:^(ErrorCode errorCode) {
        
    }];
}

-(void)initViews{
    
    CGFloat svWidth = self.view.frame.size.width;
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, svWidth, self.view.frame.size.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[GoodsListCell class] forCellWithReuseIdentifier:@"GoodsCell"];
}



#pragma mark -- uiICollectionView


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _goodsList.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"GoodsCell";
    GoodsListCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    Goods* goods = _goodsList[indexPath.row];
    [cell setGoods:goods];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.view.frame.size.width/2-0.5;
    return CGSizeMake(width,width+labelHeight*2);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   Goods* goods = _goodsList[indexPath.row];
    [self goGoodsDetailController:goods];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)goGoodsDetailController:(Goods*)goods{
    
    GoodsDetailController* goodsDetailController = [[GoodsDetailController alloc]init];
    goodsDetailController.goods = goods;
    [self.navigationController pushViewController:goodsDetailController animated:YES];
    
}




@end
