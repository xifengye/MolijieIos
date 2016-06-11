//
//  AreaPickerCheckView.m
//  MolijieIos
//
//  Created by yexifeng on 16/6/10.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "AreaPickerCheckView.h"
#import "AreaModel.h"

@interface AreaPickerCheckView()
{
    NSArray *provinceArray;
    NSArray *cityArray;
    NSArray *areaArray;
    void (^completionBlock)(BOOL isCancelClick , NSString *area , NSString *code);
}

@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)UIPickerView *pickerView;

@end

@implementation AreaPickerCheckView

- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSArray *)dataSource dismissCompletion:(void (^)(BOOL, NSString *, NSString *))completion
{
    self = [super initWithFrame:frame];
    if (self) {
        completionBlock = [completion copy];
        self.dataSource = dataSource;
        [self createUI];// Initialization code
    }
    return self;
}

- (void)createUI {
    
    provinceArray = self.dataSource;
    
    AreaModel *model = [self.dataSource firstObject];
    
    cityArray = model.children;
    
    AreaModel *model1 = [model.children firstObject];
    
    areaArray = model1.children;
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 25, self.frame.size.width, self.frame.size.height-25)];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self addSubview:self.pickerView];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 5, 40, 20);
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.tag = 100;
    [self addSubview:confirmBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(10, 5, 40, 20);
    cancelBtn.tag = 101;
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
    
}

#pragma mark dataSouce
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return provinceArray.count;
    }else if (component == 1) {
        return cityArray.count;
    }
    return areaArray.count;
}
#pragma mark delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    AreaModel *model = nil;
    if (component == 0) {
        model = provinceArray[row];
    }else if (component == 1) {
        model = cityArray[row];
    }else if (component == 2) {
        model = areaArray[row];
    }
    return model.value;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        AreaModel *model = provinceArray[row];
        cityArray = model.children;
        areaArray = [[cityArray firstObject] children];
        
        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
        
    }else if (component == 1) {
        AreaModel *model = cityArray[row];
        areaArray = model.children;
        [self.pickerView reloadComponent:2];
    }
}

- (void)btnClick:(UIButton *)btn {
    BOOL isCancel = NO;
    switch (btn.tag) {
        case 100:
            
            break;
        case 101:
            isCancel = YES;
            completionBlock(YES,nil,nil);
            return;
            break;
            
        default:
            break;
    }
    
    NSString *str = nil;
    NSString *codeStr = nil;
    
    AreaModel *model = provinceArray[[self.pickerView selectedRowInComponent:0]];
    str = model.value;
    AreaModel *model1 = cityArray[[self.pickerView selectedRowInComponent:1]];
    str = [str stringByAppendingString:model1.value];
    codeStr = model1.key;
    if (areaArray.count > 0) {
        AreaModel *model2 = areaArray[[self.pickerView selectedRowInComponent:2]];
        str = [str stringByAppendingString:model2.value];
        codeStr = model2.key;
    }
    
    completionBlock(isCancel,str,codeStr);
}

@end
