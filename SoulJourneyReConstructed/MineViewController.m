//
//  MineViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/14.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "MineViewController.h"
#import "UserInfoViewController.h"
#import "LoginViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NoteViewController.h"
#import <KVNProgress.h>
#import "IdeaViewController.h"
#import "DeveloperViewController.h"
#import "AboutViewController.h"

@interface MineViewController ()


@end

@implementation MineViewController {
    
    NSArray *dataModel;
    NSArray *imageModel;
    double cacheSizeSize;
    NSString *login_or_out;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataModel = @[
                  @[@"我的记事本", @"意见反馈"],
                  @[@"关于应用", @"开发者信息"],
                  @[@"清理缓存"],
                  @[@""]
                  ];
    imageModel = @[
                   @[@"笔记", @"意见-2"],
                   @[@"关于", @"icon-开发者信息"],
                   @[@"清理缓存"],
                   ];
    
    self.navigationController.navigationBar.translucent = NO;
    //self.iconImageView.image = [UIImage imageNamed:@"Image_head"];
    self.iconImageView.layer.cornerRadius = 40.0;
    self.iconImageView.clipsToBounds = YES;
    
    //self.nameLabel.text = @"点击登录";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.sectionFooterHeight = 18;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //self.tableView.tableHeaderView = self.mineImageView;
    //login_or_out = @"登录";
    
    [self check];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self sizeCheck];
    [self check];
}

- (void)sizeCheck {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        cacheSizeSize = [self cacheSize];
        [self.tableView reloadData];
    });
}

- (void)check {
    
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"UD_LoginStatus"];
    if (isLogin) {
        
        NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"UD_CurrentUserName"];
        self.nameLabel.text = username;
        NSString *icon_url = [[NSUserDefaults standardUserDefaults] objectForKey:@"UD_UserImageUrl"];
        if ([icon_url isEqualToString:@""]) {
            
            self.iconImageView.image = [UIImage imageNamed:@"Image_head"];
        } else {
            
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:icon_url] placeholderImage:[UIImage imageNamed:@"Image_head"]];
        }
        login_or_out = @"退出当前账户";
    } else {
        
        self.iconImageView.image = [UIImage imageNamed:@"Image_head"];
        self.nameLabel.text = @"未知用户";
        login_or_out = @"登录";
    }
    [self.tableView reloadData];
}

- (IBAction)btnClicked:(id)sender {
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"UD_LoginStatus"]) {
//        
//        UserInfoViewController *userInfoVC = [[UserInfoViewController alloc] init];
//        userInfoVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:userInfoVC animated:YES];
//    } else {
//        
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        loginVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:loginVC animated:YES];
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSArray *)dataModel[section]).count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return dataModel.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ValueID = @"ValueCell";
    static NSString *DefaultID = @"DefaultCell";
    
    if (indexPath.section == 3 && indexPath.row == 0) {
        
        UITableViewCell *pCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DefaultID];
        [pCell.textLabel setFont:[UIFont fontWithName:@"Arial" size:20]];
        [pCell.textLabel setTextAlignment:NSTextAlignmentCenter];
        if ([login_or_out isEqualToString:@"登录"]) {
            
            [pCell.textLabel setTextColor:[UIColor blueColor]];
            pCell.textLabel.text = @"登录";
        } else {
            
            [pCell.textLabel setTextColor:[UIColor redColor]];
            pCell.textLabel.text = @"退出当前账户";
        }
        //pCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return pCell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ValueID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ValueID];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%0.2fM", cacheSizeSize/1024/1024];
    }
    cell.textLabel.text = dataModel[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageModel[indexPath.section][indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"UD_LoginStatus"]) {
                
                NoteViewController *noteVC = [[NoteViewController alloc] init];
                noteVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:noteVC animated:YES];
            } else {
                
                [KVNProgress showErrorWithStatus:@"请登陆"];
            }
        } else {
            
            IdeaViewController *ideaVC = [[IdeaViewController alloc] init];
            ideaVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ideaVC animated:YES];
        }
        
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            AboutViewController *aboutVC = [[AboutViewController alloc] init];
            aboutVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutVC animated:YES];
        } else {
            
            DeveloperViewController *developerVC = [[DeveloperViewController alloc] init];
            developerVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:developerVC animated:YES];
        }
    } else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            [self cleanDisk:^(NSString *feedback) {
                
                [KVNProgress showSuccessWithStatus:feedback];
                
            }];
            [self sizeCheck];
        }
    } else {
        
        if (indexPath.row == 0) {
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"UD_LoginStatus"]) { //has login
                
                UIAlertController *inoutVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *outAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"UD_LoginStatus"];
                    [self check];
                }];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [inoutVC addAction:outAction];
                [inoutVC addAction:cancelAction];
                [self presentViewController:inoutVC animated:YES completion:^{
                    
                    [tableView deselectRowAtIndexPath:indexPath animated:YES];
                }];
                
            } else { //has not login
                
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                loginVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:loginVC animated:YES];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)cleanDisk : (GetCleanInfo)block {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"清理" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSArray *filePathArray = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
        for (NSString *filePath in filePathArray) {
            
            NSString *finalPath = [NSString stringWithFormat:@"%@/%@", cachePath, filePath];
            if ([[NSFileManager defaultManager] fileExistsAtPath:finalPath]) {
                
                @try {
                    [[NSFileManager defaultManager] removeItemAtPath:finalPath error:nil];
                } @catch (NSException *exception) {
                    
                    
                } @finally {
                    
                }
            }
        }
        block(@"清理成功");
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertVC addAction:confirmAction];
    [alertVC addAction:cancelAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
    //block(@"clean test");
}

- (double)cacheSize {
    
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    double size = 0;
    
    NSArray *filePathArray = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *filePath in filePathArray) {
        
        NSString *finalPath = [NSString stringWithFormat:@"%@/%@", cachePath, filePath];
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:finalPath error:nil];
        size += [fileAttributes[NSFileSize] doubleValue];
    }
    
    return size;
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
