//
//  LoginViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/22.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "LoginViewController.h"
#import <KVNProgress.h>
#import <BmobSDK/Bmob.h>
#import "UMSocialCore/UMSocialCore.h"
#import "RegisterViewController.h"

typedef void(^result)(NSDictionary *tuple);
typedef void(^sendValue)(NSString *value);

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigation steup
    self.navigationItem.title = @"登录";
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    // Do any additional setup after loading the view from its nib.
}

- (void)registerAction {

    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.sendValue = ^(NSString *value){
        
        self.userName.text = value;
    };
    [self.navigationController pushViewController:registerVC animated:YES];
}

+ (void)bmobUserLogin: (NSString *const)userName :(NSString *const)passWord : (result)tuple {
    
    [BmobUser loginInbackgroundWithAccount:userName andPassword:passWord block:^(BmobUser *user, NSError *error) {
        
        if (user != nil) {

            NSDictionary *object = @{@"isSuccessful":@"true", @"info":@"登录成功"};
            tuple(object);
        } else {
            
            if (error.code == 404) {
                
                NSDictionary *object = @{@"isSuccessful":@"false", @"info":@"网络错误"};
                tuple(object);
            } else {
                
                NSDictionary *object = @{@"isSuccessful":@"false", @"info":@"用户名或密码错误"};
                tuple(object);
            }
        }
    }];
}

- (IBAction)loginBtnClicked:(id)sender {
    
    if (!([self.userName.text isEqualToString:@""]) || !([self.passWord.text isEqualToString:@""])) {
        
        [KVNProgress showWithStatus:@"正在登录..."];
        [LoginViewController bmobUserLogin:self.userName.text :self.passWord.text :^(NSDictionary *tuple) {
            
            if ([tuple[@"isSuccessful"] isEqualToString:@"true"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:self.userName.text forKey:@"UD_CurrentUserName"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UD_LoginStatus"];
                
                //=======================
                [self.navigationController popViewControllerAnimated:YES];
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"UD_UserImageUrl"];
                [KVNProgress showSuccessWithStatus:tuple[@"info"]];
            } else {
                
                [KVNProgress showErrorWithStatus:tuple[@"info"]];
            }
        }];
    } else {
        
        [KVNProgress showErrorWithStatus:@"账号或密码为空"];
    }
}

- (IBAction)wechatLogin:(id)sender {
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        if (error != nil) {
            
            NSLog(@"wechat login error!");
        } else {
            
            [[NSUserDefaults standardUserDefaults] setObject:resp.uid forKey:@"UD_CurrentUserName"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UD_LoginStatus"];
            [[NSUserDefaults standardUserDefaults] setObject:resp.iconurl forKey:@"UD_UserImageUrl"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
