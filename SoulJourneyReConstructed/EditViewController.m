//
//  EditViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/25.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "EditViewController.h"
#import <KVNProgress.h>
#import "DataModel.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;

@end

@implementation EditViewController {
    
    NSString *titleName;
    NSString *summary;
    NSString *myDate;
    DataModel *dataModel;
    NSString *notesPath;
}

- (void)setModel:(DataModel *)model {
    
    dataModel = model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    notesPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/Notes"];
    
    titleName = @"title";
    summary = @"summary";
    //dataModel = [[DataModel alloc] init];
    
    self.navigationItem.title = @"笔记";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeBtnClicked)];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (dataModel != nil) {
        
        self.summaryTextView.text = dataModel.summary;
        self.titleTextField.text = dataModel.title;
        myDate = dataModel.time;
    }
    
}

- (void)completeBtnClicked {
    
    if (![self.summaryTextView.text isEqualToString:@""]) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterLongStyle;
        formatter.timeStyle = NSDateFormatterLongStyle;
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        NSString *currentDate = [formatter stringFromDate:[[NSDate alloc] init]];
        NSData *titleData = [self.titleTextField.text dataUsingEncoding:NSUTF8StringEncoding];
        if ([self.titleTextField.text isEqualToString:@""]) {
            
            NSString *tmp = @"无标题笔记";
            titleData = [tmp dataUsingEncoding:NSUTF8StringEncoding];
        }
        NSData *summaryData = [self.summaryTextView.text dataUsingEncoding:NSUTF8StringEncoding];
        [[NSFileManager defaultManager] createFileAtPath:[notesPath stringByAppendingString:[NSString stringWithFormat:@"/%@title.text", currentDate]] contents:titleData attributes:nil];
        [[NSFileManager defaultManager] createFileAtPath:[notesPath stringByAppendingString:[NSString stringWithFormat:@"/%@summary.text", currentDate]] contents:summaryData attributes:nil];
        
        NSData *fileNameData = [[NSData alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/fileName.text", notesPath]];
        if (fileNameData != nil) {
            
            NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:[NSString stringWithFormat:@"%@/fileName.text", notesPath]];
            [handle seekToFileOffset:0];
            NSData *data = [handle readDataToEndOfFile];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            for (int i = 0; i < str.length/19; i++) {
                
                NSString *timeStr = [str substringWithRange:NSMakeRange(i*19, 19)];
                if (currentDate == timeStr) {
                    return;
                }
            }
            str = [str stringByAppendingString:currentDate];
            [[str dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[NSString stringWithFormat:@"%@/fileName.text", notesPath] atomically:YES];
        } else {
            
            [[NSFileManager defaultManager] createFileAtPath:[NSString stringWithFormat:@"%@/fileName.text", notesPath] contents:[currentDate dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        }
        
        [KVNProgress showSuccessWithStatus:@"保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        [KVNProgress showErrorWithStatus:@"请输入笔记类容"];
    }
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
