//
//  GoodsDetailController.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/15.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "GoodsDetailController.h"
#import "UIImageView+WebCache.h"
#import "AppDataTool.h"
#import "GoodsDetailBottomBar.h"
#import "OrderLocal.h"
#import "DataBaseManager.h"
#import "NSString+MG.h"
#import "CartController.h"


#define nameFont [UIFont systemFontOfSize:14]



@implementation GoodsDetailController


-(void)viewDidLoad{
    [super viewDidLoad];
//    [self setupNavBar];
    [self initView];
    [self initData];
    
}

-(void)initData{
    [self updateCartBadge];
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-barHeight)];
    [self.scrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_scrollView];
    
    [self initTopBar];
    [self initBottomBar];
    [self initBuyPanel];
    
    CGFloat cycleScrollViewEndY = [self initCycleScrollView];
    CGFloat textViewsEndY = [self initTextView:cycleScrollViewEndY];
    CGFloat scrollViewContentHeight = self.view.frame.size.height;
    if(textViewsEndY>scrollViewContentHeight){
        scrollViewContentHeight = textViewsEndY;
    }
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewContentHeight)];
}

-(void)initTopBar{
    UIView* topBar = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, barHeight)];
    [self.view addSubview:topBar];
    CGFloat margin = 5.0f;
    UIButton* backView = [[UIButton alloc]initWithFrame:CGRectMake(20, margin, barHeight-margin*2, barHeight-margin*2)];
    [backView setImage:[UIImage imageNamed:@"goods_back"] forState:UIControlStateNormal];
    [backView addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [topBar addSubview:backView];
    
}

-(void)initBottomBar{
    GoodsDetailBottomBar* bottomBar = [[GoodsDetailBottomBar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-barHeight, self.view.frame.size.width, barHeight)];
    self.bottomBar = bottomBar;
    bottomBar.backgroundColor = [UIColor whiteColor];
    bottomBar.delegate = self;
    [self.view addSubview:bottomBar];

}

-(void)initBuyPanel{
    CGFloat buyPanelHeight = self.view.frame.size.height-self.view.frame.size.width;
    MGBuyPanel* buyPanel = [[MGBuyPanel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, buyPanelHeight) andGoods:_goods];
    self.buyPanel = buyPanel;
    self.buyPanel.hidden = YES;
    [self.view addSubview:buyPanel];
    buyPanel.delegate = self;
}

-(CGFloat)initTextView:(CGFloat)y{
    CGFloat margin = 7.0;
    y+=margin*2;
    CGSize nameSize = [_goods.Title sizeWithFont:nameFont];
    UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, y, self.view.frame.size.width, nameSize.height)];
    nameLabel.textAlignment = UITextAlignmentCenter;
    nameLabel.text = self.goods.Title;
    [nameLabel setFont:nameFont];
    [self.scrollView addSubview:nameLabel];
    y+=nameSize.height+margin*2;
    CGSize priceSize = [@"77.77" sizeWithFont:nameFont];
    UILabel* priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, y, self.view.frame.size.width, priceSize.height)];
    priceLabel.textColor = [UIColor orangeColor];
    
    priceLabel.text = [NSString pricesString:[_goods getPrices]];
    [priceLabel setFont:nameFont];
     [self.scrollView addSubview:priceLabel];
    y+=priceSize.height+margin*2;
   
    NSArray* titles = [_goods unitTitles];
    CGSize unitSize = [@"件" sizeWithFont:nameFont];
    UILabel* unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, y, self.view.frame.size.width, unitSize.height*(titles.count+1))];
    [unitLabel setFont:nameFont];
    NSMutableString* unitTitles = [NSMutableString string];
    unitLabel.numberOfLines = titles.count+1;
    for(NSString* ut in titles){
        [unitTitles appendString:ut];
        [unitTitles appendString:@"\n"];
    }
    unitLabel.text = unitTitles;
    [self.scrollView addSubview:unitLabel];
    y+=unitLabel.frame.size.height+margin*2;

    
    CGFloat contentW = self.view.frame.size.width-margin*2;
    CGSize descriptSize = [_goods.Contants sizeWithFont:nameFont constrainedToSize:CGSizeMake(contentW, MAXFLOAT)];
    UILabel* descriptLabel = [[UILabel alloc]initWithFrame:CGRectMake(7, y, contentW, descriptSize.height)];
    [descriptLabel setFont:nameFont];
    descriptLabel.lineBreakMode = UILineBreakModeWordWrap;
    descriptLabel.numberOfLines = 0;
    descriptLabel.text = _goods.Contants;
    [self.scrollView addSubview:descriptLabel];
    y+=descriptSize.height+margin*2;
    
    return y;
}



-(CGFloat)initCycleScrollView{
    CGFloat width = self.view.frame.size.width;
    NSMutableArray *viewsArray = [@[] mutableCopy];
    self.cycleScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, width, width) animationDuration:0];
    for (int i = 0; i < self.goods.MainResources.count; ++i) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.cycleScrollView.frame];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        NSString* url = [AppDataTool imageUrlFor:UseForGoodSource withImgid:self.goods.MainResources[i]];
        [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_pic"]];
        [viewsArray addObject:imageView];
        
    }
    
    self.cycleScrollView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    self.cycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.cycleScrollView.totalPagesCount = ^NSInteger(void){
        return self.goods.MainResources.count;
    };
    self.cycleScrollView.TapActionBlock = ^(NSInteger pageIndex){
        if(!self.buyPanel.hidden){
            [self didBuyPanelCancel:nil];
            return;
        }
        [self showPhotoBrowser:pageIndex];
    };
    
    [self.scrollView addSubview:_cycleScrollView];
    return width;
}


//显示大图浏览器
-(void)showPhotoBrowser:(NSUInteger)pageIndex{
    NSUInteger count = self.goods.MainResources.count;
    NSMutableArray *photoArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; ++i) {
        MJPhoto *photoView = [[MJPhoto alloc] init];
        NSString* url = [AppDataTool imageUrlFor:UseForGoodSource withImgid:self.goods.MainResources[i]];
        photoView.url = [NSURL URLWithString:url]; // 图片路径
        [photoArray addObject:photoView];
        
    }
    // 2.显示相册
    MJPhotoBrowser* browser = [[MJPhotoBrowser alloc] init];
    browser.photos = photoArray; // 设置所有的图片
    browser.currentPhotoIndex = pageIndex; // 弹出相册时显示的第一张图片是？
    [browser show];
}

-(void)setupNavBar{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.title = _goods.Title;
    
}

-(void)goBack:(id)sender{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)showBuyPanel{
    self.buyPanel.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        CGSize viewSize = self.view.frame.size;
        _buyPanel.transform = CGAffineTransformMakeTranslation(0,-(viewSize.height-viewSize.width));
    } completion:nil];

}

-(void)hideBuyPanel{
    [UIView animateKeyframesWithDuration:0.5 delay:0.1f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        _buyPanel.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        self.buyPanel.hidden = YES;
    }];
}

-(void)scaleBackgroundView:(BOOL)isIn{
    if(isIn){
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.transform = CGAffineTransformMakeScale(0.95f, 0.95f);
        } completion:nil];

    }else{
        [UIView animateKeyframesWithDuration:0.5 delay:0.1f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            _scrollView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
}

#pragma mark BottomBarDelegate


-(void)bottomBarDidClickedCar:(GoodsDetailBottomBar *)bottomBar{
    NSLog(@"car clicked");
    [self goViewCart];
}

-(void)bottomBarDidClickedAdd:(GoodsDetailBottomBar *)bottomBar{
    NSLog(@"add clicked");
    [self showBuyPanel];
    [self scaleBackgroundView:true];
}

-(void)bottomBarDidClickedFavourite:(GoodsDetailBottomBar *)bottomBar forStatus:(BOOL)status{
    NSLog(@"favourite clicked");
}

#pragma mark BuyPanelDelegate

-(void)didBuyPanelCancel:(MGBuyPanel *)panel{
    [self hideBuyPanel];
    [self scaleBackgroundView:false];
}

-(void)didBuyPanelOk:(MGBuyPanel *)panel selectSkuIndex:(NSUInteger)skuIndex{
    self.bottomBar.btnCar.selected = true;
    [self createLocalOrder:skuIndex];
    NSLog(@"selected unitIndex = %ld",skuIndex);
}

-(void)showSettlementNow{
    CGFloat btnW = self.view.frame.size.width;
    CGFloat btnH = 40;
    CGFloat btnX = 0;
    CGFloat btnY = self.view.frame.size.height-barHeight-btnH;
    SettlementNowView* btn = [[SettlementNowView alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(onSettlementNow) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateKeyframesWithDuration:0.7 delay:3.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        btn.transform = CGAffineTransformMakeTranslation(-btnW,0);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.7 delay:3.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }];

}

//立即结算
-(void)onSettlementNow{
    NSLog(@"立即结算");
}

-(void)createLocalOrder:(NSUInteger)skuIndex{
    OrderLocal* order = [[OrderLocal alloc]init];
    order.cataId = _goods.CataID;
    order.objectId = _goods.ObjectID;
    order.skuIndex = skuIndex;
    order.amount = 1;
    NSUInteger ID =[[DataBaseManager instance]insertOrder:order];
    if(ID>0){
        [self showSettlementNow];
        [self updateCartBadge];
        [self notifyLocalOrderChange:ID];
    }
}


-(void)notifyLocalOrderChange:(NSUInteger)ID{
    [[NSNotificationCenter defaultCenter]postNotificationName:local_order_change object:[NSNumber numberWithInteger:ID]];
}

-(void)updateCartBadge{
    NSUInteger orderCount = [DataBaseManager instance].allOrder.count;
    NSString* badge = nil;
    if(orderCount>0){
        badge =  [NSString stringWithFormat:@"%ld",orderCount];
    }
    [self.bottomBar.badgeView setBadgeValue:badge];
    self.bottomBar.btnCar.selected = orderCount>0;
    
}

-(void)goViewCart{
    CartController* cartController = [[CartController alloc]init];
    cartController.navigationBarHidden = false;
    UINavigationController* navController = [[UINavigationController alloc]initWithRootViewController:cartController];
    [self presentViewController:navController animated:true completion:nil];
}

@end
