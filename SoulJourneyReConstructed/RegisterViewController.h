//
//  RegisterViewController.h
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/22.
//  Copyright © 2017年 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *passWordConfirmed;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property void(^sendValue)(NSString *value);

@end
