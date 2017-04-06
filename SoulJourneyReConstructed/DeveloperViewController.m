//
//  DeveloperViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/23.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "DeveloperViewController.h"

@interface DeveloperViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation DeveloperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"开发者信息";
    
    [self addGradientLayer];
    // Do any additional setup after loading the view from its nib.
}

- (void)addGradientLayer {
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray<NSNumber *> *locations = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *toValues = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0; i < 20; i++) {
        
        UIColor *color = [UIColor colorWithRed:(CGFloat)(arc4random_uniform(255))/255.0 green:(CGFloat)(arc4random_uniform(255))/255.0 blue:(CGFloat)(arc4random_uniform(255))/255.0 alpha:1];
        [colors addObject:color];
        CGFloat tmp = (CGFloat)i/(CGFloat)19;
        [locations addObject:[NSNumber numberWithDouble:tmp]];
        [toValues addObject:color.CGColor];
    }
    gradientLayer.locations = locations;
    gradientLayer.colors = colors;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.type = kCAGradientLayerAxial;
    
    gradientLayer.bounds = self.view.bounds;
    gradientLayer.position = self.view.center;
    gradientLayer.mask = self.nameLabel.layer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.duration = 10;
    animation.repeatCount = MAXFLOAT;
    animation.toValue = toValues;
    
    [gradientLayer addAnimation:animation forKey:@"gradientLayer"];
    [self.view.layer addSublayer:gradientLayer];
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
