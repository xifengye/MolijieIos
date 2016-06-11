//
//  AreaPickerCheckView.h
//  MolijieIos
//
//  Created by yexifeng on 16/6/10.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaPickerCheckView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSArray *)dataSource dismissCompletion:(void (^)(BOOL isCancelClick , NSString *area , NSString *code))completion;

@end
