//
//  MGHomeController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/5.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "HomeController.h"

#import "AppDataTool.h"
#import "NetDataRequest.h"
#import "NetData.h"
#import "AppDataMemory.h"
#import "UIImageView+WebCache.h"
#import "AppDataTool.h"
#import "HomeCollectionViewCell.h"
#import "GoodsListController.h"

@interface HomeController ()
@property(nonatomic,weak)CycleScrollView* adScrollView;
@end



@implementation HomeController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    
   }

-(void)requestData{
    NSArray* types = @[[NetData dataWithType:HomePage param:nil],[NetData dataWithType:CataList param:nil],[NetData dataWithType:LoadAddress param:nil]];
    [[NetDataRequest requestWithTypes:^{
        NSLog(@"requestNetData finish");
        [self initViews];
    } requestType:types]start];
}

-(void)initViews{
    
    CGFloat svWidth = self.view.frame.size.width;
    CGFloat svHeight = svWidth/2.117647;
    NSMutableArray *viewsArray = [@[] mutableCopy];
    self.scorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, svWidth, svHeight) animationDuration:2];
    
    //NSArray *colorArray = @[[UIColor cyanColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor purpleColor]];
    for (int i = 0; i < [AppDataMemory instance].childs.count; ++i) {
        UIImageView *tempLabel = [[UIImageView alloc] initWithFrame:self.scorllView.bounds];
        NSString* imgId = [AppDataTool imageUrlFor:UseForAppSource withImgid:[AppDataMemory instance].rotatingAds[i].ImageID];
        [tempLabel setImageWithURL:imgId placeholderImage:[UIImage imageNamed:@"main_article_selected"]];
        [viewsArray addObject:tempLabel];
    }
    self.scorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    self.scorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.scorllView.totalPagesCount = ^NSInteger(void){
        return 5;
    };
    self.scorllView.TapActionBlock = ^(NSInteger pageIndex){
        [self onItemClicked:[AppDataMemory instance].rotatingAds[pageIndex]];
    };
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(svWidth, svHeight);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, svWidth, self.view.frame.size.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];

}



#pragma mark -- uiICollectionView


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([AppDataMemory instance].indexBlocks==nil || [AppDataMemory instance].indexBlocks.count<=0){
        return 0;
    }
    return [AppDataMemory instance].indexBlocks.count;
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
    static NSString * CellIdentifier = @"HomeCell";
     HomeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    IndexBlock* indexBlock = [AppDataMemory instance].indexBlocks[indexPath.row];
    [cell setData:indexBlock.Title imgId:indexBlock.ImageID];
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.view.frame.size.width/2-0.5;
    return CGSizeMake(width,width);
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
    
     IndexBlock *indexBlock = [[AppDataMemory instance].indexBlocks objectAtIndex:indexPath.row];
    [self onItemClicked:indexBlock];
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//添加Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    [headerView addSubview:_scorllView];
    return headerView;
}


-(void)onItemClicked:(IndexBlock*) block{
    if( [block.ReferenceType isEqualToString:Cata]){
        Childs* child = [[AppDataMemory instance]getChilds:block.CataReference];
        if(child!=nil) {
            if (child.Childs == nil || child.Childs.count <= 0) {//没有次级目录
                [self goGoodsListController:block.Title cataId:block.CataReference];
            }else{//存在次级目录
                //((BaseActivity)getActivity()).startCataList(block.Title, block.CataReference);
            }
        }
    }else if([block.ReferenceType isEqualToString:GoodItem]){
        [self goGoodsListController:block.Title cataId: block.GoodReference];
    }
    
   }

-(void)goGoodsListController:(NSString*)title cataId:(NSString*)cataId{
    
    GoodsListController* goodsListController = [[GoodsListController alloc]init];
    goodsListController.cataId = cataId;
    goodsListController.title = title;
    UINavigationController* navController = [[UINavigationController alloc]initWithRootViewController:goodsListController];

    [self presentViewController:navController animated:true completion:nil];

}


@end
