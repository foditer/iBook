//
//  MessDetailViewController.m
//  单读
//
//  Created by mac on 16/2/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MessDetailViewController.h"

@interface MessDetailViewController ()

{
    UIWebView *_webView;
}

@end

@implementation MessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    TitleView *titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    titleView.title = @"消息";

    NSURL *url = [NSURL URLWithString:@"http://static.owspace.com/wap/291667.html?client=android&device_id=357566061490511&version=1.1.0&show_video=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [_webView loadRequest:request];
    [_webView addSubview:titleView];
    titleView.isTranslucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *button = [[UIButton alloc] init];
    UIImage *backImg = [UIImage imageNamed:@"back_gray"];
    backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:backImg forState:UIControlStateNormal];
    [button setContentMode:UIViewContentModeScaleAspectFit];
    [button setTintColor:[UIColor whiteColor]];
    titleView.leftBarButton = button;
    [titleView.leftBarButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_webView];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
