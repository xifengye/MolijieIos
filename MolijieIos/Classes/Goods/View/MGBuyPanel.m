//
//  MGBuyPanel.m
//  MolijieIos
//
//  Created by yexifeng on 16/5/16.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "MGBuyPanel.h"
#import "UIImage+MG.h"
#import "Units.h"
#import "UIImageView+WebCache.h"
#import "AppDataTool.h"

@implementation MGBuyPanel

-(instancetype)initWithFrame:(CGRect)frame andGoods:(Goods*)goods{
    self = [super initWithFrame:frame];
    if(self){
        _goods = goods;
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.95f];
        CGFloat margin = 10;
        CGFloat closeBtnWidth = 50.0f;
        UIButton* btnClose = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-closeBtnWidth-margin, margin, closeBtnWidth, closeBtnWidth)];
        [btnClose setImage:[UIImage imageNamed:@"btn_close_on"] forState:UIControlStateNormal];
        [btnClose setImage:[UIImage imageNamed:@"btn_close_off"] forState:UIControlStateHighlighted];
        self.btnClose = btnClose;
        [btnClose addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btnClose];
        
        CGFloat iconViewWidth = 80;
        UIImageView* iconView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin, iconViewWidth, iconViewWidth)];
        [iconView setImage:[UIImage imageNamed:@"default_pic"]];
        self.icon= iconView;
        [self addSubview:iconView];
        
        UIFont* font = [UIFont systemFontOfSize:15];
        CGFloat labelWidth = frame.size.width-iconViewWidth-margin*3;
        CGFloat labelHeight = [@"100" sizeWithFont:font].height;
        UILabel* priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+margin, margin, labelWidth , labelHeight)];
        [priceLabel setFont:font];
        priceLabel.text = @"444.40";
        self.priceLabel = priceLabel;
        [self addSubview:priceLabel];
        
        UILabel* remineLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+margin, margin*2+labelHeight, labelWidth , labelHeight)];
        [remineLabel setFont:font];
        remineLabel.text = @"库存42件";
        self.remineLabel = remineLabel;
        [self addSubview:remineLabel];

        UILabel* unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+margin, margin*3+labelHeight*2, labelWidth , labelHeight)];
        [unitLabel setFont:font];
        self.unitLabel = unitLabel;
        unitLabel.text = @"[瓶]";
        [self addSubview:unitLabel];

        CGFloat btnOkWidth = 100;
        UIButton* btnOk = [[UIButton alloc]initWithFrame:CGRectMake((frame.size.width-btnOkWidth)/2, frame.size.height-barHeight, btnOkWidth, barHeight)];
        [btnOk setTitle:@"确定" forState:UIControlStateNormal];
        [btnOk setBackgroundImage:[UIImage createImageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        [btnOk setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
        [btnOk addTarget:self action:@selector(onOk) forControlEvents:UIControlEventTouchDown];
        btnOk.enabled = false;
        [self addSubview:btnOk];
        self.btnOk = btnOk;
    
        [self initSkuVies];
        
    }
    return self;
}

-(void)initSkuVies{
    NSMutableDictionary* unitValues = [NSMutableDictionary dictionary];
    NSDictionary* dict = [_goods getSkuByGroup];
    CGFloat maxUnitViewWidth = 0;
    if(dict.count>0){
        //初始化并计算最长的文字
        for(NSString* title in dict.allKeys){
            NSMutableArray* unitViewArr = [NSMutableArray array];
            NSArray* arr = dict[title];
            for(CompositeSKUValue * value in arr){
                MGUnitView* unitView = [[MGUnitView alloc]init];
                [unitView setSkuValue:value];
                [unitViewArr addObject:unitView];
                CGFloat textWidth = [value.Value sizeWithFont:unitView.font].width;
                if(textWidth>maxUnitViewWidth){
                    maxUnitViewWidth = textWidth;
                }
            }
            [unitValues setObject:unitViewArr forKey:title];
        }
        
        
        CGFloat x = marginH;
        CGFloat y = self.frame.size.height-barHeight-marginV-unitViewHeight;
        CGFloat width = MAX(minUnitViewWidth,maxUnitViewWidth+marginH*2);
        UIFont* titleFont = [UIFont systemFontOfSize:15];
        int i = 0;
        for(NSString* title in unitValues.allKeys){
            NSArray* unitViewArr = unitValues[title];
            for(MGUnitView* view in unitViewArr){
                [view addTarget:self action:@selector(didUnitSelected:) forControlEvents:UIControlEventTouchDown];
                view.frame = CGRectMake(x, y, width, unitViewHeight);
                [self addSubview:view];
                x+=width+marginH;
                if(x+width+marginH>self.frame.size.width){
                    x = marginH;
                    y=y-(unitViewHeight+marginV);
                }
            }
            
            CGSize titleSize = [title sizeWithFont:titleFont];
            y = y-titleSize.height-marginV;
            UILabel* skuTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginH, y , self.frame.size.width, titleSize.height)];
            skuTitleLabel.text = title;
            [self addSubview:skuTitleLabel];
            y = y-marginV;
            
            UIView* lineView = [[UIView alloc]initWithFrame:CGRectMake(0, y, self.frame.size.width, 1)];
            lineView.backgroundColor = [UIColor grayColor];
            [self addSubview:lineView];
            y=y-1-unitViewHeight-marginV;
            x=  marginH;
        }
    }
    _unitViews = unitValues;
    _unitLabel.text = [self unitTitles:nil];
}

-(void)didUnitSelected:(id)sender{
    self.btnOk.enabled = false;
    MGUnitView* unitView = (MGUnitView*)sender;
    CompositeSKUValue* csv = unitView.skuValue;
    NSArray* unitViews = _unitViews[csv.Titile];
    for(MGUnitView* view in unitViews){
        if(unitView!=view){
            view.selected=false;
        }
    }
    unitView.selected = !unitView.selected;

    //处理与选中不匹配的设置为不可点击状态
    for(NSString* title in _unitViews.allKeys){
        if(![title isEqualToString:csv.Titile]){//与自己同一组的可以不处理
            NSArray* uvs = _unitViews[title];
            for(MGUnitView* v in uvs){
                if(unitView.selected==false){//取消选中
                    v.enabled = true;
                }else{
                    v.enabled = [_goods makePair:v.skuValue other:csv];//与之配对的就可以点
                }
            }
            
        }
    }
    
    //判断是否选择完成
    NSMutableArray* selectedSku = [NSMutableArray array];
    BOOL canComplete = true;
//    NSMutableString* unitString = [NSMutableString string];
//    [unitString appendString:@"["];
    
    for(NSString* title in _unitViews.allKeys){
        NSArray* uvs = _unitViews[title];
        BOOL singleGroupComplete = false;
        for(MGUnitView* v in uvs){
            if(v.selected){//一组中只要有一个被选中就认为这一组完事了
                singleGroupComplete = true;
                [selectedSku addObject:v.skuValue];
            }
        }
        if(canComplete){//始终都有被选中才给值
            canComplete = singleGroupComplete;//只有每一组都一个被选 中才算可以完事
        }
    }
    self.btnOk.enabled = canComplete;
    if(canComplete){
        selectSkuIndex = [_goods findUnitIndex:selectedSku];
        CompositeSKUValue* _csv = selectedSku[0];
        NSString* url = [AppDataTool imageUrlFor:UseForGoodSource withImgid:_csv.Resources[0]];
        [_icon setImageWithURL:url];
        _priceLabel.text = [NSString stringWithFormat:@"￥%f",_csv.Price];
    }
     _unitLabel.text = [self unitTitles:selectedSku];

}

-(NSString*)unitTitles:(NSArray*)selectedSku{
    NSMutableString* unitString = [NSMutableString string];
    [unitString appendString:@"["];
    NSArray* titles = _unitViews.allKeys;
    for(NSString* title in titles){
        BOOL find = false;
        for(CompositeSKUValue* c in selectedSku){
            if([title isEqualToString:c.Titile]){
                [unitString appendFormat:@"%@,",c.Value];
                find = true;
            }
        }
        if(!find){
            [unitString appendFormat:@"%@,",title];
        }
    }
   [unitString replaceCharactersInRange:NSMakeRange(unitString.length-1, 1) withString:@"]"];
    return unitString;
}


-(void)onClose{
    if([self.delegate respondsToSelector:@selector(didBuyPanelCancel:)]){
        [self.delegate didBuyPanelCancel:self];
    }
}

-(void)onOk{
    if([self.delegate respondsToSelector:@selector(didBuyPanelOk:selectSkuIndex:)]){
        [self.delegate didBuyPanelOk:self selectSkuIndex:selectSkuIndex];
    }
    [self onClose];
}


@end
