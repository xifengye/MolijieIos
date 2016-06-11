//
//  SuggestController.m
//  MolijieIos
//
//  Created by yexifeng on 16/6/10.
//  Copyright © 2016年 moregood. All rights reserved.
//

#import "SuggestController.h"
#import "AppDataTool.h"
#import "MBProgressHUD+MJ.h"
#import "Config.h"

@implementation SuggestController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(commitSuggest)];
    [self.tfContent addTarget:self action:@selector(didContentChange:) forControlEvents:UIControlEventEditingChanged];
    self.textLenLabel.text = [NSString stringWithFormat:@"%d",SUGGEST_MAX_LEN];
    self.tfContent.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
}


- (void)didContentChange:(UITextField*)textField {
    if (textField.text.length > SUGGEST_MAX_LEN) {
        textField.text = [textField.text substringToIndex:SUGGEST_MAX_LEN];
    }
    
    NSUInteger lessLen = SUGGEST_MAX_LEN - textField.text.length;
    self.textLenLabel.text = [NSString stringWithFormat:@"%ld",lessLen];
}


-(void)commitSuggest{
    if(self.tfContent.text.length>2){
        [AppDataTool commitSuggest:self.tfContent.text response:^(BOOL result) {
            if(result){
                [self success];
            }else{
                [self fail];
            }
        } onError:^(ErrorCode errorCode) {
            [self fail];
        }];
    }
}

-(void)success{
    [MBProgressHUD showSuccess:@"提交成功!"];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)fail{
    [MBProgressHUD showError:@"提交失败!"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
