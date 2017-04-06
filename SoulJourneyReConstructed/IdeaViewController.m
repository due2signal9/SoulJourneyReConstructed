//
//  IdeaViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/23.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "IdeaViewController.h"
#import <KVNProgress.h>

@interface IdeaViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation IdeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendBtnClicked)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255 green:235/255 blue:241/255 alpha:1];
    // Do any additional setup after loading the view from its nib.
}

- (void)sendBtnClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
    [KVNProgress showSuccessWithStatus:@"发送成功"];
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
