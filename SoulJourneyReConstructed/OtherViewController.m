//
//  OtherViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/25.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController {
    
    UIWebView *webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    webView.delegate = self;
    
    [self.view addSubview:webView];
    [self beginLoading];
    // Do any additional setup after loading the view.
}

-(void)beginLoading {
    
    self.navigationItem.title = self.title;
    
    if (self.url != nil) {
        
        NSString *ocStr = [self.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *urlPath = [NSURL URLWithString:ocStr];
        [webView loadRequest:[NSURLRequest requestWithURL:urlPath]];
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
