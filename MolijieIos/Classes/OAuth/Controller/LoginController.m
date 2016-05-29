//
//  SinaLoginController.m
//  SinaWeibo
//
//  Created by yexifeng on 15/11/13.
//  Copyright (c) 2015年 moregood. All rights reserved.
//

#import "LoginController.h"
#import "AppDataTool.h"
#import "SandBoxTool.h"
#import "MainController.h"
#import "MBProgressHUD+MJ.h"
#import "User.h"
#import "AppDataMemory.h"



@interface LoginController()
@property (weak, nonatomic) IBOutlet UITextField *tfUsername;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UISwitch* remenmberPassword;

@property (weak, nonatomic) IBOutlet UISwitch* autoLogin;
@end

@implementation LoginController


/*
 登录
 */
- (IBAction)onLoginClicked:(id)sender {
    [AppDataTool login:self.tfUsername.text password:self.tfPassword.text didResponse:^(Token* token) {
        NSLog(@"UserToken=%@",token.token);
        [self onLoginSuccess];
    } onError:^(ErrorCode errorCode) {
        
    }];
}

-(void)onLoginSuccess{
    [self saveUser];
    [self goMainController];
}

-(void)goMainController{
    MainController* mainController = [[MainController alloc]init];
    [self presentViewController:mainController animated:true completion:nil];
}

-(void)saveUser{
    [AppDataMemory instance].user.UserName = _tfUsername.text;
    if(_remenmberPassword.isOn){
        [AppDataMemory instance].user.password = _tfPassword.text;
        [AppDataMemory instance].user.autoLogin = _autoLogin.on;
    }
    [SandBoxTool saveUser:[AppDataMemory instance].user];

}

- (IBAction)onActiveClicked:(id)sender {
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [MBProgressHUD showMessage:@""];
    [AppDataTool requestAppToken:^(Token* token) {
        [self onAppToken];
    } onError:^(ErrorCode errorCode) {
        NSLog(@"AppTokenError=%lld",errorCode);
    }];
}

-(void)onAppToken{
    [MBProgressHUD hideHUD];
}


@end
