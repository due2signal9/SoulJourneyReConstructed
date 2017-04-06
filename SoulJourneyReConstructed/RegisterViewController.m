//
//  RegisterViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/22.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "RegisterViewController.h"
#import <KVNProgress.h>
#import <BmobSDK/Bmob.h>

@interface RegisterViewController () <UITextFieldDelegate>


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *user_iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImageView *pass_iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImageView *passC_iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImageView *email_iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    user_iconIV.image = [UIImage imageNamed:@"account"];
    pass_iconIV.image = [UIImage imageNamed:@"lock"];
    passC_iconIV.image = [UIImage imageNamed:@"lock"];
    email_iconIV.image = [UIImage imageNamed:@"email"];
    
    self.userName.leftView = user_iconIV;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    self.passWord.leftView = pass_iconIV;
    self.passWord.leftViewMode = UITextFieldViewModeAlways;
    self.passWordConfirmed.leftView = passC_iconIV;
    self.passWordConfirmed.leftViewMode = UITextFieldViewModeAlways;
    self.email.leftView = email_iconIV;
    self.email.leftViewMode = UITextFieldViewModeAlways;
    
//    self.coverImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
//    [self.view addGestureRecognizer:tapGes];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

- (void)keyBoardWasShown: (NSNotification *)notification {
    
    if (self.view.frame.origin.y != 0) {
        
        return;
    }
    [UIView beginAnimations:@"Animation" context:nil];
    
    [UIView setAnimationDuration:0.2];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-50, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

- (void)keyBoardWillBeHidden:(NSNotification *)notification {
    
    [UIView beginAnimations:@"Animation2" context:nil];
    
    [UIView setAnimationDuration:0.2];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

- (void)viewTapped {
    
    [self.view becomeFirstResponder];
}

- (IBAction)registerBtnClicked:(id)sender {
    
    if (self.passWord.text != self.passWordConfirmed.text) {
        
        [KVNProgress showErrorWithStatus:@"两次密码输入不一致"];
    } else if ([self.userName.text isEqualToString:@""] || [self.passWord.text isEqualToString:@""] || [self.passWordConfirmed.text isEqualToString:@""] || [self.email.text isEqualToString:@""]) {
        
        [KVNProgress showErrorWithStatus:@"信息不得为空"];
    } else {
        
        [KVNProgress showWithStatus:@"正在注册..."];
        
        BmobUser *user = [[BmobUser alloc] init];
        user.username = self.userName.text;
        user.password = self.passWord.text;
        user.email = self.email.text;
           
        [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
            
            if (isSuccessful) {
                
                [KVNProgress showSuccessWithStatus:@"注册成功"];
                if(self.sendValue) {
                    self.sendValue(self.userName.text);
                }
                [self.navigationController popViewControllerAnimated:YES];
            } else if (error != nil) {
                
                [KVNProgress showErrorWithStatus:[error localizedDescription]];
            } else {
                
                [KVNProgress showErrorWithStatus:@"未知错误"];
            }
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
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
