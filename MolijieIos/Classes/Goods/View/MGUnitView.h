//
//  MGUnitView.h
//  MolijieIos
//
//  Created by yexifeng on 16/5/16.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompositeSKUValue.h"


#define minUnitViewWidth   60
#define unitViewHeight  30
#define marginH    15
#define marginV    10

@interface MGUnitView : UIButton
@property(nonatomic,strong)CompositeSKUValue* skuValue;

@end
